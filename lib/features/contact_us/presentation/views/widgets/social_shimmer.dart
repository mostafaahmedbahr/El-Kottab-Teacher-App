import 'package:shimmer/shimmer.dart';

import '../../../../../main_imports.dart';

class SocialShimmer extends StatelessWidget {
  const SocialShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(color: AppColors.grayLight, width: 1),
        ),
      ),
      child: Column(
        children: [
          _shimmerBox(width: 180.w, height: 16.h),
          Gap(20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              4,
                  (index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: _shimmerCircle(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _shimmerCircle() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: 44.r,
        height: 44.r,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _shimmerBox({required double width, required double height}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        color: Colors.white,
      ),
    );
  }
}
