import 'package:easy_localization/easy_localization.dart';

import '../../../../../main_imports.dart';

class OtpTexts extends StatelessWidget {
  const OtpTexts({super.key});

  @override
  Widget build(BuildContext context) {
    print(CacheHelper.getData(key: "userEmail"));
    return Column(
      children: [
        Text(  LangKeys.confirmYourEmail.tr(),
          style: AppStyles.black24SemiBold,
        ),
        Gap(12.h),
        Builder(
            builder: (context) {
              return Text(  "${CacheHelper.getData(key: "userEmail")}",
                style: AppStyles.gray14SemiBold.copyWith(
                    color: AppColors.black
                ),
              );
            }
        ),
        Gap(12.h),
        Text(  LangKeys.sendVerificationCode.tr(),
          style: AppStyles.gray14SemiBold,
        ),

      ],
    );
  }
}