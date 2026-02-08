import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:zego_uikit/zego_uikit.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

import 'core/app_services/remote_services/service_locator.dart';
import 'core/utils/bloc_observer.dart';
import 'core/utils/zego_service.dart';
import 'lang/codegen_loader.g.dart';
import 'main_imports.dart';
import 'my_app.dart';
final GlobalKey<NavigatorState> navigateKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await dotenv.load(fileName: ".env");
   await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  await CacheHelper.init();
  //
 await _initFirebaseMessaging();
  String? token = await CacheTokenManger.getUserToken();
  debugPrint("Retrieved token: $token");
  setup();
  Bloc.observer = MyBlocObserver();
  /// zego
  ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigateKey);
  ZegoService().init(
    userId: CacheHelper.getData(key: "userId").toString(),
    userName:  CacheHelper.getData(key: "userName").toString(),
    fcmToken: CacheHelper.getData(key: "fcmToken").toString(),

  );
  WidgetsBinding.instance.addPostFrameCallback((_) {
    /// all time-consuming and waiting operations are DONE!!
    /// jump to call page page if app active by offline call
    ZegoUIKitPrebuiltCallInvitationService().enterAcceptedOfflineCall();
  });
  await ZegoUIKit().initLog().then((value) async {
    await ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI(
      [ZegoUIKitSignalingPlugin()],
    );
    runApp(
      EasyLocalization(
        startLocale: const Locale('ar', ''),
        supportedLocales: const [
          Locale('ar', ''),
          Locale('en', ''),
        ],
        path: 'lib/lang',
        saveLocale: true,
        fallbackLocale: const Locale('en', ''),
        useOnlyLangCode: true,
        assetLoader: const CodegenLoader(),
        child: const MyApp(),
      ),
    );

  });

}

Future<void> _initFirebaseMessaging() async {
  final messaging = FirebaseMessaging.instance;

  /// طلب صلاحيات الإشعارات
  await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  /// إظهار الإشعار أثناء فتح التطبيق (iOS)
  await messaging.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  /// iOS فقط – تأكد إن APNS Token اتولد
  if (Platform.isIOS) {
    String? apnsToken;
    int retry = 0;

    while (apnsToken == null && retry < 5) {
      apnsToken = await messaging.getAPNSToken();
      retry++;
      await Future.delayed(const Duration(seconds: 1));
    }

    if (apnsToken == null) {
      log('❌ APNS Token لم يتم إنشاؤه');
      return;
    }

    log('✅ APNS Token: $apnsToken');
  }

  /// الحصول على FCM Token (المهم فعلاً)
  final fcmToken = await messaging.getToken();
  if (fcmToken != null) {
    log('✅ FCM Token: $fcmToken');
    CacheHelper.saveData(key: 'fcmToken', value: fcmToken);
  }

  /// تحديث التوكن تلقائيًا
  FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
    log('🔄 FCM Token Refreshed: $newToken');
    CacheHelper.saveData(key: 'fcmToken', value: newToken);
  });

  /// استقبال الإشعار أثناء فتح التطبيق
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    log('📩 Foreground message received');
  });

  /// عند الضغط على الإشعار
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    log('📲 Notification clicked');
  });

  /// الاشتراك في topic
  await messaging.subscribeToTopic('all');
}
