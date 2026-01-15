import 'package:el_kottab_teacher_app/core/shared_widgets/global_app_bar.dart';
import 'package:el_kottab_teacher_app/main_imports.dart';
import '../view_model/add_appointments_cubit.dart';
import '../view_model/add_appointments_states.dart';
import 'widgets/appointment_item.dart';

class DayAppointmentsView extends StatelessWidget {
  final String dayName;

  const DayAppointmentsView({super.key, required this.dayName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppBar(title: dayName),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context
              .read<AddAppointmentsCubit>()
              .addEmptyAppointment(dayName);
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<AddAppointmentsCubit, AddAppointmentsStates>(
        builder: (context, state) {
          final cubit = context.read<AddAppointmentsCubit>();
          final list = cubit.appointments[dayName] ?? [];

          if (list.isEmpty) {
            return const Center(child: Text('لا توجد مواعيد'));
          }

          return ListView.builder(
            padding: EdgeInsets.all(12.r),
            itemCount: list.length,
            itemBuilder: (context, index) {
              return AppointmentItem(
                dayName: dayName,
                index: index,
                appointment: list[index],
              );
            },
          );
        },
      ),
    );
  }
}
