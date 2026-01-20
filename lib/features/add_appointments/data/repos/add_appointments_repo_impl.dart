import 'package:dartz/dartz.dart';
import '../../../../main_imports.dart';
import '../models/add_appointment_model.dart';
import 'add_appointments_repo.dart';


class AddAppointmentsRepoImpl implements AddAppointmentsRepo {
  final ApiService? apiService;
  AddAppointmentsRepoImpl(this.apiService);




@override
Future<Either<Failure, AddAppointmentModel>> addAppointment({
  required String day,
  required String from,
  required String to,
}) async{
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








}