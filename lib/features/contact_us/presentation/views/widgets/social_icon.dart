import '../../../../../main_imports.dart';

class SocialIcon extends StatelessWidget {
  const SocialIcon({super.key, required this.iconPath, required this.onTap});
  final String iconPath;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
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
}
