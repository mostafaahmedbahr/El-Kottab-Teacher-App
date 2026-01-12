import 'package:easy_localization/easy_localization.dart';
import '../../../../../main_imports.dart';
import '../../../../register/presentation/views/register_view.dart';

class DoNotHaveAccount extends StatelessWidget {
  const DoNotHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          LangKeys.doNotHaveAnAccount.tr(),
          style: AppStyles.black16Medium,
        ),
        TextButton(
          onPressed: () {
            AppNav.customNavigator(context: context, screen: RegisterView());
          },
          child: Text(
            textAlign: TextAlign.center,
            LangKeys.signUp.tr(),
            style: AppStyles.primary16SemiBold,
          ),
        ),
      ],
    );
  }
}
