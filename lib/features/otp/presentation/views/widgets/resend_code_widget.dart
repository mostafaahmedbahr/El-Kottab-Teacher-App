import 'package:easy_localization/easy_localization.dart';
import '../../../../../main_imports.dart';
import '../../view_model/otp_cubit.dart';
import '../../view_model/otp_states.dart';

class ResendCodeWidget extends StatefulWidget {
  final String email;

  const ResendCodeWidget({
    super.key,
    required this.email,
  });

  @override
  State<ResendCodeWidget> createState() => _ResendCodeWidgetState();
}

class _ResendCodeWidgetState extends State<ResendCodeWidget> {
  String _formatTime(int totalSeconds) {
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OtpCubit, OtpStates>(
      listenWhen: (previous, current) {
        return current is ResendOtpSuccessState ||
            current is ResendOtpErrorState;
      },
      listener: (context, state) {
        if (state is ResendOtpSuccessState) {
          Toast.showSuccessToast(
            msg: state.resendOtpModel.message.toString(),
            context: context,
          );
        }
        if (state is ResendOtpErrorState) {
          Toast.showErrorToast(
            msg: state.error.toString(),
            context: context,
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<OtpCubit>();

        // الحالات المختلفة
        if (state is ResendOtpLoadingState) {
          return const Center(child: CustomLoading());
        }

        // عرض التايمر إذا كان نشطاً
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
                Text(
                  _formatTime(state.secondsRemaining),
                  style: AppStyles.gray14SemiBold.copyWith(
                    color: AppColors.darkOlive, // يمكنك تغيير اللون حسب احتياجك
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        }

        if (state is OtpTimerFinishedState) {
          return Center(
            child: GestureDetector(
              onTap: () {
                cubit.resendOtp(email: widget.email);
              },
              child: Text(
                LangKeys.resendCode.tr(),
                style: AppStyles.gray14SemiBold.copyWith(
                  color: AppColors.darkOlive,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }

        // الحالة الافتراضية - تحقق من حالة التايمر في الكيوبت
        if (cubit.isTimerActive && cubit.secondsRemaining > 0) {
          return Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${LangKeys.resendCode.tr()} بعد",
                  style: AppStyles.black12SemiBold,
                ),
                Gap(5.w),
                Text(
                  _formatTime(cubit.secondsRemaining),
                  style: AppStyles.gray14SemiBold.copyWith(
                    color: AppColors.darkOlive,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        }

        // إذا انتهى التايمر
        return Center(
          child: GestureDetector(
            onTap: () {
              cubit.resendOtp(email: widget.email);
            },
            child: Text(
              LangKeys.resendCode.tr(),
              style: AppStyles.gray14SemiBold.copyWith(
                color: AppColors.darkOlive,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}