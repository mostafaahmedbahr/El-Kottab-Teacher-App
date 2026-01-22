import 'package:easy_localization/easy_localization.dart';
import 'package:el_kottab_teacher_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:el_kottab_teacher_app/features/home/presentation/view_model/home_states.dart';
import 'package:el_kottab_teacher_app/main_imports.dart';

import 'balance_card_shimmer.dart';

class BalanceAndPerformance extends StatelessWidget {
  const BalanceAndPerformance({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      buildWhen: (previous, current){
        return current is  GetTeacherStatsSuccessState
        || current is GetTeacherStatsErrorState
        || current is GetTeacherStatsLoadingState;
      },

      builder: (context, state) {
        var homeCubit = context.read<HomeCubit>();
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          child: Row(
            children: [
              // Balance Container
              Flexible(
                child: Container(
                  padding: EdgeInsets.all(11.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: Colors.grey[300]!),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.1),
                        blurRadius: 8.r,
                        spreadRadius: 2.r,
                      ),
                    ],
                  ),

                  child: state is GetTeacherStatsLoadingState
                      ? const BalanceCardShimmer()
                      : state is GetTeacherStatsErrorState
                      ? Center(
                          child: Icon(Icons.error_outline, color: Colors.red),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.account_balance_wallet_rounded,
                                  color: AppColors.darkOlive,
                                  size: 20.sp,
                                ),
                                Gap(8.w),
                                Text(
                                  LangKeys.balance.tr(),
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ],
                            ),
                            Gap(12.h),

                            Text(
                              '1,250 ج.م',
                              style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.darkOlive,
                              ),
                            ),
                            Gap(4.h),

                            Row(
                              children: [
                                Icon(
                                  Icons.access_time_rounded,
                                  size: 16.sp,
                                  color: Colors.grey[600],
                                ),
                                Gap(4.w),
                                Text(
                                  '180 ${LangKeys.minuteRemaining.tr()}',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                ),
              ),

              Gap(12.w),

              // Performance Container
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: Colors.grey[300]!),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.1),
                        blurRadius: 8.r,
                        spreadRadius: 2.r,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.trending_up_rounded,
                            color: Colors.blue[700],
                            size: 20.sp,
                          ),
                          Gap(8.w),
                          Text(
                            LangKeys.performanceIndicator.tr(),
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[800],
                            ),
                          ),
                        ],
                      ),
                      Gap(12.h),

                      Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: 80.w,
                              height: 80.h,
                              child: CircularProgressIndicator(
                                value: 0.85, // 85%
                                strokeWidth: 8,
                                backgroundColor: Colors.grey[200],
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.green,
                                ),
                              ),
                            ),

                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '85%',
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green[700],
                                  ),
                                ),
                                Text(
                                  'ممتاز',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Gap(12.h),
                      Column(
                        children: [
                          _buildMetric('الحضور', '98%', Colors.green),
                          Gap(4.h),
                          _buildMetric('التقييم', '4.8/5', Colors.amber),
                          Gap(4.h),
                          _buildMetric('الإنجاز', '92%', Colors.blue),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMetric(String title, String value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }
}
