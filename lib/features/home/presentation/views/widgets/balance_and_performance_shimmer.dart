import 'package:el_kottab_teacher_app/features/home/presentation/views/widgets/performance_Card_Shimmer.dart';
import 'package:el_kottab_teacher_app/features/home/presentation/views/widgets/balance_card_shimmer.dart';
import 'package:el_kottab_teacher_app/main_imports.dart';

class BalanceAndPerformanceShimmer extends StatelessWidget {
  const BalanceAndPerformanceShimmer({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      child: Row(
        children: [
          Expanded(child: const BalanceCardShimmer()),
          Gap(12.w),
          Expanded(child: const PerformanceShimmer()),
        ],
      ),
    );
  }
}
