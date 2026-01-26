import 'package:shimmer/shimmer.dart';
import '../../../../../main_imports.dart';

class PerformanceShimmer extends StatelessWidget {
  const PerformanceShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Row(
            children: [
              Container(
                width: 20.w,
                height: 20.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
              Gap(8.w),
              Container(width: 100.w, height: 12.h, color: Colors.white),
            ],
          ),

          Gap(20.h),

          // Circle
          Center(
            child: Container(
              width: 80.w,
              height: 80.w,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),

          Gap(16.h),

          // ===== Metrics =====
          Column(
            children: List.generate(
              3,
              (_) => Padding(
                padding: EdgeInsets.only(bottom: 6.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(width: 60.w, height: 10.h, color: Colors.white),
                    Container(width: 40.w, height: 10.h, color: Colors.white),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
