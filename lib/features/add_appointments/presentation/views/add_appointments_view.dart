import 'package:el_kottab_teacher_app/core/shared_widgets/global_app_bar.dart';
import 'package:el_kottab_teacher_app/features/add_appointments/presentation/view_model/add_appointments_cubit.dart';
import 'package:el_kottab_teacher_app/features/add_appointments/presentation/views/widgets/available_appointments.dart';
import 'package:el_kottab_teacher_app/features/add_appointments/presentation/views/widgets/days.dart';
import 'package:el_kottab_teacher_app/features/add_appointments/presentation/views/widgets/time_period.dart';
import 'package:el_kottab_teacher_app/main_imports.dart';

class AddAppointmentsView extends StatelessWidget {
  const AddAppointmentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppBar(title: LangKeys.addAppointmentsNow),
      body: BlocProvider(
        create: (context)=>AddAppointmentsCubit(),
        child: Padding(
          padding:   EdgeInsets.all(12.0.r),
          child: ListView(
            children: [
              Days(),
              Gap(12.h),
              TimePeriod(),
              Gap(12.h),
              AvailableAppointments(),
            ],
          ),
        ),
      ),
    );
  }
}
