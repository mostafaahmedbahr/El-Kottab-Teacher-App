import 'package:easy_localization/easy_localization.dart';

import 'package:el_kottab_teacher_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:el_kottab_teacher_app/features/home/presentation/view_model/home_states.dart';

import 'package:el_kottab_teacher_app/main_imports.dart';
import 'package:flutter/cupertino.dart';

class TeacherRatingAndStatus extends StatelessWidget {
  const TeacherRatingAndStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      child: BlocBuilder<HomeCubit, HomeStates>(
        builder: (context, state) {
          final homeCubit = context.read<HomeCubit>();
          final stats = homeCubit.teacherStatsModel?.data;

          if (state is GetTeacherStatsLoadingState || stats == null) {
            return const SizedBox();
          }

          return Row(
            children: [
              /// ================= Availability =================
              Column(
                children: [
                  Text(
                    homeCubit.status == true
                        ? LangKeys.available.tr()
                        : LangKeys.unAvailable.tr(),
                    style: AppStyles.black16SemiBold,
                  ),

                  Gap(6.h),

                  CupertinoSwitch(
                    activeTrackColor: AppColors.darkOlive,
                    value: homeCubit.status,
                    onChanged: homeCubit.changeStatus,
                  ),
                ],
              ),

              Gap(12.w),

              /// ================= Rating =================
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: AppColors.darkOlive,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.darkOlive.withValues(alpha: 0.3),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),

                  child: _buildRatingContent(stats, context),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildRatingContent(dynamic stats, BuildContext context) {
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
