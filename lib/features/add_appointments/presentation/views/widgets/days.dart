// import 'package:el_kottab_teacher_app/main_imports.dart';
// import '../../view_model/add_appointments_cubit.dart';
// import '../day_appointments_view.dart';

// class Days extends StatelessWidget {
//   const Days({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final cubit = context.read<AddAppointmentsCubit>();

//     return ListView.separated(
//       itemCount: cubit.nameOfDays.length,
//       separatorBuilder: (_, __) => Gap(12.h),
//       itemBuilder: (context, index) {
//         final day = cubit.nameOfDays[index];
//         return InkWell(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (_) => BlocProvider.value(
//                   value: cubit,
//                   child: DayAppointmentsView(dayName: day),
//                 ),
//               ),
//             );
//           },
//           child: Container(
//             padding: EdgeInsets.all(16.r),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(12.r),
//               color: Colors.grey[200],
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(day, style: AppStyles.black16SemiBold),
//                 const Icon(Icons.arrow_forward_ios),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
import 'package:easy_localization/easy_localization.dart';
import 'package:el_kottab_teacher_app/features/add_appointments/data/models/appointment_model.dart';
import 'package:el_kottab_teacher_app/features/add_appointments/presentation/view_model/add_appointments_cubit.dart';
import 'package:el_kottab_teacher_app/features/add_appointments/presentation/views/day_appointments_view.dart';
import 'package:el_kottab_teacher_app/main_imports.dart';

class Days extends StatelessWidget {
  const Days({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<AddAppointmentsCubit>();

    return ListView.separated(
      itemCount: cubit.nameOfDays.length,
      separatorBuilder: (_, __) => Gap(12.h),
      itemBuilder: (context, index) {
        final day = cubit.nameOfDays[index];
        final list = cubit.appointments[day] ?? [];
        final hasAppointments = list.isNotEmpty;

        return InkWell(
          borderRadius: BorderRadius.circular(20.r),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: cubit,
                  child: DayAppointmentsView(dayName: day),
                ),
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: hasAppointments ? AppColors.darkOlive : Colors.white,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.08),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              children: [
                /// LINE
                Container(
                  width: 4.w,
                  height: 48.h,
                  decoration: BoxDecoration(
                    color: AppColors.darkOlive,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                Gap(12.w),

                /// TEXT
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        day,
                        style: hasAppointments
                            ? AppStyles.white12SemiBold
                            : AppStyles.black16SemiBold,
                      ),
                      Gap(4.h),
                      Text(
                        hasAppointments
                            ? _formatTime(list, context)
                            : LangKeys.noAppointments.tr(),
                        style: hasAppointments
                            ? AppStyles.white12SemiBold
                            : AppStyles.gray14Medium,
                      ),
                    ],
                  ),
                ),

                /// ACTION
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    color: hasAppointments
                        ? Colors.white.withOpacity(.15)
                        : AppColors.darkOlive,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    hasAppointments ? LangKeys.edit.tr() : LangKeys.add.tr(),
                    style: hasAppointments
                        ? AppStyles.white12SemiBold
                        : AppStyles.white12SemiBold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _formatTime(List<AppointmentModel> list, BuildContext context) {
    final first = list.first;
    if (first.start == null || first.end == null) return '';
    return '${first.start!.format(context)} - ${first.end!.format(context)}';
  }
}
