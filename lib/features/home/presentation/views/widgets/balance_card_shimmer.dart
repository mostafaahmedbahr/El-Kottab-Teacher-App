import 'package:shimmer/shimmer.dart';

import '../../../../../main_imports.dart';

class BalanceCardShimmer extends StatelessWidget {
  const BalanceCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(11.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Shimmer.fromColors(
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
                Container(width: 80.w, height: 12.h, color: Colors.white),
              ],
            ),

            Gap(16.h),

            // Balance
            Container(width: 120.w, height: 22.h, color: Colors.white),

            Gap(10.h),

            // Minutes
            Container(width: 140.w, height: 12.h, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
