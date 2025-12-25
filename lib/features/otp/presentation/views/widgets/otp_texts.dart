import 'package:easy_localization/easy_localization.dart';
import '../../../../../main_imports.dart';

class OtpTexts extends StatelessWidget {
  final String email;

  const OtpTexts({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          LangKeys.confirmYourEmail.tr(),
          style: AppStyles.black24SemiBold,
        ),
        Gap(12.h),
        Text(
          email,
          style: AppStyles.gray14SemiBold.copyWith(
            color: AppColors.black,
          ),
        ),
        Gap(12.h),
        Text(
          LangKeys.sendVerificationCode.tr(),
          style: AppStyles.gray14SemiBold,
        ),
      ],
    );
  }
}