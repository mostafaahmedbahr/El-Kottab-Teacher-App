import 'package:easy_localization/easy_localization.dart';
import 'package:el_kottab_teacher_app/main_imports.dart';
import '../../view_model/add_appointments_cubit.dart';
import '../../view_model/add_appointments_states.dart';

class TimePeriod extends StatelessWidget {
  const TimePeriod({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddAppointmentsCubit, AddAppointmentsStates>(
      builder: (context,state){
        var addAppointmentsCubit = context.read<AddAppointmentsCubit>();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LangKeys.chooseTheTimePeriodYouWantForTheSessions.tr(),
              style: AppStyles.black16SemiBold,
            ),
            Gap(12.h),
            GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12.w,
                  mainAxisSpacing: 12.h,
                  childAspectRatio: 1.7,
                ),
                itemCount: addAppointmentsCubit.timeSlots.length,
                itemBuilder: (context, index){
                  final timeSlot = addAppointmentsCubit.timeSlots[index];
                  bool isSelected = addAppointmentsCubit.selectedTimePeriod == timeSlot['label'];
                  return InkWell(
                    onTap: (){
                      addAppointmentsCubit.selectTimePeriod(timeSlot['label'].toString());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: isSelected ? AppColors.darkOlive : Colors.grey[300],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              timeSlot['icon'].toString(),
                              style: TextStyle(
                                fontSize: 20.sp,
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          Gap(4.h),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              timeSlot['label'].toString(),
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: isSelected ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
            )
          ],
        );
      },
    );
  }
}