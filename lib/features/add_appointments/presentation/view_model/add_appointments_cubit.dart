import 'package:easy_localization/easy_localization.dart';

import '../../../../main_imports.dart';
import 'add_appointments_states.dart';

class AddAppointmentsCubit extends Cubit<AddAppointmentsStates> {
  AddAppointmentsCubit() : super(AddAppointmentsInitState());

  static AddAppointmentsCubit get(context) => BlocProvider.of(context);


  List<String> nameOfDays = [
    LangKeys.saturday.tr(),
    LangKeys.sunday.tr(),
    LangKeys.monday.tr(),
    LangKeys.tuesday.tr(),
    LangKeys.wednesday.tr(),
    LangKeys.thursday.tr(),
    LangKeys.friday.tr(),
  ];


  String selectedDay = '';
  void selectDay(String day){
    selectedDay = day;
    emit(SelectDayState());
  }



  List<Map<String, String>> timeSlots = [
    {
      'label': '12AM - 4AM',
      'icon': '🌙',
      'description': 'Late Night',
    },
    {
      'label': '4AM - 8AM',
      'icon': '🌅',
      'description': 'Early Morning',
    },
    {
      'label': '8AM - 12PM',
      'icon': '☀️',
      'description': 'Morning',
    },
    {
      'label': '12PM - 4PM',
      'icon': '🏙️',
      'description': 'Afternoon',
    },
    {
      'label': '4PM - 8PM',
      'icon': '🌆',
      'description': 'Evening',
    },
    {
      'label': '8PM - 12AM',
      'icon': '🌃',
      'description': 'Night',
    },
  ];

  String selectedTimePeriod = '';
  void selectTimePeriod(String timePeriod){
    selectedTimePeriod = timePeriod;
    emit(SelectTimePeriodState());
  }

  String selectedTime = '';
  void selectTime(String time){
    selectedTime = time;
    emit(SelectTimeState());
  }
  List<String> times = ["4:00" , "5:00" , "6:15" , "8:00" , "8:30"];
}