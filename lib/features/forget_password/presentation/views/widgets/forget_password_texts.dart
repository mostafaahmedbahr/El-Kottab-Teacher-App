import 'package:easy_localization/easy_localization.dart';

import '../../../../../main_imports.dart';

class ForgetPasswordTexts extends StatelessWidget {
  const ForgetPasswordTexts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(LangKeys.enterYourEmailToResetPassword.tr()),
        Gap(12.h),
        Text(
          LangKeys.enterEmailToReceiveResetCode.tr(),
        ),
      ],
    );
  }
}