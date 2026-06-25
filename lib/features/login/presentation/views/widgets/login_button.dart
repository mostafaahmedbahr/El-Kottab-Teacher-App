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
      listener: (context, state) async {
        if (state is LoginErrorState) {
          if (state.error.toString().contains("not approved yet")) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("تنبيه"),
                  content: const Text(
                    "حسابك لم يتم قبوله بعد، برجاء انتظار الموافقة.",
                  ),
                  actions: [
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(AppColors.darkOlive),
                        foregroundColor: WidgetStateProperty.all(AppColors.darkOlive),
                        padding: WidgetStateProperty.all(
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        ),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child:   Text("حسناً",style: TextStyle(
                        color: AppColors.white
                      ),),
                    ),
                  ],
                );
              },
            );

          }
          else if (state.error.toString().contains("حسابك غير مفعل")){
            AppNav.customNavigator(
              context: context,
              screen: OtpView(
                goToLayoutOrResetPassword: "Layout",
                email: context.read<LoginCubit>().emailCon.text,
                screenName: "LoginView",
              ),
              finish: false,
            );
          }
          else {
            Toast.showErrorToast(
              msg: state.error.toString(),
              context: context,
            );
          }
        } else if (state is LoginSuccessState) {
          var loginCubit = context.read<LoginCubit>();
          if (loginCubit.loginModel!.data!.isVerified == true) {
            await   context.read<LoginCubit>().cacheUserInfo(
              token: loginCubit.loginModel?.data?.token ?? "",
              phone: loginCubit.loginModel?.data?.phone ?? "",
              id: loginCubit.loginModel?.data?.id ?? 0,
              email: loginCubit.loginModel?.data?.email ?? "",
              name: loginCubit.loginModel?.data?.name ?? "",
            );
            if(context.mounted){
              AppNav.customNavigator(
                context: context,
                screen: LayoutView(),
                finish: true,
              );
              Toast.showSuccessToast(
                msg: state.loginModel.message.toString(),
                context: context,
              );
            }

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
                 // loginCubit.emailCon.text = "mohamed.elsayed@gmail.com";
                 //  loginCubit.passwordCon.text = "Mo**2019**";
                loginCubit.emailCon.text = "test555@gmail.com";
                loginCubit.passwordCon.text = "Mm@123456";
                if (formKey.currentState!.validate()) {
                  loginCubit.login(
                    email: loginCubit.emailCon.text,
                    password: loginCubit.passwordCon.text,
                  );
                }
              },
            );
          },
        );
      },
    );
  }
}
