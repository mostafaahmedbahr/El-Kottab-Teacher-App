import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:zego_uikit/zego_uikit.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import '../core/app_services/local_services/cache_helper.dart';

class ZegoInitService {
  static final ZegoInitService _instance = ZegoInitService._internal();
  factory ZegoInitService() => _instance;
  ZegoInitService._internal();
  final appID = int.parse(dotenv.env['ZEGO_APP_ID']!);
  final appSign = dotenv.env['ZEGO_APP_SIGN']!;
  Future<void> initializeZego(GlobalKey<NavigatorState> navigateKey) async {
    try {
      debugPrint('🎯 Initializing Zego services...');

      // Set navigator key for Zego
      ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigateKey);

      // Initialize Zego log
      await ZegoUIKit().initLog();

      // Use system calling UI with signaling plugin
      await ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI([
        ZegoUIKitSignalingPlugin(),
      ]);

      // Get user data from cache
      String userId = CacheHelper.getData(key: "userId").toString();
      String userName = CacheHelper.getData(key: "userName").toString();
      String fcmToken = CacheHelper.getData(key: "fcmToken").toString();

      // Handle empty/null userName
      if (userName.isEmpty || userName == "null") {
        userName = "Teacher";
      }

      debugPrint('👤 Zego User Data:');
      debugPrint('   UserID: $userId');
      debugPrint('   UserName: $userName');
      debugPrint('   FCM Token: $fcmToken');

      // Initialize Zego call invitation service
      if (userId.isNotEmpty && userId != "null") {
        final service = ZegoUIKitPrebuiltCallInvitationService();

        service.init(
          notificationConfig: ZegoCallInvitationNotificationConfig(
            androidNotificationConfig: ZegoCallAndroidNotificationConfig(
              callIDVisibility: true,
              channelID: "zego_call_channel",
              channelName: "Zego Calls",
            ),
            iOSNotificationConfig: ZegoCallIOSNotificationConfig(
              isSandboxEnvironment: true,
            ),
          ),
          ringtoneConfig: ZegoCallRingtoneConfig(
            // Temporarily disable ringtone to test audio session issue
            // incomingCallPath: "assets/sounds/ringTone.mp3",
          ),
          requireConfig: (ZegoCallInvitationData data) {
            debugPrint('📞 Incoming call data: ${data.toString()}');
            try {
              var config = (data.invitees.length > 1)
                  ? ZegoCallInvitationType.videoCall == data.type
                        ? ZegoUIKitPrebuiltCallConfig.groupVideoCall()
                        : ZegoUIKitPrebuiltCallConfig.groupVoiceCall()
                  : ZegoCallInvitationType.videoCall == data.type
                  ? ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
                  : ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall();

              config.layout = ZegoLayout.gallery(
                addBorderRadiusAndSpacingBetweenView: false,
              );
              return config;
            } catch (e) {
              debugPrint('❌ Error in requireConfig: $e');
              return ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall();
            }
          },
          appID: appID, // Replace with your actual app ID
          appSign: appSign, // Replace with your actual app sign
          userID: userId,
          userName: userName,
          plugins: [ZegoUIKitSignalingPlugin()],
        );

        debugPrint('✅ Zego call invitation service initialized');
      } else {
        debugPrint('❌ Cannot initialize Zego - missing user ID');
      }

      debugPrint('✅ Zego services initialized successfully');
    } catch (e) {
      debugPrint('❌ Error initializing Zego services: $e');
    }
  }

  void handleOfflineCall() {
    try {
      debugPrint('📞 Handling offline call...');
      ZegoUIKitPrebuiltCallInvitationService().enterAcceptedOfflineCall();
      debugPrint('✅ Offline call handled successfully');
    } catch (e) {
      debugPrint('❌ Error handling offline call: $e');
    }
  }

  Future<void> refreshZegoInitialization() async {
    try {
      debugPrint('🔄 Refreshing Zego initialization...');

      // Get updated user data
      String userId = CacheHelper.getData(key: "userId").toString();
      String userName = CacheHelper.getData(key: "userName").toString();
      String fcmToken = CacheHelper.getData(key: "fcmToken").toString();

      if (userName.isEmpty || userName == "null") {
        userName = "Teacher";
      }

      debugPrint('👤 Refreshed Zego User Data:');
      debugPrint('   UserID: $userId');
      debugPrint('   UserName: $userName');
      debugPrint('   FCM Token: $fcmToken');

      debugPrint('✅ Zego initialization refreshed successfully');
    } catch (e) {
      debugPrint('❌ Error refreshing Zego initialization: $e');
    }
  }
}
