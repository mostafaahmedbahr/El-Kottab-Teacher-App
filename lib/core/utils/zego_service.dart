import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:zego_uikit/zego_uikit.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

class ZegoService {
  static final ZegoService _instance = ZegoService._();
  factory ZegoService() => _instance;
  ZegoService._();

  final appID = int.parse(dotenv.env['ZEGO_APP_ID']!);
  final appSign = dotenv.env['ZEGO_APP_SIGN']!;

  void init({
    required String userId,
    required String userName,
    required String fcmToken,
  }) {
    final service = ZegoUIKitPrebuiltCallInvitationService();

    service.init(
      notificationConfig: ZegoCallInvitationNotificationConfig(
        androidNotificationConfig: ZegoCallAndroidNotificationConfig(
          callIDVisibility: true
        ),
        iOSNotificationConfig:ZegoCallIOSNotificationConfig(
          isSandboxEnvironment: true
        ) ,
      ),
      ringtoneConfig:  ZegoCallRingtoneConfig(
        incomingCallPath: "assets/sounds/ringTone.mp3",
      ),
      requireConfig: (ZegoCallInvitationData data) {
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
      },
      appID: appID,
      appSign: appSign,
      userID: userId,
      userName: userName,
      plugins: [ZegoUIKitSignalingPlugin()],
    );

    // /// ⭐ أهم سطر للمكالمات المغلقة
    // service.setPushConfig(
    //   resourceID: "zego_push",
    //   pushToken: fcmToken,
    // );
  }

  void unInit() {
    ZegoUIKitPrebuiltCallInvitationService().uninit();
  }
}
