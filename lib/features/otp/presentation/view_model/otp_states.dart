
import '../../data/models/resend_otp_model.dart';
import '../../data/models/verify_otp_model.dart';

abstract class OtpStates{}


class OtpInitState extends OtpStates{}

class VerifyOtpLoadingState extends OtpStates{}
class VerifyOtpSuccessState extends OtpStates{
  VerifyOtpModel verifyOtpModel;
  VerifyOtpSuccessState(this.verifyOtpModel);
}
class VerifyOtpErrorState extends OtpStates{
  final String error;
  VerifyOtpErrorState(this.error);
}

class OtpTimerTickState extends OtpStates {
  final int secondsRemaining;
  OtpTimerTickState(this.secondsRemaining);
}

class OtpTimerFinishedState extends OtpStates {}


class ResendOtpLoadingState extends OtpStates{}
class ResendOtpSuccessState extends OtpStates{
  ResendOtpModel resendOtpModel;
  ResendOtpSuccessState(this.resendOtpModel);
}
class ResendOtpErrorState extends OtpStates{
  final String error;
  ResendOtpErrorState(this.error);
}