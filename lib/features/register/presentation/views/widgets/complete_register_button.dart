import 'package:easy_localization/easy_localization.dart';
import '../../../../../main_imports.dart';
import '../../../../otp/presentation/views/otp_view.dart';
import '../../../../register/presentation/view_model/register_cubit.dart';
import '../../../../register/presentation/view_model/register_states.dart';


class CompleteRegisterButton extends StatelessWidget {
  const CompleteRegisterButton({super.key, required this.formKey});
  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit , RegisterStates>(
      listener: (context,state){
        if(state is SignUpSuccess){
          Toast.showSuccessToast(msg: state.registerModel.message.toString(),
              context: context);
          AppNav.customNavigator(context: context, screen: OtpView(
            goToLayoutOrResetPassword: "Layout",
            email: context.read<RegisterCubit>().emailCon.text,
            screenName: "CompleteRegisterView",));
        }
        else if(state is SignUpError){
          Toast.showErrorToast(msg: state.message.toString(),
              context: context);
        }
      },
      builder: (context,state){
        var registerCubit = context.read<RegisterCubit>();
        return
          ConditionalBuilder(
            condition: state is ! SignUpLoading,
            fallback: (context)=>CustomLoading(),
            builder: (context){
              return  CustomButton(
                borderColor: AppColors.white,
                btnText: LangKeys.save.tr(),
                onPressed: (){
                  if (formKey.currentState!.validate()) {
                    if(registerCubit.gender==""){
                      Toast.showErrorToast(msg: LangKeys.pleaseSelectYourGender.tr(), context: context);
                    }else{
                    registerCubit.register(
                      name: registerCubit.nameCon.text,
                      email: registerCubit.emailCon.text,
                      phone: registerCubit.phoneNumber,
                      password:  registerCubit.passCon.text,
                      confirmPassword:  registerCubit.confirmPassCon.text,
                      categoryId: registerCubit.categoryId!,
                      gender: registerCubit.gender!,
                      country: registerCubit.countryName,

                    );
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