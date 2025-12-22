import 'package:easy_localization/easy_localization.dart';
import 'package:el_kottab_teacher_app/features/add_appointments/presentation/view_model/add_appointments_states.dart';
import 'package:el_kottab_teacher_app/main_imports.dart';

import '../../view_model/add_appointments_cubit.dart';

class Days extends StatelessWidget {
  const Days({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddAppointmentsCubit, AddAppointmentsStates>(
      builder: (context, state) {
        var addAppointmentsCubit = context.read<AddAppointmentsCubit>();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LangKeys.chooseTheDaysOnWhichYouWantToGiveLessons.tr(),
              style: AppStyles.black16SemiBold,
            ),
            Gap(12.h),
            SizedBox(
              height: 100.h, // Increased height to accommodate text better
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  String dayName = addAppointmentsCubit.nameOfDays[index];
                  bool isSelected = addAppointmentsCubit.selectedDay == dayName;
                  return GestureDetector(
                    onTap: () {
                      addAppointmentsCubit.selectDay(dayName);
                    },
                    child: Container(
                      height: 80.h,
                      width: 80.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected ? AppColors.darkOlive : Colors.grey[300],
                        border: isSelected
                            ? Border.all(color: AppColors.darkOlive, width: 2)
                            : null,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            dayName,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: isSelected ? Colors.white : Colors.grey[700],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Gap(4.h),
                          Text(
                            "${index + 1}",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : AppColors.darkOlive,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Gap(8.w);
                },
                itemCount: addAppointmentsCubit.nameOfDays.length,
              ),
            ),
          ],
        );
      },
    );
  }
}