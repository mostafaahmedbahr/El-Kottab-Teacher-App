import 'package:easy_localization/easy_localization.dart';
import 'package:el_kottab_teacher_app/features/home/presentation/views/home_view.dart';
import 'package:el_kottab_teacher_app/features/profile/presentation/views/profile_view.dart';
import '../../../../main_imports.dart';
import '../../../appointments/presentation/views/appointments_view.dart';
import '../../../call_log/presentation/views/call_log_view.dart';
import '../../../reviews/presentation/views/reviews_view.dart';
import '../../data/models/rate_student_model.dart';
import '../../data/repos/layout_repo.dart';
import 'layout_states.dart';
import 'package:zego_uikit/zego_uikit.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import '../../../../core/utils/zego_service.dart';
import '../../../../main.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit(this.layoutRepo) : super(LayoutInitState());
  final LayoutRepo? layoutRepo;
  static LayoutCubit get(context) => BlocProvider.of(context);


  Future<void> initializeZegoServices(userName,userId,fcmToken) async {
    try {
      debugPrint('🎯 Initializing Zego services...');

      // Set navigator key for Zego
      ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigateKey);

      // Disable Zego debug logging to prevent getNetworkTimeInfo spam
      // This reduces the log level from Debug to Info
      await ZegoUIKit().initLog();

      // Use system calling UI with signaling plugin
      await ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI([
        ZegoUIKitSignalingPlugin(),
      ]);

      // Get user data from cache


      // Handle empty/null userName
      if (userName.isEmpty || userName == "null") {
        userName = "Teacher";
      }

      debugPrint('👤 Zego User Data:');
      debugPrint('   UserID: $userId');
      debugPrint('   UserName: $userName');
      debugPrint('   FCM Token: $fcmToken');

      // Initialize Zego service using original working ZegoService
      ZegoService().init(userId: userId, userName: userName, fcmToken: fcmToken);

      // Handle offline calls after app is ready
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ZegoUIKitPrebuiltCallInvitationService().enterAcceptedOfflineCall();
      });

      debugPrint('✅ Zego services initialized successfully');
    } catch (e) {
      debugPrint('❌ Error initializing Zego services: $e');
    }
  }


  static int pageIndex = 0;

  List screens = [
    HomeView(),
    CallLogView(),
    AppointmentsView(),
    ReviewsView(),
    ProfileView(),
  ];

  changeBottomNav(index, context) {
    pageIndex = index;
    emit(ChangeBottomNavState());
  }

  DateTime? _lastPressed;
  void onPopInvoked(bool didPop, BuildContext context) {
    if (didPop) {
      return;
    }
    if (pageIndex == 0) {
      DateTime now = DateTime.now();
      if (_lastPressed == null ||
          now.difference(_lastPressed!) > const Duration(seconds: 2)) {
        _lastPressed = now;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(LangKeys.exit.tr()),
            duration: const Duration(seconds: 2),
          ),
        );
      } else {
        SystemNavigator.pop();
      }
    } else {
      changeBottomNav(0, context);
    }
  }



  RateStudentModel? rateStudentModel;

  Future<void> rateStudent({
    required dynamic comment,
    required dynamic rate,
    required dynamic targetId,
  }) async {
    emit(RateStudentLoadingState());
    var result = await layoutRepo!.rateStudent(
      comment: comment,
      rate: rate,
      targetId: targetId,
    );
    result.fold((failure) => emit(RateStudentErrorState(failure.errMessage)), (
        data,
        ) {
      rateStudentModel = data;
      emit(RateStudentSuccessState(data));
    });
  }

}
