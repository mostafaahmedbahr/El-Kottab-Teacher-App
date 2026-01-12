import 'package:easy_localization/easy_localization.dart';
import '../../../../../main_imports.dart';
import '../../../../layout/presentation/views/layout_view.dart';
import '../../../../otp/presentation/views/otp_view.dart';
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
            current is LoginErrorState;
      },
      listener: (context, state) {
        if (state is LoginErrorState) {
          Toast.showErrorToast(msg: state.error.toString(), context: context);
        } else if (state is LoginSuccessState) {
          var loginCubit = context.read<LoginCubit>();
          context.read<LoginCubit>().cacheUserInfo(
              token: loginCubit.loginModel?.data?.token ?? "",
              phone: loginCubit.loginModel?.data?.phone?.toString() ?? "",
              id: loginCubit.loginModel?.data?.id ?? 0,
              email: loginCubit.loginModel?.data?.email ?? "",
          );
          if (loginCubit.loginModel!.data!.isVerified == true) {
            AppNav.customNavigator(
              context: context,
              screen: LayoutView(),
              finish: true,
            );
            Toast.showSuccessToast(
              msg: state.loginModel.message.toString(),
              context: context,
            );
          } else {
            Toast.showErrorToast(
              msg: LangKeys.accountMustBeVerified.tr(),
              context: context,
            );
            AppNav.customNavigator(
              context: context,
              screen: OtpView(
                goToLayoutOrResetPassword: "Layout",
                email: state.loginModel.data!.email.toString(),
                screenName: "LoginView",
              ),
              finish: false,
            );
          }
        }
      },
      builder: (context, state) {
        var loginCubit = context.watch<LoginCubit>();
        return ConditionalBuilder(
          condition: state is! LoginLoadingState,
          fallback: (context) => CustomLoading(),
          builder: (context) {
            return CustomButton(
              btnText: LangKeys.signIn.tr(),
              onPressed: () {
               //  loginCubit.emailCon.text = "mustafa.bahr12323@gmail.com";
              // loginCubit.emailCon.text = "mohamedmagdymohamed982@gmail.com";
                //    loginCubit.passwordCon.text = "Mm@123456";
                // if (formKey.currentState!.validate()) {
                //   loginCubit.login(
                //     email: loginCubit.emailCon.text,
                //     password: loginCubit.passwordCon.text,
                //   );
                // }
                AppNav.customNavigator(context: context, screen: LayoutView());
              },
            );
          },
        );
      },
    );
  }
}
