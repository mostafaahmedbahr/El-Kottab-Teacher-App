import 'package:dartz/dartz.dart';
import '../../../../main_imports.dart';
import '../models/add_appointment_model.dart';
import '../models/all_schedules_model.dart';
import '../models/delete_schedules_model.dart';
import '../models/update_schedule_model.dart';
import 'add_appointments_repo.dart';


class AddAppointmentsRepoImpl implements AddAppointmentsRepo {
  final ApiService? apiService;
  AddAppointmentsRepoImpl(this.apiService);




@override
Future<Either<Failure, AddAppointmentModel>> addAppointment({
  required String day,
  required String from,
  required String to,
})
async{
  try {
    var data = FormData.fromMap({
      'day': day,
      'from': from,
      'to': to,
    });
    var response = await apiService!.postData(
      endPoint: EndPoints.teacherSchdules,
      data: data,
    );
    AddAppointmentModel result = AddAppointmentModel.fromJson(response.data);
    return right(result);
  } catch (e) {
    return left(handleError(e));
  }
}


  @override
  Future<Either<Failure, DeleteScheduleModel>> deleteSchedule({
    required String scheduleId,
  })
  async{
    try {
      var response = await apiService!.deleteData(
        endPoint: "${EndPoints.teacherSchdules}/$scheduleId",
      );
      DeleteScheduleModel result = DeleteScheduleModel.fromJson(response.data);
      return right(result);
    } catch (e) {
      return left(handleError(e));
    }
  }



  @override
  Future<Either<Failure, AllSchedulesModel>> getAllSchedules()
  async{
    try {
      var response = await apiService!.getData(
        endPoint: EndPoints.teacherSchdules,
      );
      AllSchedulesModel result = AllSchedulesModel.fromJson(response.data);
      return right(result);
    } catch (e) {
      return left(handleError(e));
    }
  }



  @override
  Future<Either<Failure, UpdateScheduleModel>> updateSchedule({
    required String scheduleId,
    required String day,
    required String from,
    required String to,
  })
  async{
    try {
      var data = FormData.fromMap({
        'day': day,
        'from': from,
        'to': to,
      });
      var response = await apiService!.postData(
        endPoint: "${EndPoints.teacherSchdules}/$scheduleId",
        data: data,
      );
      UpdateScheduleModel result = UpdateScheduleModel.fromJson(response.data);
      return right(result);
    } catch (e) {
      return left(handleError(e));
    }
  }





}