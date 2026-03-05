import 'package:dartz/dartz.dart';
import '../../../../main_imports.dart';
import '../models/end_call_model.dart';
import '../models/rate_student_model.dart';
import '../models/start_call_model.dart';
import 'layout_repo.dart';


class LayoutRepoImpl implements LayoutRepo {
  final ApiService? apiService;

  LayoutRepoImpl(this.apiService);

  @override
  Future<Either<Failure, RateStudentModel>> rateStudent({required dynamic comment , required dynamic rate , required dynamic targetId})
  async {
    try {
      var data = FormData.fromMap({
        "comment":comment,
        "rate":rate,
        "target_id":targetId
      });

      var response = await apiService!.postData(
          endPoint: EndPoints.rate,
          data: data
      );
      RateStudentModel result = RateStudentModel.fromJson(response.data);
      return right(result);
    } catch (e) {
      return left(handleError(e));
    }
  }


  @override
  Future<Either<Failure, StartCallModel>> startCall({required dynamic studentId , required dynamic roomId})
  async {
    try {
      var data = FormData.fromMap({
        'teacher_id': studentId,
        'room_id': roomId,
      });

      var response = await apiService!.postData(
          endPoint: EndPoints.calls,
          data: data
      );
      StartCallModel result = StartCallModel.fromJson(response.data);
      return right(result);
    } catch (e) {
      return left(handleError(e));
    }
  }

  @override
  Future<Either<Failure, EndCallModel>> endCall({required dynamic durationMinutes , required dynamic roomId})
  async {
    try {
      var data = FormData.fromMap({
        'duration_minutes': durationMinutes,
        'room_id': roomId,
      });

      var response = await apiService!.postData(
          endPoint: EndPoints.callsEnd,
          data: data
      );
      EndCallModel result = EndCallModel.fromJson(response.data);
      return right(result);
    } catch (e) {
      return left(handleError(e));
    }
  }
}
