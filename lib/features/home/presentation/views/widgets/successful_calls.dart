import 'package:easy_localization/easy_localization.dart';
import 'package:el_kottab_teacher_app/core/extensions/lang.dart';
import 'package:el_kottab_teacher_app/main_imports.dart';

import '../../view_model/home_cubit.dart';
import '../../view_model/home_states.dart';
import 'call_item.dart';
import 'call_item_shimmer.dart';

class SuccessfulCalls extends StatelessWidget {
    const SuccessfulCalls({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                        context.isArabic ? Icons.chevron_right : Icons.chevron_left,
                        size: 20.sp,
                        color: AppColors.darkOlive,
                      )                    ],
                  ),
                ),
              ],
            ),
          ),

          BlocBuilder<HomeCubit, HomeStates>(
            builder: (context, state) {
              if (state is GetSuccessfulCallsLoadingState) {
                return SizedBox(
                  height: 130.h,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    separatorBuilder: (_, __) => SizedBox(width: 12.w),
                    itemBuilder: (_, __) => const CallItemShimmer(),
                  ),
                );
              }

              if (state is GetSuccessfulCallsSuccessState) {
                final calls = state.successfulCallsModel.data?.take(5).toList();

                return SizedBox(
                  height: 130.h,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: calls?.length ?? 0,
                    separatorBuilder: (_, __) => SizedBox(width: 12.w),
                    itemBuilder: (context, index) {
                      return CallItem(call: calls![index]);
                    },
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),

        ],
      ),
    );
  }


}

