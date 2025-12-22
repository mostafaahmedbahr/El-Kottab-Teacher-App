import 'package:el_kottab_teacher_app/features/appointments/presentation/views/widgets/instructions_item.dart';
import 'package:el_kottab_teacher_app/main_imports.dart';

class AppointmentsInstructionsTexts extends StatelessWidget {
  const AppointmentsInstructionsTexts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
       InstructionsItem(iconData: Icons.calendar_month_sharp, title: LangKeys.theSessionWasCanceledBeforeTheScheduledTime, subTitle: LangKeys.youCanCancelAnySessionUpTo12HoursBeforeItsScheduledTime),
      Gap(16.h),
        InstructionsItem(iconData: Icons.person, title: LangKeys.theStudentDidNotAttendTheSession, subTitle: LangKeys.theBooked30OfMinutesWillBeAddedToYourBalance),
      ],
    );
  }
}
