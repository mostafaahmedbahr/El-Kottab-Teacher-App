import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:zego_uikit/zego_uikit.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

class ZegoService {
  static final ZegoService _instance = ZegoService._();
  factory ZegoService() => _instance;
  ZegoService._();

  final appID = int.parse(dotenv.env['ZEGO_APP_ID'] ?? '1234567890');
  final appSign = dotenv.env['ZEGO_APP_SIGN'] ?? 'your_app_sign_here';

  Future<void> init({
    required String userId,
    required String userName,
    required String fcmToken,
  }) async {
    try {
      print(
        '🔔 ZegoService Init - UserID: $userId, UserName: $userName, FCM: $fcmToken',
      );

      // First initialize ZegoUIKit
      await ZegoUIKit().init(appID: appID, appSign: appSign);
      print('✅ ZegoUIKit initialized');

      // Then initialize the invitation service
      final service = ZegoUIKitPrebuiltCallInvitationService();

      await service.init(
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
        requireConfig: (ZegoCallInvitationData data) {
          print('📞 Incoming call data: ${data.toString()}');
          try {
            var config = (data.invitees.length > 1)
                ? ZegoCallInvitationType.videoCall == data.type
                      ? ZegoUIKitPrebuiltCallConfig.groupVideoCall()
                      : ZegoUIKitPrebuiltCallConfig.groupVoiceCall()
                : ZegoCallInvitationType.videoCall == data.type
                ? ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
                : ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall();

            // Modify your custom configurations here.
            config.layout = ZegoLayout.gallery(
              addBorderRadiusAndSpacingBetweenView: false,
            );
            return config;
          } catch (e) {
            print('❌ Error in requireConfig: $e');
            // Return a default config if there's an error
            return ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall();
          }
        },
        appID: appID,
        appSign: appSign,
        userID: userId,
        userName: userName,
        plugins: [ZegoUIKitSignalingPlugin()],
      );

      print('✅ ZegoService initialized successfully');
    } catch (e) {
      print('❌ Error initializing ZegoService: $e');
      rethrow;
    }
  }

  void unInit() {
    try {
      ZegoUIKitPrebuiltCallInvitationService().uninit();
      ZegoUIKit().uninit();
      print('✅ ZegoService uninitialized successfully');
    } catch (e) {
      print('❌ Error uninitializing ZegoService: $e');
    }
  }
}
