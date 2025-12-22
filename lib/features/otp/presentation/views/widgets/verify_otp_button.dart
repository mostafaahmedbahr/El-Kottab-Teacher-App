import 'package:easy_localization/easy_localization.dart';
import '../../../../../core/shared_cubits/auth_cubit/auth_cubit.dart';
import '../../../../../main_imports.dart';
import '../../../../layout/presentation/views/layout_view.dart';
import '../../view_model/otp_cubit.dart';
import '../../view_model/otp_states.dart';

class VerifyOtpButton extends StatelessWidget {
  final TextEditingController controller;
  final String goToLayoutOrResetPassword;
  const VerifyOtpButton({super.key, required this.controller, required this.goToLayoutOrResetPassword, required this.email});
  final String email;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OtpCubit, OtpStates>(
      listener: (context, state) {
        if (state is VerifyOtpSuccessState) {
            AppNav.customNavigator(
              context: context,
              screen:  const LayoutView() ,
              //screen:goToLayoutOrResetPassword=="Layout" ? const LayoutView() : ResetPasswordView(),
              finish:goToLayoutOrResetPassword=="Layout" ? true : false,
            );
          Toast.showSuccessToast(
            msg: state.verifyOtpModel.message.toString(),
            context: context,
          );
            context.read<AuthCubit>().loginWithToken(state.verifyOtpModel.data!.token.toString());
        }
        if (state is VerifyOtpErrorState) {
          Toast.showErrorToast(
            msg: state.error.toString(),
            context: context,
          );
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! VerifyOtpLoadingState,
          fallback: (context) => const CustomLoading(),
          builder: (context) {
            return CustomButton(
              borderColor: AppColors.white,
              btnText:
                LangKeys.continuee.tr(),

              onPressed: () {
                if (controller.text.length == 6) {
                  // context.read<OtpCubit>().verifyOtp(
                  //   otpCode: controller.text,
                  //   email: email,
                  // );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(LangKeys.pleaseEnterValidOtp.tr())),
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
