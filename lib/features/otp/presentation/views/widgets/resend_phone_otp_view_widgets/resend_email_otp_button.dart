 import 'package:easy_localization/easy_localization.dart';
import '../../../../../../main_imports.dart';
import '../../../view_model/otp_cubit.dart';
import '../../../view_model/otp_states.dart';

class ResendEmailOtpButton extends StatelessWidget {
  const ResendEmailOtpButton({super.key, required this.formKey});
  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OtpCubit, OtpStates>(
      listener: (context, state) {
        // if (state is ResendOtpSuccessState) {
        //   AppNav.customNavigator(
        //     context: context,
        //     screen: const OtpView(goToLayoutOrResetPassword: "ResetPassword",),
        //     finish: false,
        //   );
        //   NewToast.showNewSuccessToast(
        //     msg: state.resendOtpModel.message.toString(),
        //     context: context,
        //   );
        // }
        // if (state is ResendOtpErrorState) {
        //   NewToast.showNewErrorToast(
        //     msg: state.error.toString(),
        //     context: context,
        //   );
        // }
      },
      builder: (context, state) {
        var otpCubit = context.read<OtpCubit>();
        return ConditionalBuilder(
          condition: state is! ResendOtpLoadingState,
          fallback: (context) => const CustomLoading(),
          builder: (context) {
            return CustomButton(
              borderColor: AppColors.white,
              btnText:
                  LangKeys.resendCode.tr(),


              onPressed: () {
    if (formKey.currentState!.validate()) {
      if(otpCubit.phoneNumber.isEmpty){
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text(AppStrings.phoneRequired),
        //     duration: const Duration(seconds: 2),
        //     backgroundColor: AppColors.redColor,
        //   ),
        // );
      }else{
        //otpCubit.resendOtp(email: otpCubit.emailCon.text);
      }

    }

              },
            );
          },
        );
      },
    );
  }
}
