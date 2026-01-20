import 'package:el_kottab_teacher_app/features/add_appointments/data/models/add_appointment_model.dart';

abstract class AddAppointmentsStates{}

class AddAppointmentsInitState extends AddAppointmentsStates{}

class SelectDayState extends AddAppointmentsStates{}
class SelectTimePeriodState extends AddAppointmentsStates{}
class SelectTimeState extends AddAppointmentsStates{}


class UpdateAppointmentsState extends AddAppointmentsStates {}

class AddAppointmentsLoadingState extends AddAppointmentsStates {}
class AddAppointmentsSuccessState extends AddAppointmentsStates {
  final AddAppointmentModel addAppointmentModel;
  AddAppointmentsSuccessState(this.addAppointmentModel);
}
class AddAppointmentsErrorState extends AddAppointmentsStates {
  final String error;
  AddAppointmentsErrorState(this.error);

}