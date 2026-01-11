import 'package:easy_localization/easy_localization.dart';
import 'package:el_kottab_teacher_app/core/shared_widgets/custom_drop_down.dart';
import 'package:el_kottab_teacher_app/features/login/data/models/login_model.dart';
import 'package:el_kottab_teacher_app/features/register/data/models/categories_model.dart';
import 'package:el_kottab_teacher_app/features/register/presentation/view_model/register_cubit.dart';

import 'package:el_kottab_teacher_app/main_imports.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../../../../register/presentation/view_model/register_states.dart';

class CompleteRegisterForm extends StatelessWidget {
  const CompleteRegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterStates>(
      builder: (context, state) {
        var registerCubit = context.read<RegisterCubit>();
        print(registerCubit.countryName);
        print("object");
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Gender
            Text(LangKeys.gender.tr(), style: AppStyles.black14Medium),
            Gap(8.h),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 48.h,
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: registerCubit.gender == "female"
                          ? AppColors.darkOlive.withValues(alpha: 0.2)
                          : AppColors.white,
                      border: Border.all(
                        color: registerCubit.gender == "female"
                            ? AppColors.darkOlive.withValues(alpha: 0.2)
                            : AppColors.grayLight,
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        registerCubit.selectGender("female");
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            SvgImages.woman,
                            height: 25.h,
                            width: 25.w,
                            fit: BoxFit.cover,
                          ),
                          Gap(8.w),
                          Text(LangKeys.female.tr()),
                        ],
                      ),
                    ),
                  ),
                ),
                Gap(12.w),
                Expanded(
                  child: Container(
                    height: 48.h,
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: registerCubit.gender == "male"
                          ? AppColors.darkOlive.withValues(alpha: 0.2)
                          : AppColors.white,
                      border: Border.all(
                        color: registerCubit.gender == "male"
                            ? AppColors.darkOlive.withValues(alpha: 0.2)
                            : AppColors.grayLight,
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        registerCubit.selectGender("male");
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            SvgImages.man,
                            height: 25.h,
                            width: 25.w,
                            fit: BoxFit.cover,
                          ),
                          Gap(8.w),
                          Text(LangKeys.male.tr()),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Gap(20.h),

            /// Phone Number
            Text(LangKeys.phoneNumber.tr(), style: AppStyles.black14Medium),
            Gap(8.h),
            IntlPhoneField(
              controller: registerCubit.phoneCon,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                labelText: LangKeys.phoneNumber.tr(),
                labelStyle: const TextStyle(color: AppColors.gray),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 17,
                  horizontal: 15,
                ),
                filled: true,
                fillColor: AppColors.white,
                hintStyle: const TextStyle(
                  fontSize: 14,
                  color: Color.fromRGBO(150, 150, 150, 1),
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset(
                    SvgImages.mobile,
                    colorFilter: ColorFilter.mode(
                      AppColors.black,
                      BlendMode.srcIn,
                    ),
                  ), // Use your mobile icon
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: const BorderSide(color: AppColors.grayLight),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: const BorderSide(color: AppColors.grayLight),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: const BorderSide(color: AppColors.grayLight),
                ),
              ),
              initialCountryCode: 'EG',
              keyboardType: TextInputType.number,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onChanged: (PhoneNumber phone) {
                registerCubit.phoneNumber = phone.completeNumber;
                registerCubit.countryCode = phone.countryCode;
              },
              onCountryChanged: (Country country) {
                registerCubit.countryName = country.name;
              },
              validator: (value) => AppValidators.phoneValidator(
                value.toString(),
                countryCode: registerCubit.countryCode,
              ),
            ),
            Gap(10.h),

            /// Category Id
            Text(LangKeys.educationalPath.tr(), style: AppStyles.black14Medium),
            Gap(8.h),

            CustomDropdown<CategoryData>(
              value: registerCubit.selectedCategory,
              items: registerCubit.categories,
              hint: LangKeys.educationalPath.tr(),
              itemDisplayBuilder: (item) => item.name ?? '',
              onChanged: (value) {
                if (value != null) {
                  registerCubit.selectCategory(value);
                }
              },
            ),
          ],
        );
      },
    );
  }
}
