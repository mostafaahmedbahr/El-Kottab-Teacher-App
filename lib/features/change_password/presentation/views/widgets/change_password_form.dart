import 'package:easy_localization/easy_localization.dart';

import '../../../../../main_imports.dart';
import '../../view_model/change_password_cubit.dart';
import '../../view_model/change_password_states.dart';

class ChangePasswordForm extends StatelessWidget {
  const ChangePasswordForm({super.key, required this.screenName});
  final String screenName;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordCubit,ChangePasswordStates>(
      buildWhen: (previous, current){
        return current is ChangeConfirmNewPasswordVisibleState || current is ChangeNewPasswordVisibleState || current is ChangeOldPasswordVisibleState;
      },
      builder: (context,state){
        var changePasswordCubit = context.read<ChangePasswordCubit>();
        return Column(
          children: [
            if(screenName!="ForgetPasswordView")
            CustomTextFormField(
           controller:  changePasswordCubit.oldPasswordCon,
              keyboardType: TextInputType.visiblePassword,
              hintText: LangKeys.oldPassword.tr(),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SvgPicture.asset(SvgImages.lock,),
              ),
              validator: (String? value) {
                return AppValidators.passwordValidator(value);
              },
              suffixIcon: IconButton(
                color: AppColors.gray,
                icon: changePasswordCubit.isOldPasswordVisible
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
                onPressed: () {
                  changePasswordCubit.changeOldPasswordVisible();
                },
              ),

              obscureText: changePasswordCubit.isOldPasswordVisible,
            ),
            Gap(20.h),
            CustomTextFormField(
              controller:  changePasswordCubit.newPasswordCon,
              keyboardType: TextInputType.visiblePassword,
              hintText: LangKeys.newPassword.tr(),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SvgPicture.asset(SvgImages.lock,),
              ),
              validator: (String? value) {
                return AppValidators.passwordValidator(value);
              },
              suffixIcon: IconButton(
                color: AppColors.gray,
                icon: changePasswordCubit.isNewPasswordVisible
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
                onPressed: () {
                  changePasswordCubit.changeNewPasswordVisible();
                },
              ),

              obscureText: changePasswordCubit.isNewPasswordVisible,
            ),
             Gap(20.h),
            CustomTextFormField(
              controller:  changePasswordCubit.confirmNewPasswordCon,
              keyboardType: TextInputType.visiblePassword,
              hintText: LangKeys.newPassword.tr(),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SvgPicture.asset(SvgImages.lock,),
              ),
              validator: (String? value) {
                return AppValidators.repeatPasswordValidator(
                  value: value,
                  password: changePasswordCubit.newPasswordCon.text,
                );
              },
              suffixIcon: IconButton(
                color: AppColors.gray,
                icon: changePasswordCubit.isConfirmNewPasswordVisible
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
                onPressed: () {
                  changePasswordCubit.changeConfirmNewPasswordVisible();
                },
              ),

              obscureText: changePasswordCubit.isConfirmNewPasswordVisible,
            ),
            Gap(20.h),
          ],
        );
      },

    );
  }
}
