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
      child: Row(
        children: [
          // Availability Status
          Column(
            children: [
              Text(
                LangKeys.available.tr(),
                style: AppStyles.black16SemiBold,
              ),
              BlocConsumer<HomeCubit, HomeStates>(
                listener: (context,state){
                  if(state is ChangeStatusSuccessState){
                    Toast.showSuccessToast(msg: state.updateAvailabilityModel.message.toString(), context: context);
                  }else if(state is ChangeStatusErrorState){
                    Toast.showErrorToast(msg: state.error.toString(), context: context);

                  }
                },
                builder: (context, state) {
                  var homeCubit = context.read<HomeCubit>();
                  return CupertinoSwitch(
                    activeTrackColor: AppColors.darkOlive,
                    value: homeCubit.status,
                    onChanged: (value) {
                      homeCubit.changeStatus(value);
                    },
                  );
                },
              ),
            ],
          ),
          Gap(12.w),

          // Rating Container
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.star_rounded,
                            color: Colors.amber,
                            size: 14.sp,
                          ),
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
                            "4.8",
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

                  Container(
                    width: 1.w,
                    height: 40.h,
                    color: Colors.white.withValues(alpha: 0.2),
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          for (int i = 0; i < 5; i++)
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 1.w),
                              child: Icon(
                                i < 4 ? Icons.star_rounded : Icons.star_half_rounded,
                                color: Colors.amber,
                                size: 18.sp,
                              ),
                            ),
                        ],
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
                            "128 ${LangKeys.reviews.tr()}",
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}