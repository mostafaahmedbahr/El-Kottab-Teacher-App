import 'package:el_kottab_teacher_app/features/call_log/presentation/views/widgets/stat_Item.dart';

import '../../../../../main_imports.dart';

class StatusSummary extends StatelessWidget {
  const StatusSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        StatItem(icon: Icons.call, value: "4", label: LangKeys.totalCalls, color: Colors.blue),
        Gap(12.w),
        StatItem(icon: Icons.check_circle, value: "1", label: LangKeys.completed, color: Colors.green),
        Gap(12.w),
        StatItem(icon: Icons.cancel, value: "0", label: LangKeys.canceled, color: Colors.red),
      ],
    );
  }
}
