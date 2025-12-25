 import 'package:dartz/dartz.dart';
import '../../../../main_imports.dart';
import '../models/resend_otp_model.dart';
import '../models/verify_otp_model.dart';
import 'otp_repo.dart';


class OtpRepoImpl implements OtpRepo {
  final ApiService? apiService;

  OtpRepoImpl(this.apiService);


  @override
  Future<Either<Failure, VerifyOtpModel>> verifyOtp({
    required String otpCode,
    required String email,
    required String screenName,
  }) async{
    try {
      var formData = FormData.fromMap({
        'code': otpCode,
        'email': email,
      });
      var data =  FormData.fromMap({
        'otp': otpCode,
        'email': email,
      });
      var response = await apiService!.postData(
        endPoint:  screenName!="ForgetPasswordView" ? EndPoints.verify : EndPoints.verifyResetOtp,
        isMultipart: true,
        data:screenName!="ForgetPasswordView" ? formData :data,

      );
      VerifyOtpModel result = VerifyOtpModel.fromJson(response.data);
      return right(result);

    } catch (e) {
      return left(handleError(e));
    }
  }


  @override
  Future<Either<Failure, ResendOtpModel>> resendOtp({
    required String email,
  }) async {
    try {
      var response = await apiService!.postData(
        endPoint: "${EndPoints.resendOtp}/$email",
      );
      ResendOtpModel result = ResendOtpModel.fromJson(response.data);
      return right(result);
    } catch (e) {
      return left(handleError(e));
    }
  }


}
