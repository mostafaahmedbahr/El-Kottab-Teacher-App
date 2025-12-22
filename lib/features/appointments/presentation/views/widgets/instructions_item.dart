import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../../main_imports.dart';

class InstructionsItem extends StatelessWidget {
  const InstructionsItem({super.key, required this.iconData, required this.title, required this.subTitle});
  final IconData iconData;
  final String title;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return   Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 40.h,
          width: 40.w,
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.darkOlive,
          ),
          child: Icon(iconData, color: AppColors.white),
        ),
        Gap(8.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                title.tr(),
                style: AppStyles.primary16SemiBold,
                maxLines: 2,
                minFontSize: 12,
              ),
              Gap(4.h),
              AutoSizeText(
                subTitle.tr(),
                style: AppStyles.gray14SemiBold,
                maxLines: 3,
                minFontSize: 10,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
