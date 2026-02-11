import 'package:el_kottab_teacher_app/features/home/data/models/teacher_performance_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:el_kottab_teacher_app/main_imports.dart';

class PerformanceContent extends StatelessWidget {
  final PerformanceData performanceData;

  const PerformanceContent({super.key, required this.performanceData});

  @override
  Widget build(BuildContext context) {
    final int performance = performanceData.overview;
    final double progress = performance / 100;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // ===== Title Row =====
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
                color: Colors.black,
              ),
            ),
          ],
        ),
        Gap(12.h),

        // ===== Circular Progress =====
        Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 80.w,
                height: 80.h,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 8,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$performance%',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[700],
                    ),
                  ),
                  Text(
                    'ممتاز',
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
                  ),
                ],
              ),
            ],
          ),
        ),
        Gap(12.h),

        // ===== Metrics Column =====
        Column(
          children: [
            _buildMetric(
              'المكالمات الناجحة',
              performanceData.successCall,
              Colors.green,
            ),
            Gap(4.h),
            _buildMetric(
              'الأداء العام',
              '${performanceData.overview}%',
              Colors.amber,
            ),
            Gap(4.h),
            _buildMetric(
              'إجمالي المكالمات',
              '${performanceData.totalCall}',
              Colors.blue,
            ),
          ],
        ),
      ],
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
