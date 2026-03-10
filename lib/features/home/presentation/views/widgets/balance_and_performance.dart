import 'package:el_kottab_teacher_app/features/home/data/models/teacher_performance_model.dart';
import 'package:el_kottab_teacher_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:el_kottab_teacher_app/features/home/presentation/view_model/home_states.dart';
import 'package:el_kottab_teacher_app/main_imports.dart';
import '../../../../../core/errors/error_ui.dart';
import '../../../../../core/utils/card_decoration.dart';
import 'Performance_Card_Shimmer.dart';
import 'balance_card_shimmer.dart';
import 'balance_content.dart';
import 'performance_content.dart';

class BalanceAndPerformance extends StatelessWidget {
  const BalanceAndPerformance({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      child: Row(
        children: [
          // ================= Balance Container =================
          BlocBuilder<HomeCubit, HomeStates>(
            buildWhen: (previous, current){
              return current is GetTeacherStatsSuccessState ||
                  current is GetTeacherStatsErrorState ||
                  current is GetTeacherStatsLoadingState;
            },
            builder: (context,state){
              var homeCubit = context.read<HomeCubit>();
              return
                state is GetTeacherStatsLoadingState || homeCubit.teacherStatsModel==null? BalanceCardShimmer():
                state is GetTeacherStatsErrorState ? ErrorUi(
                  errorState: state.error,
                  onPressed: () {
                    HomeCubit.get(context).getTeacherStats(teacherId: CacheHelper.getData(key: "userId"));
                  },
                ):
                Flexible(
                  child: Container(
                    padding: EdgeInsets.all(11.r),
                    decoration: cardDecoration(),
                    child: BalanceContent(
                      balance: homeCubit.teacherStatsModel?.data?.walletMoney ?? 0,
                      minutes: homeCubit.teacherStatsModel?.data?.walletMinutes ?? 0,
                      currency: 'ج.م',
                    ),
                  ),
                );
            },
          ),

          Gap(12.w),

          // ================= Performance Container =================
          BlocBuilder<HomeCubit, HomeStates>(
            buildWhen: (_, current) =>
            current is GetTeacherPerformanceLoadingState ||
                current is GetTeacherPerformanceSuccessState ||
                current is GetTeacherPerformanceErrorState,
            builder: (context,state){
              final homeCubit = context.read<HomeCubit>();
              return Expanded(
                child:
                state is GetTeacherPerformanceLoadingState || homeCubit.teacherPerformanceModel==null?PerformanceShimmer() :
                    state is GetTeacherPerformanceErrorState ? ErrorUi(
                      errorState: state.error,
                      onPressed: () {
                        HomeCubit.get(context).getTeacherPerformance();
                      },
                    ):
                Container(
                  padding: EdgeInsets.all(16.r),
                  decoration: cardDecoration(),
                  child: PerformanceContent(
                    performanceData: PerformanceData(
                      successCall: homeCubit.teacherPerformanceModel!.data.successCall,
                      overview:  homeCubit.teacherPerformanceModel!.data.overview,
                      totalCall: homeCubit.teacherPerformanceModel!.data.totalCall,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }


}
