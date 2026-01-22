import 'package:el_kottab_teacher_app/core/app_services/remote_services/service_locator.dart';
import 'package:el_kottab_teacher_app/core/shared_widgets/global_app_bar.dart';
import 'package:el_kottab_teacher_app/features/add_appointments/data/repos/add_appointments_repo_impl.dart';
import 'package:el_kottab_teacher_app/main_imports.dart';
import '../view_model/add_appointments_cubit.dart';

class AddAppointmentsView extends StatelessWidget {
  const AddAppointmentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppBar(title: LangKeys.addAppointmentsNow),
      body: BlocProvider(
        create: (_) => AddAppointmentsCubit(getIt.get<AddAppointmentsRepoImpl>()),
        child: Padding(
          padding: EdgeInsets.all(12.r),

        ),
      ),
    );
  }
}
