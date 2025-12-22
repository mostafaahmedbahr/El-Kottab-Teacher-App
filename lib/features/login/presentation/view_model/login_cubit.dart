
import '../../../../main_imports.dart';
import '../../data/models/login_model.dart';
import '../../data/repos/login_repo.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit(this.loginRepo) : super(LoginInitState());
  LoginRepo? loginRepo;

  LoginModel? loginModel;
  Future<void> login({
    required String email,
    required String password,
  })
  async {
    emit(LoginLoadingState());
    var result = await loginRepo!.login(email: email, password: password);
    return result.fold((failure) {
      emit(LoginErrorState(failure.errMessage));
    }, (data) async {
        loginModel = data;
        cacheUserInfo(
          token: "${data.data!.token}",
          phone: data.data!.phone.toString(),
          id:  data.data!.id!,
          email: "${data.data!.email}",
        );
        emit(LoginSuccessState(data));
    });
  }


  cacheUserInfo({required String token ,
    required String phone ,
    required int id ,
    required String email,
  })
  async {
    await CacheTokenManger.saveUserToken(token);
    CacheHelper.saveData(key: "userPhone", value: phone);
    CacheHelper.saveData(key: "userId", value: id);
    CacheHelper.saveData(key: "userEmail", value: email);
  }
  var emailCon = TextEditingController();
  var passwordCon = TextEditingController();
  bool isPasswordVisible = true;
  changePasswordVisible()
  {
    isPasswordVisible = !isPasswordVisible;
    emit(ChangePasswordVisibleState());
  }

}