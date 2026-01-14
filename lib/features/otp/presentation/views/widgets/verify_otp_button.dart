import 'package:easy_localization/easy_localization.dart';
import 'package:el_kottab_teacher_app/features/change_password/presentation/views/change_password_view.dart';
import 'package:el_kottab_teacher_app/features/login/presentation/views/login_view.dart';
import '../../../../../core/shared_cubits/auth_cubit/auth_cubit.dart';
import '../../../../../main_imports.dart';
import '../../view_model/otp_cubit.dart';
import '../../view_model/otp_states.dart';

class VerifyOtpButton extends StatelessWidget {
  final TextEditingController controller;
  final String goToLayoutOrResetPassword;
  final String email;
  final String screenName;

  const VerifyOtpButton({
    super.key,
    required this.controller,
    required this.goToLayoutOrResetPassword,
    required this.email,
    required this.screenName
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OtpCubit, OtpStates>(
      listenWhen: (previous, current) {
        // استمع فقط للحالات المطلوبة
        return current is VerifyOtpSuccessState || current is VerifyOtpLoadingState||
            current is VerifyOtpErrorState;
      },
      listener: (context, state) {
        if (state is VerifyOtpSuccessState) {
          screenName=="ForgetPasswordView" ?  AppNav.customNavigator(
            context: context,
            screen: const ChangePasswordView(screenName: "ForgetPasswordView",),
            finish: false,
          ):
          AppNav.customNavigator(
            context: context,
            screen: const LoginView(),
            finish: goToLayoutOrResetPassword == "Layout",
          );
          Toast.showSuccessToast(
            msg:screenName!="ForgetPasswordView" ? state.verifyOtpModel.message?.toString() ?? "" : state.verifyOtpModel.message?.toString() ?? "",
            context: context,
          );
          if(screenName!="ForgetPasswordView" ){
            context.read<AuthCubit>().loginWithToken(state.verifyOtpModel.data!.token.toString());
          }

        }
        if (state is VerifyOtpErrorState) {
          Toast.showErrorToast(
            msg: state.error.toString(),
            context: context,
          );
        }
      },
      buildWhen: (previous, current) {
        // اعمل build فقط للحالات المتعلقة بـ verify
        return current is VerifyOtpSuccessState || current is VerifyOtpLoadingState||
            current is VerifyOtpErrorState;
      },
      builder: (context, state) {
        final isLoading = state is VerifyOtpLoadingState;

        return isLoading
            ? const CustomLoading()
            : CustomButton(
          btnText: LangKeys.continuee.tr(),
          onPressed: () {
            if (controller.text.length == 6) {
              context.read<OtpCubit>().verifyOtp(
                otpCode: controller.text,
                email: CacheHelper.getData(key: "userEmail"),
                screenName: screenName,
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(LangKeys.pleaseEnterValidOtp.tr())),
              );
            }
          },
        );
      },
    );
  }
}
