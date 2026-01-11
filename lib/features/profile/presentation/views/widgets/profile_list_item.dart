import 'package:easy_localization/easy_localization.dart';

import '../../../../../main_imports.dart';

class ProfileListItem extends StatelessWidget {
  const ProfileListItem({super.key,  this.isLast = false, required this.title,
  required this.svgImage, required this.onTap,});
  final bool isLast;
  final String title;
  final String svgImage;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    final bool isArabic = Localizations.localeOf(context).languageCode == 'ar';
    return InkWell(
      onTap: onTap,
      child : Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(6.r),
                    height: 40.h,
                    width: 40.w,
                    decoration: BoxDecoration(
                      color: AppColors.darkOlive.withValues(alpha: .3),
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(svgImage),
                  ),
                  Gap(8.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title.tr(),style: AppStyles.black16SemiBold,),
                    ],
                  ),
                ],
              ),
              IconButton(onPressed: onTap, icon: SvgPicture.asset(
                isArabic? SvgImages.arrowLeft:
                SvgImages.arrowRight,colorFilter: ColorFilter.mode(AppColors.darkOlive, BlendMode.srcIn),),),

            ],
          ),
          if (!isLast)
            Divider(
              color: AppColors.cream,
              height: 20.h,
            ),
        ],
      ),
    );
  }
}