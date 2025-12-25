import '../../data/models/forgot_password_by_email_model.dart';
import '../../data/models/reset_password_model.dart';
import '../../data/models/verify_reset_otp_model.dart';

abstract class ForgetPasswordStates{}

class ForgetPasswordInitState extends ForgetPasswordStates{}

class ForgetPasswordLoadingState extends ForgetPasswordStates{}
class ForgetPasswordSuccessState extends ForgetPasswordStates{
  ForgotPasswordByEmailModel forgotPasswordByEmailModel;
  ForgetPasswordSuccessState(this.forgotPasswordByEmailModel);
}
class ForgetPasswordErrorState extends ForgetPasswordStates{
  final String error;
  ForgetPasswordErrorState(this.error);
}

class ChangeSuffixIconState  extends ForgetPasswordStates{}
class ChangeSuffixIconState2  extends ForgetPasswordStates{}


class VerifyResetOtpLoadingState extends ForgetPasswordStates{}
class VerifyResetOtpSuccessState extends ForgetPasswordStates{
  VerifyResetOtpModel verifyResetOtpModel;
  VerifyResetOtpSuccessState(this.verifyResetOtpModel);
}
class VerifyResetOtpErrorState extends ForgetPasswordStates{
  final String error;
  VerifyResetOtpErrorState(this.error);
}


class ResetPasswordLoadingState extends ForgetPasswordStates{}
class ResetPasswordSuccessState extends ForgetPasswordStates{
  ResetPasswordModel resetPasswordModel;
  ResetPasswordSuccessState(this.resetPasswordModel);
}
class ResetPasswordErrorState extends ForgetPasswordStates{
  final String error;
  ResetPasswordErrorState(this.error);
}
