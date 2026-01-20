import 'package:el_kottab_teacher_app/features/add_appointments/data/models/add_appointment_model.dart';
import 'package:el_kottab_teacher_app/features/add_appointments/data/models/all_schedules_model.dart';
import 'package:el_kottab_teacher_app/features/add_appointments/data/models/delete_schedules_model.dart';

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

class DeleteScheduleLoadingState extends AddAppointmentsStates {}
class DeleteScheduleSuccessState extends AddAppointmentsStates {
  final DeleteScheduleModel deleteScheduleModel;
  DeleteScheduleSuccessState(this.deleteScheduleModel);
}
class DeleteScheduleErrorState extends AddAppointmentsStates {
  final String error;
  DeleteScheduleErrorState(this.error);

}


class GetAllScheduleLoadingState extends AddAppointmentsStates {}
class GetAllScheduleSuccessState extends AddAppointmentsStates {
  final AllSchedulesModel allSchedulesModel;
  GetAllScheduleSuccessState(this.allSchedulesModel);
}
class GetAllScheduleErrorState extends AddAppointmentsStates {
  final String error;
  GetAllScheduleErrorState(this.error);

}