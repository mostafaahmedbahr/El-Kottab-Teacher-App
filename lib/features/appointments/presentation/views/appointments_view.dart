import 'package:easy_localization/easy_localization.dart';
import 'package:el_kottab_teacher_app/features/add_appointments/presentation/view_model/add_appointments_cubit.dart';
import 'package:el_kottab_teacher_app/features/add_appointments/presentation/view_model/add_appointments_states.dart';
import 'package:el_kottab_teacher_app/features/add_appointments/presentation/views/add_appointments_view.dart';
import 'package:el_kottab_teacher_app/features/appointments/presentation/views/widgets/appointments_instructions_texts.dart';
import 'package:el_kottab_teacher_app/features/appointments/presentation/views/widgets/empty_calendar.dart';
import 'package:el_kottab_teacher_app/main_imports.dart';

class AppointmentsView extends StatelessWidget {
  const AppointmentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<AddAppointmentsCubit, AddAppointmentsStates>(
          builder: (context, state) {
            final cubit = context.read<AddAppointmentsCubit>();

            if (cubit.allSchedulesModel == null &&
                state is GetAllScheduleLoadingState) {
              return const Center(child: CustomLoading());
            }

            final hasAppointments =
                cubit.appointments.values.any((list) => list.isNotEmpty);
            final totalAppointments = cubit.appointments.values
                .fold<int>(0, (sum, list) => sum + list.length);

            return Padding(
              padding: EdgeInsets.all(12.r),
              child: Column(
                children: [
                  AppointmentsInstructionsTexts(),
                  Gap(32.h),
                  EmptyCalendar(
                    hasAppointments: hasAppointments,
                    count: totalAppointments,
                  ),
                  const Spacer(),
                  CustomButton(
                    btnText: hasAppointments
                        ? LangKeys.addMore.tr()
                        : LangKeys.addAppointmentsNow.tr(),
                    onPressed: () {
                      AppNav.customNavigator(
                        context: context,
                        screen: AddAppointmentsView(),
                      );
                    },
                  ),
                  Gap(16.h),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
