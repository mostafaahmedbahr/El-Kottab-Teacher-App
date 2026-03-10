import 'package:easy_localization/easy_localization.dart';
import 'package:el_kottab_teacher_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:el_kottab_teacher_app/features/home/presentation/view_model/home_states.dart';
import 'package:el_kottab_teacher_app/features/home/presentation/views/widgets/rating_content.dart';
import 'package:el_kottab_teacher_app/features/home/presentation/views/widgets/teacher_availability_rating_shimmer.dart';
import 'package:el_kottab_teacher_app/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:el_kottab_teacher_app/main_imports.dart';
import 'package:flutter/cupertino.dart';
import '../../../../../core/errors/error_ui.dart';
import '../../../../../core/utils/card_decoration.dart';

class TeacherRatingAndStatus extends StatelessWidget {
  const TeacherRatingAndStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      child: BlocConsumer<HomeCubit, HomeStates>(
        buildWhen: (previous, current){
          return current is GetTeacherStatsLoadingState ||
          current is GetTeacherStatsSuccessState ||
          current is GetTeacherStatsErrorState;
        },
        listener: (context,state){
          if(state is ChangeStatusSuccessState){
            Toast.showSuccessToast(msg: state.updateAvailabilityModel.message.toString(), context: context);
            context.read<ProfileCubit>().getProfileData(isLoading: false);
          }
        },
        builder: (context, state) {
          final homeCubit = context.read<HomeCubit>();
          if(context.watch<ProfileCubit>().profileModel!=null){
            homeCubit.initStatus(context.read<ProfileCubit>().profileModel!.data!.avaliable=="active" ? true: false);
          }
          return
            state is GetTeacherStatsLoadingState || homeCubit.teacherStatsModel==null?TeacherRatingAndStatusShimmer() :
                state is GetTeacherStatsErrorState ?  ErrorUi(
                  errorState: state.error,
                  onPressed: () {
                    HomeCubit.get(context).getTeacherStats(teacherId: CacheHelper.getData(key: "userId"));
                  },
                ):
            Row(
            children: [
              /// ================= Availability =================
              Container(
                padding: EdgeInsets.all(11.r),
                decoration: cardDecoration(),
                child: Column(
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

                  child: RatingContent(stats: homeCubit.teacherStatsModel!.data, context: context),
                ),
              ),
            ],
          ) ;
        },
      ),
    );
  }


}
