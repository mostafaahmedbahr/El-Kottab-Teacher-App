

import 'package:easy_localization/easy_localization.dart';



import '../../../../../main_imports.dart';

class StatItem extends StatelessWidget {
  const StatItem({
    super.key,
    required this.color,
    required this.icon,
    required this.value,
    required this.label,
    required this.boxcolor,
  });
  final IconData icon;
  final String value;
  final String label;
  final Color boxcolor;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: boxcolor.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: boxcolor.withValues(alpha: 0.35)),
        ),
        child: Column(
          children: [
            Icon(icon, size: 24.sp, color: color),
            Gap(8.h),
            Text(
              value,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              label.tr(),
              style: TextStyle(fontSize: 11.sp, color: AppColors.grayDarkest),
            ),
          ],
        ),
      ),
    );
  }
}
