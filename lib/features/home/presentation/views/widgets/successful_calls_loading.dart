import 'package:el_kottab_teacher_app/main_imports.dart';

import 'call_item_shimmer.dart';

class SuccessfulCallsShimmer extends StatelessWidget {
  const SuccessfulCallsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Shimmer
          Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Title text shimmer
                Container(
                  width: 150.w,
                  height: 24.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                // View all button shimmer
                Container(
                  width: 80.w,
                  height: 30.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ],
            ),
          ),

          // Horizontal List Shimmer
          SizedBox(
            height: 130.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              separatorBuilder: (_, __) => SizedBox(width: 12.w),
              itemBuilder: (_, __) => const CallItemShimmer(),
            ),
          ),
        ],
      ),
    );
  }
}