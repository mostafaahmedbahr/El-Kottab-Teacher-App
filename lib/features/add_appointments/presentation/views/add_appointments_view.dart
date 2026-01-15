import 'package:el_kottab_teacher_app/core/shared_widgets/global_app_bar.dart';
import 'package:el_kottab_teacher_app/main_imports.dart';
import '../view_model/add_appointments_cubit.dart';
import 'widgets/days.dart';

class AddAppointmentsView extends StatelessWidget {
  const AddAppointmentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppBar(title: LangKeys.addAppointmentsNow),
      body: BlocProvider(
        create: (_) => AddAppointmentsCubit(),
        child: Padding(
          padding: EdgeInsets.all(12.r),
          child: const Days(),
        ),
      ),
    );
  }
}
