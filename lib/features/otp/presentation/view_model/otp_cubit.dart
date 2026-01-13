import 'dart:async';

import '../../../../main_imports.dart';
import '../../../forget_password/data/models/verify_reset_otp_model.dart';
import '../../data/models/resend_otp_model.dart';
import '../../data/models/verify_otp_model.dart';
import '../../data/repos/otp_repo.dart';
import 'otp_states.dart';

class OtpCubit extends Cubit<OtpStates> {
  final OtpRepo? otpRepo;
  dynamic verifyOtpModel;
  dynamic verifyResetOtpModel;
  static OtpCubit get(context) => BlocProvider.of(context);

  OtpCubit(this.otpRepo) : super(OtpInitState()) {
    // بدء التايمر تلقائياً عند إنشاء الكيوبت
    WidgetsBinding.instance.addPostFrameCallback((_) {
      startOtpTimer();
    });
  }

  Future<void> verifyOtp({
    required String otpCode,
    required String email,
    required String screenName,
  }) async {
    emit(VerifyOtpLoadingState());
    final result = await otpRepo!.verifyOtp(
      otpCode: otpCode,
      email: email,
      screenName:screenName
    );
    result.fold(
          (failure) {
        emit(VerifyOtpErrorState(failure.errMessage));
      },
          (data) {
            if(screenName=="ForgetPasswordView"){
              verifyResetOtpModel = data ;
            }else{
              verifyOtpModel = data;
              cacheUserInfo(
                token: "${data.data!.token}",
                phone: data.data!.phone.toString(),
                id: data.data!.id!,
                email: "${data.data!.email}",
              );

            }
            emit(VerifyOtpSuccessState(data));

      },
    );
  }

  ResendOtpModel? resendOtpModel;

  Future<void> resendOtp({
    required String email,
  }) async {
    emit(ResendOtpLoadingState());
    final result = await otpRepo!.resendOtp(
      email: email,
    );
    result.fold(
          (failure) => emit(ResendOtpErrorState(failure.errMessage)),
          (data) {
        resendOtpModel = data;
        emit(ResendOtpSuccessState(data));
        // بدء التايمر من جديد بعد إعادة الإرسال
        startOtpTimer();
      },
    );
  }

  Timer? timer;
  int secondsRemaining = 0;
  bool isTimerActive = false;

  void startOtpTimer({int seconds = 180}) {
    timer?.cancel();
    secondsRemaining = seconds;
    isTimerActive = true;
    emit(OtpTimerTickState(secondsRemaining));

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining <= 1) {
        timer.cancel();
        isTimerActive = false;
        emit(OtpTimerFinishedState());
      } else {
        secondsRemaining--;
        emit(OtpTimerTickState(secondsRemaining));
      }
    });
  }

  void resetOtpTimer() {
    startOtpTimer();
  }

  void cancelOtpTimer() {
    timer?.cancel();
    isTimerActive = false;
  }

  @override
  Future<void> close() {
    cancelOtpTimer();
   emailCon.dispose();
    return super.close();
  }

  cacheUserInfo({
    required String token,
    required String phone,
    required int id,
    required String email,
  }) async {
    await CacheTokenManger.saveUserToken(token);
    CacheHelper.saveData(key: "userPhone", value: phone);
    CacheHelper.saveData(key: "userId", value: id);
    CacheHelper.saveData(key: "userEmail", value: email);
  }

  var emailCon = TextEditingController();
}