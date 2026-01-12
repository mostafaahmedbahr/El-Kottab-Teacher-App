import 'package:easy_localization/easy_localization.dart';
import '../../../../../main_imports.dart';
import '../../../../forget_password/presentation/views/forget_password_view.dart';


class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            AppNav.customNavigator(
              context: context,
              screen: ForgetPasswordView(),
              finish: false,
            );
          },
          child: Text(
            LangKeys.forgetPassword.tr(),
            style: AppStyles.black14Medium,
          ),
        ),
      ],
    );
  }
}
