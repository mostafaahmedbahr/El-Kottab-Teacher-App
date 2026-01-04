import 'package:easy_localization/easy_localization.dart';

import '../../../../../core/app_services/local_services/secure_storage_service.dart';
import '../../../../../main_imports.dart';
import '../../../../layout/presentation/view_model/layout_cubit.dart';
import '../../../../login/presentation/views/login_view.dart';
import '../../view_model/change_password_cubit.dart';
import '../../view_model/change_password_states.dart';

class ChangePasswordButton extends StatelessWidget {
  const ChangePasswordButton({super.key, required this.formKey, required this.screenName});
  final GlobalKey<FormState> formKey;
  final String screenName;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChangePasswordCubit,ChangePasswordStates>(
      buildWhen: (previous, current){
        return current is ChangePasswordSuccessState || current is ChangePasswordErrorState|| current is ChangePasswordLoadingState;
      },
      listener: (context,state){
        if(state is ChangePasswordSuccessState){
           Toast.showSuccessToast(
              msg: state.changePasswordModel.message.toString(),
              context: context);
          AppNav.customNavigator(context: context,
            screen: const LoginView(),
            finish: true,
          );
          SecureStorageService.instance.deleteData(key: "userToken");
          LayoutCubit.pageIndex=0;
          context.read<LayoutCubit>().changeBottomNav(0, context);

        }
        if(state is ChangePasswordErrorState){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error.toString()),
              backgroundColor: AppColors.errorDark,
            ),
          );
        }
      },
      builder:  (context,state){
        return ConditionalBuilder(
          condition: state is ! ChangePasswordLoadingState,
          fallback: (context)=>const CustomLoading( ),
          builder:  (context){
            return CustomButton(
              btnText: LangKeys.changePassword.tr(),
              onPressed: (){
                if (formKey.currentState!.validate()){
                  print(context.read<ChangePasswordCubit>().oldPasswordCon.text);
                  print(context.read<ChangePasswordCubit>().newPasswordCon.text);
                  print(context.read<ChangePasswordCubit>().confirmNewPasswordCon.text);
                 context.read<ChangePasswordCubit>().changePassword(
                   screenName: screenName,
                   oldPassword: context.read<ChangePasswordCubit>().oldPasswordCon.text,
                   newPassword: context.read<ChangePasswordCubit>().newPasswordCon.text,
                     newPasswordConfirmation: context.read<ChangePasswordCubit>().confirmNewPasswordCon.text,
                 );

                }
              },
            );
          },

        );
      },

    );
  }
}
