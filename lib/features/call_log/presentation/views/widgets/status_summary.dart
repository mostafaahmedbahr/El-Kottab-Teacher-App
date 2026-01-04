import 'package:el_kottab_teacher_app/features/call_log/presentation/views/widgets/stat_Item.dart';

import '../../../../../main_imports.dart';

class StatusSummary extends StatelessWidget {
  const StatusSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        StatItem(
          icon: Icons.call,
          value: "4",
          label: LangKeys.totalCalls,
          boxcolor: AppColors.successGreen,
          color: AppColors.darkOlive,
        ),
        Gap(12.w),
        StatItem(
          icon: Icons.check_circle,
          value: "1",
          label: LangKeys.completed,
          boxcolor: AppColors.successVeryDark,
          color: AppColors.success,
        ),
        Gap(12.w),
        StatItem(
          icon: Icons.cancel,
          value: "0",
          label: LangKeys.canceled,
          boxcolor: AppColors.dangerRed,
          color: AppColors.errorDark,
        ),
      ],
    );
  }
}
