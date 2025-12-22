
import '../../data/models/login_model.dart';

abstract class LoginStates{}


class LoginInitState extends LoginStates{}

class LoginLoadingState extends LoginStates{}
class LoginSuccessState extends LoginStates{
  LoginModel loginModel;
  LoginSuccessState(this.loginModel);
}
class LoginErrorState extends LoginStates{
  final String error;
  LoginErrorState(this.error);
}

class ChangePasswordVisibleState extends LoginStates{}
