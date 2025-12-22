import 'package:easy_localization/easy_localization.dart';
import 'package:el_kottab_teacher_app/features/home/presentation/views/widgets/successful_calls.dart';

import '../../../../../main_imports.dart';

class CallItem extends StatelessWidget {
  const CallItem({super.key, required this.call});
  final CallItemModel call;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280.w,
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 6.r,
            spreadRadius: 2.r,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60.w,
            height: 60.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[200],
            ),
            child: CustomNetWorkImage(imageUrl: call.imageUrl, raduis: 50.r),
          ),
          Gap(12.w),

          // Call Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  call.name,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Gap(4.h),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 14.sp,
                      color: Colors.grey[500],
                    ),
                    Gap(4.w),
                    Text(
                      call.time,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                Gap(4.h),

                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 14.sp,
                      color: Colors.grey[500],
                    ),
                    Gap(4.w),
                    Text(
                      call.date,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // View Details Button
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  // View call details
                },
                icon: Icon(
                  Icons.visibility_rounded,
                  color: AppColors.darkOlive,
                  size: 24.sp,
                ),
                tooltip: LangKeys.showDetails.tr(),
              ),
              Text(
                LangKeys.show.tr(),
                style: TextStyle(
                  fontSize: 10.sp,
                  color: AppColors.darkOlive,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
