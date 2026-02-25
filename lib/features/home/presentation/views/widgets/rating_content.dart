import 'package:easy_localization/easy_localization.dart';

import '../../../../../main_imports.dart';

class RatingContent extends StatelessWidget {
  const RatingContent({super.key, this.stats, required this.context});
 final dynamic stats;
 final     BuildContext context;
  @override
  Widget build(BuildContext context) {
    final num rate = stats.averageRate ?? 0.0;
    final int totalRates = stats.totalRates ?? 0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// ===== Left =====
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(Icons.star_rounded, color: Colors.amber, size: 14.sp),
                Gap(4.w),
                Text(
                  LangKeys.rating.tr(),
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.white.withValues(alpha: 0.8),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Gap(2.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  rate.toStringAsFixed(1),
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Gap(2.w),
                Text(
                  "/5",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ],
        ),

        /// Divider
        Container(
          width: 1.w,
          height: 40.h,
          color: Colors.white.withValues(alpha: 0.2),
        ),

        /// ===== Right =====
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: List.generate(5, (i) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 1.w),
                  child: Icon(
                    i + 1 <= rate
                        ? Icons.star_rounded
                        : i + 0.5 <= rate
                        ? Icons.star_half_rounded
                        : Icons.star_border_rounded,
                    color: Colors.amber,
                    size: 18.sp,
                  ),
                );
              }),
            ),
            Gap(4.h),
            Row(
              children: [
                Icon(
                  Icons.people_rounded,
                  size: 12.sp,
                  color: Colors.white.withValues(alpha: 0.7),
                ),
                Gap(2.w),
                Text(
                  "$totalRates ${LangKeys.reviews.tr()}",
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
