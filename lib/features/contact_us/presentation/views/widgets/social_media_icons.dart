import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../core/extensions/log_util.dart';
import '../../../../../main_imports.dart';

class SocialMediaIcons extends StatelessWidget {
  const SocialMediaIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(top: BorderSide(color: AppColors.grayLight, width: 1)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            LangKeys.followUsOnSocialMedia.tr(),
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
          Gap(15.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // فيسبوك
              _buildSocialIcon(
                iconPath: SvgImages.facebook,
                onTap: () => _launchSocialMedia('https://facebook.com/yourpage'),
              ),
              Gap(10.w),

              // تويتر
              // _buildSocialIcon(
              //   iconPath: SvgImages.twitter,
              //   onTap: () => _launchSocialMedia('https://twitter.com/yourpage'),
              // ),
              // Gap(10.w),

              // انستجرام
              _buildSocialIcon(
                iconPath: SvgImages.instagram,
                onTap: () => _launchSocialMedia('https://instagram.com/yourpage'),
              ),
              Gap(10.w),

              // يوتيوب
              _buildSocialIcon(
                iconPath: SvgImages.youtube,
                onTap: () => _launchSocialMedia('https://youtube.com/c/yourchannel'),
              ),
              Gap(10.w),
              _buildSocialIcon(
                iconPath: SvgImages.whatsapp,
                onTap: () => _launchWhatsApp('+201234567890'),
              ),
            ],
          ),
          Gap(10.h),

        ],
      ),
    );
  }
}


Widget _buildSocialIcon({
  required String iconPath,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(50.r),
    child: Container(
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.grayLight.withValues(alpha: 0.3),
      ),
      child: SvgPicture.asset(
        iconPath,
        width: 24.r,
        height: 24.r,

      ),
    ),
  );
}

Future<void> _launchSocialMedia(String url) async {
  try {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  } catch (e) {
    logError('Error launching URL: $e');
  }
}

Future<void> _launchWhatsApp(String phoneNumber) async {
  final url = "https://wa.me/$phoneNumber";
  await _launchSocialMedia(url);
}