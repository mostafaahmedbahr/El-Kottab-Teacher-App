import 'package:dartz/dartz.dart';
import '../../../../main_imports.dart';
import '../models/calls_model.dart';
import 'call_logs_repo.dart';


class CallLogsRepoImpl implements CallLogsRepo {
  final ApiService? apiService;
  CallLogsRepoImpl(this.apiService);




  @override
  Future<Either<Failure, CallsModel>> getAllCalls(String? type) async {
    try {
      var response = await apiService!.getData(
        endPoint: EndPoints.teacherCalls,
        query: type == null
            ? null
            : {
          "status": type,
        },
      );

      CallsModel result = CallsModel.fromJson(response.data);
      return right(result);
    } catch (e) {
      return left(handleError(e));
    }
  }









}