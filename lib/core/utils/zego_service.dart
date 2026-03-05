import 'dart:async';

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

  BuildContext? get _context => navigateKey.currentContext;
  final appID = int.parse(dotenv.env['ZEGO_APP_ID'] ?? '0');
  final appSign = dotenv.env['ZEGO_APP_SIGN'] ?? '';

  DateTime? _startTime;
  Timer? _checkerTimer;
  bool _isInitialized = false;
  String? _currentCallID;
  ZegoCallUser? _currentStudent;

  // الحساب بالدقائق للـ API
  int get callMinutes {
    if (_startTime == null) return 0;
    final duration = DateTime.now().difference(_startTime!);
    return (duration.inSeconds / 60).ceil();
  }

  // الحساب بالثواني للمقارنة الدقيقة مع الرصيد
  int get callSeconds {
    if (_startTime == null) return 0;
    return DateTime.now().difference(_startTime!).inSeconds;
  }

  void _startCallTimer(String callID, ZegoCallUser student) {
    _startTime = DateTime.now();
    _currentCallID = callID;
    _currentStudent = student;
    _checkerTimer?.cancel();
    _checkerTimer = Timer.periodic(const Duration(seconds: 1), (_) {
        logWarning("Balance finished! Forced hang up.");
        // 1. أغلق المكالمة فوراً
        ZegoUIKitPrebuiltCallController().hangUp(_context!, showConfirmation: false);
        // 2. إيقاف التايمر
        _stopCallTimer();
        // 3. تأخير بسيط جداً لضمان خروج شاشة Zego قبل فتح التقييم (بيحل الشاشة السوداء)
        Future.delayed(const Duration(milliseconds: 500), () {
          _handleCallEndLogic(_currentCallID ?? "", _currentStudent);
        });

    });
  }

  void _stopCallTimer() {
    _checkerTimer?.cancel();
    _checkerTimer = null;
  }


  void _handleCallEndLogic(String callID, dynamic student) {
    if (_startTime == null) return;
    final finalMinutes = callMinutes;
    logSuccess("Handling End Logic. Minutes: $finalMinutes");
    if (student != null && _context != null) {
      // ✅ التأكد من أن الـ Context لا يزال صالحاً قبل فتح الديالوج
      showDialog(
        context: _context!,
        barrierDismissible: false, // لضمان إتمام عملية التقييم أو الإغلاق
        builder: (_) => RateStudentDialog(
          studentId: student.id,
          studentName: student.name,
          onSubmit: (rating, message) {
            _context?.read<LayoutCubit>().rateStudent(
              rate: rating,
              comment: message,
              targetId: student.id.toString(),
            );
          },
        ),
      );

      _context?.read<LayoutCubit>().endCall(
        durationMinutes: finalMinutes,
        roomId: callID,
        context: _context!,
      );
    }

    _startTime = null;
  }
///
  Future<void> init({
    required String userId,
    required String userName,
    required String fcmToken,
  }) async {
    if (_isInitialized) return;
    _isInitialized = true;
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
          user: ZegoCallUserEvents(
            onLeave: (user) {
              print("000000000000000000000000000000000 user leave 000000000000000000000000000000000");
              final currentUsers = ZegoUIKit().getAllUsers();
              if (currentUsers.length <= 1 && _startTime != null) {
                logWarning("Other party disconnected!");
                ZegoUIKitPrebuiltCallController()
                    .hangUp(_context!, showConfirmation: false);
                _stopCallTimer();
                Future.delayed(const Duration(milliseconds: 500), () {
                  _handleCallEndLogic(_currentCallID ?? "", _currentStudent);
                });
              }
            },
          ),
          onCallEnd:
              (ZegoCallEndEvent event,

              /// defaultAction to return to the previous page or hide the minimize page
              VoidCallback defaultAction,) {
            logSuccess(
              "Call ended: ${event.callID}, reason: ${event.reason}",
            );
            // Call the default action first to ensure proper UI cleanup
            defaultAction();
            final invitees = event.invitationData?.invitees ?? [];
            if (invitees.isEmpty) {
              logWarning("No invitees found in call end event");
              return;
            }
            final student = invitees.first;

            showDialog(
              context: _context!,
              builder: (_) =>
                  RateStudentDialog(
                    studentId: student.id,
                    studentName: student.name,
                    onSubmit: (rating, message) {
                      _context?.read<LayoutCubit>().rateStudent(
                        rate: rating,
                        comment: message,
                        targetId: student.id.toString(),
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
              ZegoCallMenuBarButtonName.toggleCameraButton,
              ZegoCallMenuBarButtonName.switchCameraButton,
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
