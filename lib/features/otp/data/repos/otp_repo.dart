import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../models/resend_otp_model.dart';
import '../models/verify_otp_model.dart';


abstract class OtpRepo{
  Future<Either<Failure , VerifyOtpModel>> verifyOtp({
    required String otpCode,
    required String email,
    required String screenName,
  });

  Future<Either<Failure , ResendOtpModel>> resendOtp({
    required String email,
  });



}
