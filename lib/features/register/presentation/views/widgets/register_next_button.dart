import 'package:easy_localization/easy_localization.dart';
import 'package:el_kottab_teacher_app/features/register/presentation/view_model/register_cubit.dart';
import 'package:el_kottab_teacher_app/features/register/presentation/view_model/register_states.dart';
import '../../../../../main_imports.dart';

class RegisterNextButton extends StatelessWidget {
  const RegisterNextButton({super.key,required this.screen, required this.formKey, required this.screenName});
  final Widget screen;
  final String screenName;
  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit , RegisterStates>(
      // buildWhen: (previous, current) {
      //   return current is
      // },
      listener: (context,state){

      },
      builder: (context,state){
        var registerCubit = context.read<RegisterCubit>();
        return CustomButton(
          borderColor: AppColors.white,
          btnText: LangKeys.next.tr(),
          onPressed: () {
            if (formKey.currentState!.validate()) {
              if(screenName=="CompleteRegisterView"){
                if(registerCubit.gender=="" || registerCubit.gender==null){
                  Toast.showErrorToast(msg: LangKeys.pleaseSelectYourGender.tr(), context: context);
                }
                else if(registerCubit.phoneNumber.isEmpty){
                  Toast.showErrorToast(msg: LangKeys.pleaseEnterYourPhoneNumber.tr(), context: context);
                }
                else if(registerCubit.categoryId==null){
                  Toast.showErrorToast(msg: LangKeys.pleaseSelectTheEducationalPath.tr(), context: context);
                }else {
                  AppNav.customNavigator(
                    context: context,
                    screen: screen,
                  );
                }
              }else {
                AppNav.customNavigator(
                  context: context,
                  screen: screen,
                );
              }

            }

          },
        );
      },

    );
  }
}
