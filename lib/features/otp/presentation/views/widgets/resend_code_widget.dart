

import 'package:easy_localization/easy_localization.dart';

import '../../../../../main_imports.dart';
import '../../view_model/otp_cubit.dart';
import '../../view_model/otp_states.dart';

class ResendCodeWidget extends StatelessWidget {
  const ResendCodeWidget({super.key});

  String _formatTime(int totalSeconds) {
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OtpCubit, OtpStates>(
      buildWhen: (previous, current) {

        return current is OtpTimerTickState ||
            current is OtpTimerFinishedState ||
            current is ResendOtpLoadingState ||
            current is ResendOtpErrorState ||
            current is ResendOtpSuccessState ||
            current is OtpInitState;
      },
      listener: (context, state) {
        // if (state is ResendOtpSuccessState) {
        //   NewToast.showNewSuccessToast(
        //     msg: state.resendOtpModel.message.toString(),
        //     context: context,
        //   );
        // }
        // if (state is ResendOtpErrorState) {
        //   NewToast.showNewErrorToast(
        //     msg: state.error.toString(),
        //     context: context,
        //   );
        // }
      },
      builder: (context, state) {
        final cubit = context.read<OtpCubit>();


        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (state is! OtpTimerTickState && state is! OtpTimerFinishedState && state is !ResendOtpLoadingState) {
            cubit.startOtpTimer();
          }
        });

        if (state is OtpTimerTickState) {
          return Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  LangKeys.resendCode.tr(),
                  style: AppStyles.black12SemiBold,
                ),
                Gap(5.w),
                BlocBuilder<OtpCubit, OtpStates>(
                  buildWhen: (previous, current) => current is OtpTimerTickState,
                  builder: (context, state) {
                    if (state is OtpTimerTickState) {
                      return Text(
                         _formatTime(state.secondsRemaining),
                        style: AppStyles.gray14SemiBold.copyWith(
                          color: AppColors.black,
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
          );
        }

        if (state is OtpTimerFinishedState || state is OtpInitState || state is ResendOtpSuccessState) {
          return Center(
            child: state is ResendOtpLoadingState
                ? const CustomLoading()
                : GestureDetector(
              onTap: () {
                // cubit.resendOtp(
                //   email: CacheHelper.getData(key: "userEmail")?.toString() ?? "",
                // );
              },
              child: Text(
                LangKeys.resendCode.tr(),
                style: AppStyles.gray14SemiBold.copyWith(
                  color: AppColors.white,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          );
        }

        return const Center(child: CustomLoading());
      },
    );
  }
}