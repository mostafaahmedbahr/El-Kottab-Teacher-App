import 'package:easy_localization/easy_localization.dart';
import 'package:el_kottab_teacher_app/main_imports.dart';

import '../../view_model/add_appointments_cubit.dart';
import '../../view_model/add_appointments_states.dart';

class AvailableAppointments extends StatelessWidget {
  const AvailableAppointments({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddAppointmentsCubit, AddAppointmentsStates>(
      builder: (context,state){
        var addAppointmentsCubit = context.read<AddAppointmentsCubit>();
        return Column(
          children: [
            Text(
              LangKeys.availableAppointmentsThatYouCanChooseFrom.tr(),
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
                  childAspectRatio: 2,
                ),
                itemCount: addAppointmentsCubit.times.length,
                itemBuilder: (context, index){
                  final time = addAppointmentsCubit.times[index];
                  bool isSelected = addAppointmentsCubit.selectedTime == time;
                  return InkWell(
                    onTap: (){
                      addAppointmentsCubit.selectTime(time.toString());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: isSelected ? AppColors.darkOlive : Colors.grey[300],
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          time.toString(),
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
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
