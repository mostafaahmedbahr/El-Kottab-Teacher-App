 import 'package:easy_localization/easy_localization.dart';
import 'package:el_kottab_teacher_app/features/add_appointments/presentation/views/add_appointments_view.dart';
import 'package:el_kottab_teacher_app/features/appointments/presentation/views/widgets/appointments_instructions_texts.dart';
import 'package:el_kottab_teacher_app/features/appointments/presentation/views/widgets/empty_calendar.dart';
import 'package:el_kottab_teacher_app/main_imports.dart';

class AppointmentsView extends StatelessWidget {
  const AppointmentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Padding(
        padding:   EdgeInsets.all(12.0.r),
        child: Column(
            children: [
              AppointmentsInstructionsTexts(),
              Gap(32.h),
              EmptyCalendar(),
              Gap(64.h),
              CustomButton(
                  btnText: LangKeys.addAppointmentsNow.tr(),
                  onPressed: (){
                    AppNav.customNavigator(context: context, screen: AddAppointmentsView());
                  }),
            ],
        ),
      )),
    );
  }
}
