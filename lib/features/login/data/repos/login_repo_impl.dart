import 'package:dartz/dartz.dart';
import '../../../../main_imports.dart';
import '../models/login_model.dart';
import 'login_repo.dart';



class LoginRepoImpl implements LoginRepo {
  final ApiService? apiService;

  LoginRepoImpl(this.apiService);


  @override
  Future<Either<Failure, LoginModel>> login({required String email , required String password}) async{
    try {
      var data = FormData.fromMap({
        'email': email,
        'password': password
      });
      var response = await apiService!.postData(
        endPoint: EndPoints.login,
        data: data,
      );
      LoginModel result = LoginModel.fromJson(response.data);
      return right(result);
    } catch (e) {
      return left(handleError(e));
    }
  }


}

