import 'package:easy_localization/easy_localization.dart';
import '../../../../../main_imports.dart';
import '../../../../otp/presentation/views/otp_view.dart';
import '../../../../register/presentation/view_model/register_cubit.dart';
import '../../../../register/presentation/view_model/register_states.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({super.key, required this.formKey});
  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          Toast.showSuccessToast(
            msg: state.registerModel.message.toString(),
            context: context,
          );
          AppNav.customNavigator(
            context: context,
            screen: OtpView(
              goToLayoutOrResetPassword: "Layout",
              email: context.read<RegisterCubit>().emailCon.text,
              screenName: "CompleteRegisterView",
            ),
          );
        } else if (state is SignUpError) {
          Toast.showErrorToast(msg: state.message.toString(), context: context);
        }
      },
      builder: (context, state) {
        var registerCubit = context.read<RegisterCubit>();
        return ConditionalBuilder(
          condition: state is! SignUpLoading,
          fallback: (context) => CustomLoading(),
          builder: (context) {
            return CustomButton(
              borderColor: AppColors.white,
              btnText: LangKeys.save.tr(),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  if (registerCubit.personalPhoto == null) {
                    Toast.showErrorToast(
                      msg: LangKeys.pleaseUploadYourPhoto.tr(),
                      context: context,
                    );
                  } else if (registerCubit.cvFile == null) {
                    Toast.showErrorToast(
                      msg: LangKeys.pleaseUploadYourCv.tr(),
                      context: context,
                    );
                  } else if (registerCubit.idFront == null) {
                    Toast.showErrorToast(
                      msg: LangKeys.pleaseUploadYourPersonalIDCardFront.tr(),
                      context: context,
                    );
                  } else if (registerCubit.idBack == null) {
                    Toast.showErrorToast(
                      msg: LangKeys.pleaseUploadYourPersonalIDCardBack.tr(),
                      context: context,
                    );
                  } else {
                    registerCubit.register();
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
