import '../../../../main_imports.dart';
import '../../data/models/forgot_password_by_email_model.dart';
import '../../data/models/reset_password_model.dart';
import '../../data/models/verify_reset_otp_model.dart';
import '../../data/repos/forget_password_repo.dart';
import 'forget_password_states.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordStates> {

  static ForgetPasswordCubit get(context) => BlocProvider.of(context);
  ForgetPasswordCubit(this.resetPasswordRepo) : super(ForgetPasswordInitState());

  final ForgetPasswordRepo? resetPasswordRepo;
  ForgotPasswordByEmailModel? forgotPasswordByEmailModel;

  Future<void> forgetPassword() async {
    emit(ForgetPasswordLoadingState());
    final result = await resetPasswordRepo!.forgotPasswordByEmail(
        email: emailCon.text,
    );
    result.fold(
          (failure){
        emit(ForgetPasswordErrorState(failure.errMessage));
      },
          (data) {
            forgotPasswordByEmailModel = data;
        emit(ForgetPasswordSuccessState(data));
      },
    );
  }


  var emailCon = TextEditingController();
  var newPassCon = TextEditingController();
  var newPassConfirmationCon = TextEditingController();
  bool isVisible = true;

  void changeSuffixIcon() {
    isVisible = !isVisible;
    emit(ChangeSuffixIconState());
  }

  bool isVisible2 = true;

  void changeSuffixIcon2() {
    isVisible2 = !isVisible2;
    emit(ChangeSuffixIconState2());
  }



  VerifyResetOtpModel? verifyResetOtpModel;
  Future<void> verifyResetOtp({  required String email,
    required String otp,})
  async {
    emit(VerifyResetOtpLoadingState());
    final result = await resetPasswordRepo!.verifyResetOtp(
      email: email,
      otp: otp,
    );
    result.fold(
          (failure){
        emit(VerifyResetOtpErrorState(failure.errMessage));
      },
          (data) {
            verifyResetOtpModel = data;
        emit(VerifyResetOtpSuccessState(data));
      },
    );
  }



  ResetPasswordModel? resetPasswordModel;
  Future<void> resetPassword({
    required String email,
    required String otp,
    required String password,
    required String passwordConfirmation,
  })
  async {
    emit(ResetPasswordLoadingState());
    final result = await resetPasswordRepo!.resetPassword(
      email: email,
      otp: otp,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );
    result.fold(
          (failure){
        emit(ResetPasswordErrorState(failure.errMessage));
      },
          (data) {
            resetPasswordModel = data;
        emit(ResetPasswordSuccessState(data));
      },
    );
  }
}
