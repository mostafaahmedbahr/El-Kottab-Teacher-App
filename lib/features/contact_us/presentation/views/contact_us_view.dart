import 'package:easy_localization/easy_localization.dart';
import 'package:el_kottab_teacher_app/features/contact_us/presentation/views/widgets/contact_us_button.dart';
import 'package:el_kottab_teacher_app/features/contact_us/presentation/views/widgets/social_media_icons.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../../../../core/app_services/remote_services/service_locator.dart';
import '../../../../main_imports.dart';
import '../../data/repos/contact_us_repo_impl.dart';
import '../view_model/contact_us_cubit.dart';
import '../view_model/contact_us_states.dart';

class ContactUsView extends StatelessWidget {
  const ContactUsView({super.key});

  @override
  Widget build(BuildContext context) {
    final contactUsKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text(LangKeys.contactUs.tr()),
      ),
      body: BlocProvider(
        create: (context)=>ContactUsCubit(getIt.get<ContactUsRepoImpl>()),
        child: BlocBuilder<ContactUsCubit , ContactUsStates>(
          builder: (context,state){
            var contactUsCubit = context.read<ContactUsCubit>();
            return  Padding(
              padding:   EdgeInsets.all(20.0.r),
              child: Form(
                key: contactUsKey,
                child: ListView(
                  children: [
                    /// Email
                    CustomTextFormField(
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
                    IntlPhoneField(
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
                    CustomTextFormField(
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
                    CustomTextFormField(
                      controller: contactUsCubit.messageCon,
                      keyboardType: TextInputType.text,
                      hintText: LangKeys.message.tr(),
                      maxLines: 6,
                      validator: (value)=> AppValidators.displayMessageValidator(value),
                    ),
                    Gap(40.h),
                    ContactUsButton(formKey: contactUsKey,),
                  ],
                ),
              ),
            );
          },

        ),
      ),
      bottomNavigationBar:SocialMediaIcons() ,
    );
  }
}
