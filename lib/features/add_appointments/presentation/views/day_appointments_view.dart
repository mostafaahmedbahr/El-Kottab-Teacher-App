import 'package:easy_localization/easy_localization.dart';
import 'package:el_kottab_teacher_app/core/shared_widgets/global_app_bar.dart';
import 'package:el_kottab_teacher_app/features/add_appointments/presentation/view_model/add_appointments_cubit.dart';
import 'package:el_kottab_teacher_app/features/add_appointments/presentation/view_model/add_appointments_states.dart';
import 'package:el_kottab_teacher_app/features/add_appointments/presentation/views/widgets/appointment_item.dart';
import 'package:el_kottab_teacher_app/main_imports.dart';

class DayAppointmentsView extends StatelessWidget {
  final String dayName;

  const DayAppointmentsView({super.key, required this.dayName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppBar(title: dayName.tr()),
      body: BlocListener<AddAppointmentsCubit, AddAppointmentsStates>(
        listenWhen: (previous, current) =>
            current is AddAppointmentsSuccessState ||
            current is AddAppointmentsErrorState ||
            current is UpdateScheduleSuccessState ||
            current is UpdateScheduleErrorState,
        listener: (context, state) {
          if (state is AddAppointmentsSuccessState) {
            Toast.showSuccessToast(
              msg: state.addAppointmentModel.message.toString(),
              context: context,
            );
          } else if (state is AddAppointmentsErrorState) {
            Toast.showErrorToast(
              msg: state.error.toString(),
              context: context,
            );
          } else if (state is UpdateScheduleSuccessState) {
            Toast.showSuccessToast(
              msg: state.updateScheduleModel.message.toString(),
              context: context,
            );
          } else if (state is UpdateScheduleErrorState) {
            Toast.showErrorToast(
              msg: state.error.toString(),
              context: context,
            );
          }
        },
        child: BlocBuilder<AddAppointmentsCubit, AddAppointmentsStates>(
          builder: (context, state) {
          final cubit = context.read<AddAppointmentsCubit>();
          final list = cubit.appointments[dayName] ?? [];
          if (list.isEmpty) {
            return Center(
              child: Text(
                LangKeys.noAppointments.tr(),
                style: AppStyles.gray14Medium,
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
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
    ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final cubit = context.read<AddAppointmentsCubit>();
          cubit.addEmptyAppointment(dayName);
        },
        backgroundColor: AppColors.darkOlive,
        child: const Icon(Icons.add, color: AppColors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
