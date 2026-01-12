import 'package:easy_localization/easy_localization.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import '../../../../../main_imports.dart';
import '../../../../profile/presentation/view_model/profile_cubit.dart';
import '../../view_model/edit_profile_info_cubit.dart';
import '../../view_model/edit_profile_info_states.dart';

class EditProfileNameEmailPhoneForm extends StatefulWidget {
  const EditProfileNameEmailPhoneForm({super.key});

  @override
  State<EditProfileNameEmailPhoneForm> createState() =>
      _EditProfileNameEmailPhoneFormState();
}

class _EditProfileNameEmailPhoneFormState
    extends State<EditProfileNameEmailPhoneForm> {
  @override
  void initState() {
    super.initState();
    final profile = context.read<ProfileCubit>().profileModel;
    if (profile != null) {
      context.read<EditProfileInfoCubit>().initDateControllers(profile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileInfoCubit, EditProfileInfoStates>(
      builder: (context, state) {
        var editProfileInfoCubit = EditProfileInfoCubit.get(context);
        return Column(
          children: [
            Gap(30.h),
            CustomTextFormField(
              controller: editProfileInfoCubit.nameCon,
              keyboardType: TextInputType.text,
              hintText:LangKeys.name.tr(),
              prefixIcon: Padding(
                padding:   EdgeInsets.all(10.0.r),
                child: SvgPicture.asset(
                  SvgImages.profile,
                  colorFilter: ColorFilter.mode(
                    AppColors.gray,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              validator: (String? value) {
                return AppValidators.displayNameValidator(value);
              },
            ),
            Gap(20.h),
            CustomTextFormField(
              controller: editProfileInfoCubit.emailCon,
              keyboardType: TextInputType.emailAddress,
              hintText: LangKeys.email.tr(),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SvgPicture.asset(SvgImages.email),
              ),
              validator: (String? value) {
                return AppValidators.emailValidator(value);
              },
            ),
            Gap(20.h),
            IntlPhoneField(
              controller: editProfileInfoCubit.phoneCon,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                labelText: LangKeys.phoneNumber.tr(),
                labelStyle: const TextStyle(color: AppColors.gray),
                contentPadding:   EdgeInsets.symmetric(
                  vertical: 17.h,
                  horizontal: 15.w,
                ),
                filled: true,
                fillColor: AppColors.white,
                hintStyle:   TextStyle(
                  fontSize: 14.sp,
                  color: Color.fromRGBO(150, 150, 150, 1),
                ),
                suffixIcon: Padding(
                  padding:   EdgeInsets.all(10.0.r),
                  child: SvgPicture.asset(
                    SvgImages.mobile,
                    colorFilter: ColorFilter.mode(
                      AppColors.black,
                      BlendMode.srcIn,
                    ),
                  ),
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
                editProfileInfoCubit.phoneNumber = phone.completeNumber;
              },
              validator: (value) {
                if (value == null || value.number.isEmpty) {
                  return LangKeys.phoneRequired.tr();
                }
                return null;
              },
            ),
          ],
        );
      },
    );
  }
}
