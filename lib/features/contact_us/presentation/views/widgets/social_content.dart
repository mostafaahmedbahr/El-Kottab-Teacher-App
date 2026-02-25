import 'package:easy_localization/easy_localization.dart';
import 'package:el_kottab_teacher_app/features/contact_us/presentation/view_model/contact_us_cubit.dart';
import 'package:el_kottab_teacher_app/features/contact_us/presentation/views/widgets/social_icon.dart';
import '../../../../../main_imports.dart';

class SocialContent extends StatelessWidget {
  final String facebook;
  final String instagram;
  final String youtube;
  final String whatsapp;

  const SocialContent({super.key,
    required this.facebook,
    required this.instagram,
    required this.youtube,
    required this.whatsapp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(color: AppColors.grayLight, width: 1),
        ),
      ),
      child: Column(
        children: [
          Text(
            LangKeys.followUsOnSocialMedia.tr(),
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Gap(15.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SocialIcon(
                iconPath: SvgImages.facebook,
                onTap: () => context.read<ContactUsCubit>().launchSocialMedia(facebook),
              ),
              Gap(10.w),
              SocialIcon(
                iconPath: SvgImages.instagram,
                onTap: () => context.read<ContactUsCubit>().launchSocialMedia(instagram),
              ),
              Gap(10.w),
              SocialIcon(
                iconPath: SvgImages.youtube,
                onTap: () => context.read<ContactUsCubit>().launchSocialMedia(youtube),
              ),
              Gap(10.w),
              SocialIcon(
                iconPath: SvgImages.whatsapp,
                onTap: () => context.read<ContactUsCubit>().launchWhatsApp(whatsapp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



