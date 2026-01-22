import 'package:easy_localization/easy_localization.dart';
import 'package:el_kottab_teacher_app/features/add_appointments/presentation/views/widgets/time_picker.dart';
import '../../../../../core/helpers/format_date.dart';
import '../../../../../core/utils/enums.dart';
import '../../../../../main_imports.dart';
import '../../../data/models/appointment_model.dart';
import '../../view_model/add_appointments_cubit.dart';
import '../../view_model/add_appointments_states.dart';

class AppointmentItem extends StatelessWidget {
  final AppointmentModel appointment;
  final String dayName;
  final int index;

  const AppointmentItem({
    super.key,
    required this.appointment,
    required this.dayName,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddAppointmentsCubit>();
    final canSave = appointment.start != null && appointment.end != null;

    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: const Color.fromARGB(207, 64, 73, 31),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        children: [
          /// TIME ROW
          Row(
            children: [
              InkWell(
                onTap: () async {
                  final time = await customTimePicker(
                    context,
                    appointment.start ?? TimeOfDay.now(),
                  );

                  if (!context.mounted || time == null) return;

                  final result = cubit.setStartTime(dayName, index, time);
                  _handleResult(context, result);
                },
                child: Text(
                  appointment.start == null
                      ? '${LangKeys.from.tr()} --:--'
                      : appointment.start!.format(context),
                  style: AppStyles.white16SemiBold,
                ),
              ),
              Text('  →  ', style: AppStyles.white24SemiBold),
              InkWell(
                onTap: () async {
                  final time = await customTimePicker(
                    context,
                    appointment.end ?? appointment.start ?? TimeOfDay.now(),
                  );

                  if (!context.mounted || time == null) return;

                  final result = cubit.setEndTime(dayName, index, time);
                  _handleResult(context, result);
                },
                child: Text(
                  appointment.end == null
                      ? '--:--'
                      : appointment.end!.format(context),
                  style: AppStyles.white16SemiBold,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  cubit.removeAppointment(dayName, index);
                },
                child: const Icon(Icons.close, color: Colors.white),
              ),
            ],
          ),

          /// SAVE BUTTON صغير وأنيق
          if (canSave) ...[
            Gap(8.h),
            BlocConsumer<AddAppointmentsCubit, AddAppointmentsStates>(
              listener: (context, state) {
                if (state is AddAppointmentsSuccessState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('تم حفظ المعاد بنجاح'),
                      backgroundColor: Colors.green,
                    ),
                  );
                } else if (state is AddAppointmentsErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is AddAppointmentsLoadingState) {
                  return SizedBox(
                    width: 80.w,
                    height: 32.h,
                    child: const Center(
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                    ),
                  );
                }

                return SizedBox(
                  width: 80.w,   // عرض أصغر
                  height: 32.h,  // ارتفاع أصغر
                  child: GestureDetector(
                    onTap: () {
                      cubit.addAppointment(
                        day: dayName,
                        from: formatTimeTo24H(appointment.start!),
                        to: formatTimeTo24H(appointment.end!),
                      );

                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green, // أو gradient خفيف
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 2,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'حفظ',
                        style: AppStyles.white16SemiBold, // حجم أصغر
                      ),
                    ),
                  ),
                );
              },
            ),
          ],

        ],
      ),
    );
  }

  void _handleResult(BuildContext context, AppointmentResult result) {
    if (result == AppointmentResult.endBeforeStart) {
      _showError(
        context,
        LangKeys.theEndTimeShouldBeAfterTheStartTime,
      );
    } else if (result == AppointmentResult.conflict) {
      _showError(
        context,
        LangKeys.thisAppointmentOverlapsWithAnotherAppointment,
      );
    }
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message.tr())));
  }
}
