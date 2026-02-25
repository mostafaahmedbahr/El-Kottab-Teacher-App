import 'package:easy_localization/easy_localization.dart';
import 'package:el_kottab_teacher_app/core/errors/error_ui.dart';
import 'package:el_kottab_teacher_app/core/extensions/lang.dart';
import 'package:el_kottab_teacher_app/features/home/presentation/views/widgets/successful_calls_loading.dart';
import 'package:el_kottab_teacher_app/features/layout/presentation/view_model/layout_cubit.dart';
import 'package:el_kottab_teacher_app/main_imports.dart';
import '../../view_model/home_cubit.dart';
import '../../view_model/home_states.dart';
import 'call_item.dart';

class SuccessfulCalls extends StatelessWidget {
  const SuccessfulCalls({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      buildWhen: (previous, current){
        return current is GetSuccessfulCallsLoadingState
            || current is GetSuccessfulCallsSuccessState
            || current is GetSuccessfulCallsErrorState;
      },
      builder: (context,state){
        var homeCubit = context.read<HomeCubit>();
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child:
          state is GetSuccessfulCallsLoadingState || homeCubit.successfulCallsModel==null ? SuccessfulCallsShimmer():
              state is GetSuccessfulCallsErrorState ?
          ErrorUi(
          errorState: state.error,
          onPressed: () {
            HomeCubit.get(context).getSuccessfulCalls();
          },
        ) : state is GetSuccessfulCallsSuccessState && state.successfulCallsModel.data!.isEmpty ?
              SizedBox(
                height: 100.h,
                child: Center(
                  child: Text(
                    LangKeys.noSuccessfulCallsYet.tr(),
                    style: AppStyles.black16SemiBold,
                  ),
                ),
              ):
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      LangKeys.successfulCalls.tr(),
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.read<LayoutCubit>().changeBottomNav(1, context);
                      },
                      child: Row(
                        children: [
                          Text(
                            LangKeys.viewAll.tr(),
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.darkOlive,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Gap(8.w),
                          Icon(
                            context.isArabic
                                ? Icons.chevron_right
                                : Icons.chevron_left,
                            color: AppColors.darkOlive,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 130.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: homeCubit.successfulCallsModel!.data!.take(5).toList().length,
                  separatorBuilder: (_, __) =>
                      SizedBox(width: 12.w),
                  itemBuilder: (context, index) {
                    return CallItem(call: homeCubit.successfulCallsModel!.data![index]);
                  },
                ),
              )


            ],
          ),
        );
      },
    );
  }
}


