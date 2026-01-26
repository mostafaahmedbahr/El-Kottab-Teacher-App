import 'package:shimmer/shimmer.dart';

import '../../../../../main_imports.dart';

class CallItemShimmer extends StatelessWidget {
  const CallItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110.w,
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: CircleAvatar(radius: 28.r, backgroundColor: Colors.grey),
          ),
          Gap(8.h),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(height: 12.h, width: 70.w, color: Colors.grey),
          ),
          Gap(6.h),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(height: 10.h, width: 50.w, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
