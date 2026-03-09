import 'package:el_kottab_teacher_app/core/utils/rate_student_dialog.dart';
import 'package:el_kottab_teacher_app/features/layout/presentation/view_model/layout_cubit.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:zego_uikit/zego_uikit.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

import '../../main.dart';
import '../../main_imports.dart';
import '../extensions/log_util.dart';

class ZegoService {
  static final ZegoService _instance = ZegoService._();

  factory ZegoService() => _instance;

  ZegoService._();

  final appID = int.parse(dotenv.env['ZEGO_APP_ID'] ?? '1234567890');
  final appSign = dotenv.env['ZEGO_APP_SIGN'] ?? 'your_app_sign_here';
  BuildContext? get _context => navigateKey.currentContext;
  Future<void> init({
    required String userId,
    required String userName,
    required String fcmToken,
  }) async {
    try {
      logWarning(
        '🔔 ZegoService Init - UserID: $userId, UserName: $userName, FCM: $fcmToken',
      );

      // First initialize ZegoUIKit
      await ZegoUIKit().init(appID: appID, appSign: appSign);
      logSuccess('✅ ZegoUIKit initialized');

      // Then initialize the invitation service
      final service = ZegoUIKitPrebuiltCallInvitationService();

      await service.init(
        events : ZegoUIKitPrebuiltCallEvents(
          onCallEnd:
              (ZegoCallEndEvent event,

              /// defaultAction to return to the previous page or hide the minimize page
              VoidCallback defaultAction,) {
            logSuccess(
              "Call ended: ${event.callID}, reason: ${event.reason}",
            );
            // Call the default action first to ensure proper UI cleanup
            defaultAction();
            // final inviter = event.invitationData?.inviter ?? [];
            // final student = inviter;

            showDialog(
              context: _context!,
              barrierDismissible: false,
              builder: (_) =>
                  RateStudentDialog(
                    studentId: event.invitationData!.inviter!.id,
                    studentName: event.invitationData!.inviter!.name,
                    onSubmit: (rating, message) {
                      _context?.read<LayoutCubit>().rateStudent(
                        rate: rating,
                        comment: message,
                        targetId: event.invitationData!.inviter!.id.toString(),
                      );
                    },
                  ),
            );
          },
        ),
        notificationConfig: ZegoCallInvitationNotificationConfig(
          androidNotificationConfig: ZegoCallAndroidNotificationConfig(
            callIDVisibility: true,
            showOnFullScreen: true,
            showOnLockedScreen: true,
            // channelID: "zego_call_channel",
            // channelName: "Zego Calls",
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
          debugPrint('📞 Incoming call data: ${data.toString()}');
          debugPrint(
            '📞 Inviter: ${data.inviter?.name ?? "Unknown"} (${data.inviter?.id ?? "Unknown"})',
          );
          debugPrint(
            '📞 Invitees: ${data.invitees.map((e) => e.name ).toList()}',
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
            config.background = Container(
              color: AppColors.darkOlive,
            );
            config.bottomMenuBar.hideAutomatically = false;
            config.bottomMenuBar.buttons = [
               ZegoCallMenuBarButtonName.toggleMicrophoneButton,
              // ZegoCallMenuBarButtonName.toggleCameraButton,
              // ZegoCallMenuBarButtonName.switchCameraButton,
              ZegoCallMenuBarButtonName.hangUpButton,
            ];
            // config.foreground = Container(
            //   color: AppColors.darkOlive,
            // );
            config.enableAccidentalTouchPrevention=false;
            config.bottomMenuBar.margin = const EdgeInsets.only(bottom: 20);
            config.bottomMenuBar.padding = const EdgeInsets.symmetric(horizontal: 20);
            config..topMenuBar.height = 100
              ..topMenuBar.padding = const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 0,
              )
              ..topMenuBar.margin = const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 0,
              )
              ..topMenuBar.backgroundColor = Colors.red.withValues(alpha: 0.2);
            // Set the caller name in the config if available
            if (data.inviter?.name.isNotEmpty == true) {
              debugPrint('📞 Setting caller name: ${data.inviter?.name}');
              // You can customize the UI to show the caller name
            }

            return config;
          } catch (e) {
            logError('❌ Error in requireConfig: $e');
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

      logSuccess('✅ ZegoService initialized successfully');
    } catch (e) {
      logError('❌ Error initializing ZegoService: $e');
      rethrow;
    }
  }

  void unInit() {
    try {
      ZegoUIKitPrebuiltCallInvitationService().uninit();
      ZegoUIKit().uninit();
      logSuccess('✅ ZegoService uninitialized successfully');
    } catch (e) {
      logError('❌ Error uninitializing ZegoService: $e');
    }
  }
}