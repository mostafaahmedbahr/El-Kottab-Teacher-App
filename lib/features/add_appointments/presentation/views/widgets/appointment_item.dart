// import 'package:easy_localization/easy_localization.dart';
// import 'package:el_kottab_teacher_app/features/add_appointments/presentation/view_model/add_appointments_states.dart';
// import 'package:el_kottab_teacher_app/main_imports.dart';
// import '../../../../../core/utils/enums.dart';
// import '../../../data/models/appointment_model.dart';
// import '../../view_model/add_appointments_cubit.dart';

// class AppointmentItem extends StatelessWidget {
//   final AppointmentModel appointment;
//   final String dayName;
//   final int index;
//   const AppointmentItem({
//     super.key,
//     required this.appointment,
//     required this.dayName,
//     required this.index,
//   });
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AddAppointmentsCubit , AddAppointmentsStates>(
//       builder: (context,state){
//         final addAppointmentsCubit = context.read<AddAppointmentsCubit>();
//         return Card(
//           color: AppColors.darkOlive,
//           margin: EdgeInsets.only(bottom: 12.h),
//           child: Padding(
//             padding: EdgeInsets.all(12.r),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 InkWell(
//                   onTap: () async {
//                     final time = await showTimePicker(
//                       context: context,
//                       initialTime:
//                       appointment.start ?? TimeOfDay.now(),
//                     );
//                     if (!context.mounted || time == null) return;
//                     final result =
//                     addAppointmentsCubit.setStartTime(dayName, index, time);
//                     _handleResult(context, result);
//                   },
//                   child: Text(
//                     appointment.start == null
//                         ? '${LangKeys.from.tr()} -- : --'
//                         : '${LangKeys.from.tr()} ${appointment.start!.format(context)}',style: AppStyles.white16SemiBold,
//                   ),
//                 ),

//                 InkWell(
//                   onTap: () async {
//                     final time = await showTimePicker(
//                       context: context,
//                       initialTime:
//                       appointment.end ??
//                           appointment.start ??
//                           TimeOfDay.now(),
//                     );

//                     if (!context.mounted || time == null) return;

//                     final result =
//                     addAppointmentsCubit.setEndTime(dayName, index, time);

//                     _handleResult(context, result);
//                   },
//                   child: Text(
//                     appointment.end == null
//                         ? '${LangKeys.to.tr()} -- : --'
//                         : '${LangKeys.to.tr()} ${appointment.end!.format(context)}',style: AppStyles.white16SemiBold,
//                   ),
//                 ),

//                 IconButton(
//                   icon:   Icon(Icons.delete, color: AppColors.errorDark),
//                   onPressed: () {
//                     addAppointmentsCubit.removeAppointment(dayName, index);
//                   },
//                 ),
//               ],
//             ),
//           ),
//         );
//       },

//     );
//   }

//   void _handleResult(
//       BuildContext context,
//       AppointmentResult result,
//       ) {
//     if (result == AppointmentResult.endBeforeStart) {
//       _showError(context, LangKeys.theEndTimeShouldBeAfterTheStartTime);
//     } else if (result == AppointmentResult.conflict) {
//       _showError(context, LangKeys.thisAppointmentOverlapsWithAnotherAppointment);
//     }
//   }

//   void _showError(BuildContext context, String message) {
//     ScaffoldMessenger.of(context)
//         .showSnackBar(SnackBar(content: Text(message.tr())));
//   }
// }
import 'package:easy_localization/easy_localization.dart';
import 'package:el_kottab_teacher_app/core/utils/enums.dart';
import 'package:el_kottab_teacher_app/features/add_appointments/data/models/appointment_model.dart';
import 'package:el_kottab_teacher_app/features/add_appointments/presentation/view_model/add_appointments_cubit.dart';
import 'package:el_kottab_teacher_app/features/add_appointments/presentation/views/widgets/time_picker.dart';
import 'package:el_kottab_teacher_app/main_imports.dart';

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

    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 30.h),
      decoration: BoxDecoration(
        color: const Color.fromARGB(207, 64, 73, 31),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          Icon(Icons.access_time, color: Colors.white, size: 18),

          Gap(8.w),

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

          /// TO
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

          /// DELETE
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              cubit.removeAppointment(dayName, index);
            },
            child: Icon(Icons.close, color: Colors.white, size: 20),
          ),
        ],
      ),
    );
  }

  void _handleResult(BuildContext context, AppointmentResult result) {
    if (result == AppointmentResult.endBeforeStart) {
      _showError(context, LangKeys.theEndTimeShouldBeAfterTheStartTime);
    } else if (result == AppointmentResult.conflict) {
      _showError(
        context,
        LangKeys.thisAppointmentOverlapsWithAnotherAppointment,
      );
    }
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message.tr())));
  }
}
