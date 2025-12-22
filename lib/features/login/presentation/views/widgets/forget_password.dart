import 'package:easy_localization/easy_localization.dart';

import '../../../../../main_imports.dart';


class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
          //  context.pushNamed(Routes.forgotpasswordScreen);
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
