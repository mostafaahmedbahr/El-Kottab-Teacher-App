import 'package:dartz/dartz.dart';
import '../../../../main_imports.dart';
import '../models/forgot_password_by_email_model.dart';
import '../models/reset_password_model.dart';
import '../models/verify_reset_otp_model.dart';
import 'forget_password_repo.dart';

class ForgetPasswordRepoImpl implements ForgetPasswordRepo {
  final ApiService? apiService;

  ForgetPasswordRepoImpl(this.apiService);

  @override
  Future<Either<Failure, ForgotPasswordByEmailModel>> forgotPasswordByEmail({
    required String email,
  })
  async {
    try {
      var response = await apiService!.postData(
        endPoint: EndPoints.forgotPassword,
        data: {
          "email": email,
        },
      );
      ForgotPasswordByEmailModel result = ForgotPasswordByEmailModel.fromJson(
        response.data,
      );
      return right(result);
    } catch (e) {
      return left(handleError(e));
    }
  }

  @override
  Future<Either<Failure, VerifyResetOtpModel>> verifyResetOtp({
  required String email,
  required String otp,
  })
  async {
    try {
      var response = await apiService!.postData(
        endPoint: EndPoints.verifyResetOtp,
        data: {
          "email": email,
          "otp": otp,
        },
      );
      VerifyResetOtpModel result = VerifyResetOtpModel.fromJson(
        response.data,
      );
      return right(result);
    } catch (e) {
      return left(handleError(e));
    }
  }


  @override
  Future<Either<Failure, ResetPasswordModel>> resetPassword({
    required String email,
    required String otp,
    required String password,
    required String passwordConfirmation,

  })
  async {
    try {
      var response = await apiService!.postData(
        endPoint: EndPoints.verifyResetOtp,
        data: {
          "email": email,
          "otp": otp,
          "password": password,
          "password_confirmation": passwordConfirmation,
        },
      );
      ResetPasswordModel result = ResetPasswordModel.fromJson(
        response.data,
      );
      return right(result);
    } catch (e) {
      return left(handleError(e));
    }
  }


}
