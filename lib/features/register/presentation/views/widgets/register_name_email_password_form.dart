import 'package:easy_localization/easy_localization.dart';
import 'package:el_kottab_teacher_app/features/register/presentation/view_model/register_cubit.dart';
import 'package:el_kottab_teacher_app/features/register/presentation/view_model/register_states.dart';
import 'package:el_kottab_teacher_app/main_imports.dart';

class RegisterNameEmailPasswordForm extends StatelessWidget {
  const RegisterNameEmailPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterStates>(
      builder: (context, state) {
        var registerCubit = context.read<RegisterCubit>();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Name
            Text(LangKeys.name.tr(), style: AppStyles.black14Medium),
            Gap(8.h),
            CustomTextFormField(
              onFieldSubmitted: (String value) {
                FocusScope.of(context).requestFocus(registerCubit.emailFocusNode);
              },
              controller: registerCubit.nameCon,
              keyboardType: TextInputType.visiblePassword,
              hintText: LangKeys.name.tr(),
              prefixIcon: Padding(
                padding: EdgeInsets.all(10.0.r),
                child: SvgPicture.asset(
                  SvgImages.profile,
                  colorFilter: ColorFilter.mode(
                    AppColors.black,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              validator: (value) => AppValidators.displayNameValidator(value),
            ),
            Gap(20.h),

            /// Email
            Text(LangKeys.email.tr()),
            Gap(8.h),
            CustomTextFormField(
              onFieldSubmitted: (String value) {
                FocusScope.of(context).requestFocus(registerCubit.passwordFocusNode);
              },
              focusNode: registerCubit.emailFocusNode,
              controller: registerCubit.emailCon,
              keyboardType: TextInputType.visiblePassword,
              hintText: LangKeys.email.tr(),
              prefixIcon: Padding(
                padding: EdgeInsets.all(10.0.r),
                child: SvgPicture.asset(
                  SvgImages.email,
                  colorFilter: ColorFilter.mode(
                    AppColors.black,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              validator: (value) => AppValidators.emailValidator(value),
              onChanged: (v) {
                CacheHelper.saveData(key: "userEmail", value: v);
              },
            ),
            Gap(20.h),

            /// Password
            Text(LangKeys.password.tr(), style: AppStyles.black14Medium),
            Gap(8.h),
            CustomTextFormField(
              onFieldSubmitted: (String value) {
                FocusScope.of(context).requestFocus(registerCubit.confirmPasswordFocusNode);
              },
              focusNode: registerCubit.passwordFocusNode,
              controller: registerCubit.passCon,
              keyboardType: TextInputType.visiblePassword,
              hintText: LangKeys.password.tr(),
              prefixIcon: Padding(
                padding: EdgeInsets.all(10.0.r),
                child: SvgPicture.asset(
                  SvgImages.lock,
                  colorFilter: ColorFilter.mode(
                    AppColors.black,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              suffixIcon: IconButton(
                color: AppColors.gray,
                icon: SvgPicture.asset(
                  registerCubit.isVisible ? SvgImages.eye : SvgImages.openEye,
                  colorFilter: ColorFilter.mode(
                    AppColors.black,
                    BlendMode.srcIn,
                  ),
                ),
                onPressed: registerCubit.changeSuffixIcon,
              ),
              obscureText: registerCubit.isVisible,
              validator: (String? value) =>
                  AppValidators.passwordValidator(value),
            ),
            Gap(20.h),

            /// Confirm Password
            Text(LangKeys.confirmPassword.tr(), style: AppStyles.black14Medium),
            Gap(8.h),
            CustomTextFormField(
              focusNode: registerCubit.confirmPasswordFocusNode,
              controller: registerCubit.confirmPassCon,
              keyboardType: TextInputType.visiblePassword,
              hintText: LangKeys.confirmPassword.tr(),
              prefixIcon: Padding(
                padding: EdgeInsets.all(10.0.r),
                child: SvgPicture.asset(
                  SvgImages.lock,
                  colorFilter: ColorFilter.mode(
                    AppColors.black,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              suffixIcon: IconButton(
                color: AppColors.gray,
                icon: SvgPicture.asset(
                  registerCubit.isVisible2 ? SvgImages.eye : SvgImages.openEye,
                  colorFilter: ColorFilter.mode(
                    AppColors.black,
                    BlendMode.srcIn,
                  ),
                ),
                onPressed: registerCubit.changeSuffixIcon2,
              ),
              obscureText: registerCubit.isVisible2,
              validator: (String? value) =>
                  AppValidators.repeatPasswordValidator(
                    value: value,
                    password: registerCubit.passCon.text,
                  ),
            ),
          ],
        );
      },
    );
  }
}
