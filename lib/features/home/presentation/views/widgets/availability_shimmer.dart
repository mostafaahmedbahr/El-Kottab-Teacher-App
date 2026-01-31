import 'package:shimmer/shimmer.dart';

import '../../../../../main_imports.dart';

class AvailabilityShimmer extends StatelessWidget {
  const AvailabilityShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: 42.w,
        height: 24.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
        ),
      ),
    );
  }
}
