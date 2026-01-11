import 'package:easy_localization/easy_localization.dart';
 import '../../../../../main_imports.dart';
import '../complete_register_view.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({super.key, required this.formKey});
  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    return CustomButton(
      borderColor: AppColors.white,
      btnText: LangKeys.signUp.tr(),
      onPressed: (){
        if (formKey.currentState!.validate()) {
          AppNav.customNavigator(
              context: context,
              screen: CompleteRegisterView());
        }
      },
    );
  }
}