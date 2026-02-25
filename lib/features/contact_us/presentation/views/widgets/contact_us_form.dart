import 'package:easy_localization/easy_localization.dart';
import 'package:el_kottab_teacher_app/main_imports.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import '../../view_model/contact_us_cubit.dart';

class ContactUsForm extends StatelessWidget {
  const ContactUsForm({super.key,required this.contactUsCubit});
  final ContactUsCubit contactUsCubit;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Email
        CustomTextFormField(
          onFieldSubmitted: (String value) {
            FocusScope.of(context).requestFocus(contactUsCubit.phoneFocusNode);
          },
          controller: contactUsCubit.emailCon,
          keyboardType: TextInputType.visiblePassword,
          hintText: LangKeys.email.tr(),
          prefixIcon: Padding(
            padding:   EdgeInsets.all(10.0.r),
            child: SvgPicture.asset(SvgImages.email,colorFilter: ColorFilter.mode(AppColors.black, BlendMode.srcIn),),
          ),
          validator: (value)=> AppValidators.emailValidator(value),
        ),
        Gap(20.h),

        /// phone
        IntlPhoneField(
          onSubmitted: (String value) {
            FocusScope.of(context).requestFocus(contactUsCubit.titleFocusNode);
          },
          focusNode: contactUsCubit.phoneFocusNode,
          controller: contactUsCubit.phoneCon,
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
            contactUsCubit.phoneNumber = phone.completeNumber;
            contactUsCubit.countryCode = phone.countryCode;
          },
          onCountryChanged: (Country country){
            contactUsCubit.countryName = country.name;
          },
          validator: (value) => AppValidators.phoneValidator(
            value.toString(),
            countryCode: contactUsCubit.countryCode,
          ),
        ),
        Gap(10.h),

        /// title
        CustomTextFormField(
          onFieldSubmitted: (String value) {
            FocusScope.of(context).requestFocus(contactUsCubit.messageFocusNode);
          },
          focusNode: contactUsCubit.titleFocusNode,
          controller: contactUsCubit.titleCon,
          keyboardType: TextInputType.text,
          hintText: LangKeys.title.tr(),
          prefixIcon: Padding(
            padding:   EdgeInsets.all(10.0.r),
            child: SvgPicture.asset(SvgImages.title,colorFilter: ColorFilter.mode(AppColors.black, BlendMode.srcIn),),
          ),
          validator: (value)=> AppValidators.displayNameValidator(value),
        ),
        Gap(20.h),

        /// message
        CustomTextFormField(
          focusNode: contactUsCubit.messageFocusNode,
          controller: contactUsCubit.messageCon,
          keyboardType: TextInputType.text,
          hintText: LangKeys.message.tr(),
          maxLines: 6,
          validator: (value)=> AppValidators.displayMessageValidator(value),
        ),
        Gap(40.h),
      ],
    );
  }
}
