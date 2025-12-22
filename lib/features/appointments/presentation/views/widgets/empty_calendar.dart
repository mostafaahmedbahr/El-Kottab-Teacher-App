import 'package:easy_localization/easy_localization.dart';
import 'package:el_kottab_teacher_app/main_imports.dart';

class EmptyCalendar extends StatelessWidget {
  const EmptyCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(PngImages.calendar,height: 150.h,width: 150.w,fit: BoxFit.cover,),
        Gap(12.h),
        Text(LangKeys.noAppointmentsAreScheduledYet.tr(),style: AppStyles.black20Bold,),
        Gap(12.h),
        Text(LangKeys.studentsWhoRegularlyAttendClassesWithYouWillBeAbleToBookLargerNumberOfSessions.tr(),
          style: AppStyles.gray14SemiBold,),
      ],
    );
  }
}
