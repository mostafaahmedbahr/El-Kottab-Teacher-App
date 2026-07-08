import 'package:easy_localization/easy_localization.dart';
import 'package:el_kottab_teacher_app/main_imports.dart';

class EmptyCalendar extends StatelessWidget {
  final bool hasAppointments;
  final int count;

  const EmptyCalendar({
    super.key,
    this.hasAppointments = false,
    this.count = 0,
  });

  @override
  Widget build(BuildContext context) {
    if (hasAppointments) {
      return Column(
        children: [
          Image.asset(
            PngImages.calendar,
            height: 120.h,
            width: 120.w,
            fit: BoxFit.cover,
          ),
          Gap(8.h),
          Text(
            '$count',
            style: AppStyles.black20Bold.copyWith(
              fontSize: 64.sp,
              color: AppColors.darkOlive,
              height: 1,
            ),
          ),
          Text(
            LangKeys.youHaveAppointments.tr(),
            style: AppStyles.black20Bold,
          ),
        ],
      );
    }

    return Column(
      children: [
        Image.asset(
          PngImages.calendar,
          height: 150.h,
          width: 150.w,
          fit: BoxFit.cover,
        ),
        Gap(12.h),
        Text(
          LangKeys.noAppointmentsAreScheduledYet.tr(),
          style: AppStyles.black20Bold,
        ),
        Gap(12.h),
        Text(
          LangKeys.studentsWhoRegularlyAttendClassesWithYouWillBeAbleToBookLargerNumberOfSessions.tr(),
          style: AppStyles.gray14SemiBold,
        ),
      ],
    );
  }
}
