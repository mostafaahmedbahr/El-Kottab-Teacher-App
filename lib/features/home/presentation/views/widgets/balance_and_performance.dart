import 'package:el_kottab_teacher_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:el_kottab_teacher_app/features/home/presentation/view_model/home_states.dart';
import 'package:el_kottab_teacher_app/main_imports.dart';

import 'balance_card_shimmer.dart';
import 'Performance_Card_Shimmer.dart';
import 'balance_content.dart';
import 'performance_content.dart';

class BalanceAndPerformance extends StatelessWidget {
  const BalanceAndPerformance({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      buildWhen: (_, current) =>
          current is GetTeacherStatsLoadingState ||
          current is GetTeacherStatsSuccessState ||
          current is GetTeacherStatsErrorState ||
          current is GetTeacherPerformanceLoadingState ||
          current is GetTeacherPerformanceSuccessState ||
          current is GetTeacherPerformanceErrorState,
      builder: (context, state) {
        // ===== Teacher Stats Data =====
        final statsData = state is GetTeacherStatsSuccessState
            ? state.teacherStatsModel.data
            : null;

        // ===== Teacher Performance Data =====
        final performanceData = state is GetTeacherPerformanceSuccessState
            ? state.teacherPerformanceModel.data
            : null;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          child: Row(
            children: [
              // ================= Balance Container =================
              Flexible(
                child: Container(
                  padding: EdgeInsets.all(11.r),
                  decoration: _cardDecoration(),
                  child: () {
                    // 🔹 Loading
                    if (state is GetTeacherStatsLoadingState ||
                        statsData == null) {
                      return const BalanceCardShimmer();
                    }

                    // 🔹 Error
                    if (state is GetTeacherStatsErrorState) {
                      return const Center(
                        child: Icon(Icons.error_outline, color: Colors.red),
                      );
                    }

                    // 🔹 Success
                    return BalanceContent(
                      balance: statsData.walletMoney ?? 0,
                      minutes: statsData.walletMinutes ?? 0,
                      currency: 'ج.م',
                    );
                  }(),
                ),
              ),

              Gap(12.w),

              // ================= Performance Container =================
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16.r),
                  decoration: _cardDecoration(),
                  child: state is GetTeacherPerformanceLoadingState || performanceData == null
                      ? const PerformanceShimmer()
                      : state is GetTeacherPerformanceErrorState
                      ? const Center(
                    child: Icon(Icons.error_outline, color: Colors.red),
                  )
                      : PerformanceContent(performanceData: performanceData),
                ),
              ),

            ],
          ),
        );
      },
    );
  }

  // ===== Card Decoration =====
  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.r),
      border: Border.all(color: Colors.grey[300]!),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          blurRadius: 8,
          spreadRadius: 2,
        ),
      ],
    );
  }
}
