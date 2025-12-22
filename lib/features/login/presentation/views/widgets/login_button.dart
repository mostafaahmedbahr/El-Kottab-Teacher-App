 import 'package:easy_localization/easy_localization.dart';
 import '../../../../../main_imports.dart';
import '../../../../layout/presentation/views/layout_view.dart';
import '../../view_model/login_cubit.dart';
import '../../view_model/login_states.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key, required this.formKey});
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      buildWhen: (previous, current) {
        return current is LoginSuccessState ||
            current is LoginLoadingState ||
            current is LoginErrorState  ;
      },
      listener: (context, state) {
        if (state is LoginErrorState) {
          Toast.showErrorToast(msg: state.error.toString(), context: context);
        } else if (state is LoginSuccessState) {
          AppNav.customNavigator(context: context, screen: LayoutView(),finish: true);
          Toast.showSuccessToast(
            msg: state.loginModel.message.toString(),
            context: context,
          );
        }
      },
      builder: (context, state) {
        var loginCubit = context.watch<LoginCubit>();
        return ConditionalBuilder(
          condition: state is! LoginLoadingState,
          fallback: (context) => CustomLoading(),
          builder: (context) {
            return CustomButton(
              btnText:  LangKeys.signIn.tr(),
              onPressed:  () {
                // loginCubit.emailCon.text = "mo9808474@gmail.com";
                // loginCubit.passwordCon.text = "123456789";
                if (formKey.currentState!.validate()) {
                  loginCubit.login(
                    email: loginCubit.emailCon.text,
                    password: loginCubit.passwordCon.text,
                  );
                }
              } ,

            );
          },
        );
      },
    );
  }
}