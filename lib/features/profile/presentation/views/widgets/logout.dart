import 'package:easy_localization/easy_localization.dart';

import '../../../../../main_imports.dart';
import 'logout_dialog.dart';

class Logout extends StatelessWidget {
  const Logout({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isArabic = Localizations.localeOf(context).languageCode == 'ar';
    return  InkWell(
      onTap: (){
        showLogoutDialog(context);
      },
      child: Container(
        padding: EdgeInsets.all(12.r),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: AppColors.white,
          border: Border.all(
            color: AppColors.errorDark
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(6.r),
                  height: 40.h,
                  width: 40.w,
                  decoration: BoxDecoration(
                    color: AppColors.errorLight.withValues(alpha: 0.3),
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(SvgImages.logout),
                ),
                Gap(8.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(LangKeys.logout.tr(),style: AppStyles.black16SemiBold.copyWith(
                      color: AppColors.errorLight
                    ),),
                  ],
                ),
              ],
            ),
            IconButton(onPressed: (){
              showLogoutDialog(context);
            }, icon: SvgPicture.asset(
              isArabic? SvgImages.arrowLeft:
              SvgImages.arrowRight,colorFilter: ColorFilter.mode(AppColors.errorLight, BlendMode.srcIn),),),

          ],
        ),
      ),
    );
  }
}
