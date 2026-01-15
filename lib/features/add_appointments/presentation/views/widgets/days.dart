import 'package:el_kottab_teacher_app/main_imports.dart';
import '../../view_model/add_appointments_cubit.dart';
import '../day_appointments_view.dart';

class Days extends StatelessWidget {
  const Days({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddAppointmentsCubit>();

    return ListView.separated(
      itemCount: cubit.nameOfDays.length,
      separatorBuilder: (_, __) => Gap(12.h),
      itemBuilder: (context, index) {
        final day = cubit.nameOfDays[index];
        return InkWell(
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
              borderRadius: BorderRadius.circular(12.r),
              color: Colors.grey[200],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(day, style: AppStyles.black16SemiBold),
                const Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        );
      },
    );
  }
}
