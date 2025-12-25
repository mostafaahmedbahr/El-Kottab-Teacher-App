import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../models/forgot_password_by_email_model.dart';
import '../models/reset_password_model.dart';
import '../models/verify_reset_otp_model.dart';

abstract class ForgetPasswordRepo {
  Future<Either<Failure, ForgotPasswordByEmailModel>> forgotPasswordByEmail({
    required String email,
  });

  Future<Either<Failure, VerifyResetOtpModel>> verifyResetOtp({
    required String email,
    required String otp,
  });

  Future<Either<Failure, ResetPasswordModel>> resetPassword({
    required String email,
    required String otp,
    required String password,
    required String passwordConfirmation,

  });
}
