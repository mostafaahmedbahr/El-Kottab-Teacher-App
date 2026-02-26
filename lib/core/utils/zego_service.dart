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
            showOnFullScreen: true,
            showOnLockedScreen: true,
            channelID: "zego_call_channel",
            channelName: "Zego Calls",
          ),
          iOSNotificationConfig: ZegoCallIOSNotificationConfig(
            isSandboxEnvironment: true,
          ),
        ),
        config: ZegoCallInvitationConfig(
          endCallWhenInitiatorLeave: true,
          permissions: [
            ZegoCallInvitationPermission.microphone,
            ZegoCallInvitationPermission.camera,
          ],
          pip: ZegoCallInvitationPIPConfig(),
          inCalling: ZegoCallInvitationInCallingConfig(
            // // Ensure proper cleanup when leaving call
            // endCallAfterLeaving: true,
          ),
          // missedCall: ZegoCallInvitationMissedCallConfig(
          //   enabled: true,
          //   enableDialBack: true,
          //   resourceID: "zego_push",
          // ),
          systemWindowConfirmDialog: ZegoCallSystemConfirmDialogConfig(),
          offline: ZegoCallInvitationOfflineConfig(
            autoEnterAcceptedOfflineCall: false,
          ),
        ),
        requireConfig: (ZegoCallInvitationData data) {
          print("ddddddddddddddsfgsdgsdfg");
          print('📞 Incoming call data: ${data.toString()}');
          print(
            '📞 Inviter: ${data.inviter?.name ?? "Unknown"} (${data.inviter?.id ?? "Unknown"})',
          );
          print(
            '📞 Invitees: ${data.invitees.map((e) => e.name ?? "Unknown").toList()}',
          );

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

            // Set the caller name in the config if available
            if (data.inviter?.name?.isNotEmpty == true) {
              print('📞 Setting caller name: ${data.inviter?.name}');
              // You can customize the UI to show the caller name
            }

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
        ringtoneConfig: ZegoCallRingtoneConfig(),
        uiConfig: ZegoCallInvitationUIConfig(
          inviter:ZegoCallInvitationInviterUIConfig(
            showAvatar: true,
            showCentralName: true,
            showMainButtonsText: true,
            showCallingText: true,
            showSubButtonsText: true,
            useVideoViewAspectFill: true,
          ),
          invitee: ZegoCallInvitationInviteeUIConfig(
            showAvatar: true,
            showCentralName: true,
            showMainButtonsText: true,
            showCallingText: true,
            showVideoOnCalling: true,
            showSubButtonsText: true,
            useVideoViewAspectFill: true,
          ),
        ),
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
