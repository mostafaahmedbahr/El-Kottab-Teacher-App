import 'package:shimmer/shimmer.dart';

import '../../../../../main_imports.dart';

class AvailabilityShimmer extends StatelessWidget {
  const AvailabilityShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: [
          Container(
            width: 70.w,
            height: 14.h,
            color: Colors.white,
          ),
          Gap(8.h),
          Container(
            width: 40.w,
            height: 20.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ],
      ),
    );
  }
}
