import 'package:dartz/dartz.dart';
import '../../../../main_imports.dart';
import '../models/change_password_model.dart';
import 'change_password_repo.dart';

class ChangePasswordRepoImpl implements ChangePasswordRepo {
  final ApiService? apiService;

  ChangePasswordRepoImpl(this.apiService);

  @override
  Future<Either<Failure, ChangePasswordModel>> changePassword({
    required String oldPassword,
    required String newPassword,
    required String newPasswordConfirmation,
    required String screenName,
  }) async {
    try {
      var formData =  FormData.fromMap({
        "email": CacheHelper.getData(key: "userEmail"),
        "otp": CacheHelper.getData(key: "otp"),
        "password": newPassword,
        "password_confirmation": newPasswordConfirmation,
      });
      var data = {
        "old_password": oldPassword,
        "password": newPassword,
        "password_confirmation": newPasswordConfirmation,
      };
      var response = await apiService!.postData(
        endPoint:screenName=="ForgetPasswordView" ?  EndPoints.resetPassword: EndPoints.changePassword,
        data:screenName=="ForgetPasswordView" ? formData: data,
      );
      ChangePasswordModel result = ChangePasswordModel.fromJson(response.data);
      return right(result);
    } catch (e) {
      return left(handleError(e));
    }
  }
}
