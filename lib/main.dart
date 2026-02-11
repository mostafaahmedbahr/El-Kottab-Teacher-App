import 'dart:developer';
import 'dart:io';
import 'package:el_kottab_teacher_app/services/zego_init_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/app_services/remote_services/service_locator.dart';
import 'core/utils/bloc_observer.dart';
import 'core/app_services/local_services/cache_helper.dart';
import 'core/utils/zego_service.dart';
import 'services/call_notification_service.dart';
// import 'services/firebase_call_service.dart'; // TODO: Re-enable after fixing Gradle
// import 'services/zego_init_service.dart'; // Using original ZegoService instead
import 'lang/codegen_loader.g.dart';
import 'main_imports.dart';
import 'my_app.dart';
import 'package:zego_uikit/zego_uikit.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import 'package:zego_zpns/zego_zpns.dart';

Future<void> _requestPermissions() async {
  await [
    Permission.microphone,
    Permission.camera,
    Permission.notification,
    Permission.systemAlertWindow,
  ].request();
}

final GlobalKey<NavigatorState> navigateKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _requestPermissions();

  // Configure ZPNS for FCM
  try {
    ZPNsConfig zpnsConfig = ZPNsConfig();
    zpnsConfig.enableFCMPush; // Enable Google push notification channel
    // Note: ZPNsManager may need to be imported or configured differently
    debugPrint('✅ ZPNS configured for FCM');
  } catch (e) {
    debugPrint('❌ Error configuring ZPNS: $e');
  }

  // TODO: Re-enable Firebase Call Service after fixing Gradle
  // await FirebaseCallService().initialize();

  await dotenv.load(fileName: ".env");

  // Initialize Firebase
  await Firebase.initializeApp();

  // Configure Firebase Messaging
  await _configureFirebaseMessaging();

  // Initialize cache and services
  await CacheHelper.init();
  String? token = await CacheTokenManger.getUserToken();
  debugPrint("Retrieved token: $token");

  await EasyLocalization.ensureInitialized();
  setup();
  Bloc.observer = MyBlocObserver();

  // Initialize call notification service
  CallNotificationService().initialize();

  // Initialize Zego services
  await _initializeZegoServices();

  // Run the app
  runApp(
    EasyLocalization(
      startLocale: const Locale('en', ""),
      supportedLocales: const [Locale('ar', ""), Locale('en', "")],
      path: 'lib/lang',
      saveLocale: true,
      fallbackLocale: const Locale('en', ""),
      useOnlyLangCode: true,
      assetLoader: const CodegenLoader(),
      child: MyApp(navigatorKey: navigateKey),
    ),
  );
}

Future<void> _configureFirebaseMessaging() async {
  try {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

    await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('📩 Foreground FCM message: ${message.notification?.title}');
      if (message.notification != null) {
        debugPrint('   Title: ${message.notification?.title}');
        debugPrint('   Body: ${message.notification?.body}');
      }
    });

    // Handle messages when app is opened from notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint(
        '📱 App opened from notification: ${message.notification?.title}',
      );
    });

    // Subscribe to topics
    FirebaseMessaging.instance.subscribeToTopic('all');

    // Get and save FCM token
    final fcmToken = await FirebaseMessaging.instance.getToken();
    if (fcmToken != null) {
      await CacheHelper.saveData(key: "fcmToken", value: fcmToken);
      debugPrint('🔔 FCM Token saved: $fcmToken');
    }

    // Listen for token refresh
    FirebaseMessaging.instance.onTokenRefresh
        .listen((newToken) {
          debugPrint('🔄 FCM Token refreshed: $newToken');
          CacheHelper.saveData(key: "fcmToken", value: newToken);
        })
        .onError((err) {
          debugPrint('❌ FCM token refresh error: $err');
        });

    debugPrint('✅ Firebase Messaging configured successfully');
  } catch (e) {
    debugPrint('❌ Error configuring Firebase Messaging: $e');
  }
}

Future<void> _initializeZegoServices() async {
  try {
    debugPrint('🎯 Initializing Zego services...');

    // Initialize Zego using the dedicated service
    await ZegoInitService().initializeZego(navigateKey);

    // Handle offline calls after app is ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ZegoInitService().handleOfflineCall();
    });

    debugPrint('✅ Zego services initialized successfully');
  } catch (e) {
    debugPrint('❌ Error initializing Zego services: $e');
  }
}
