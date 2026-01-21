import 'package:dartz/dartz.dart';
import '../../../../main_imports.dart';
 import '../models/home_banners_model.dart';
import '../models/successful_calls_model.dart';
import '../models/teacher_stats_model.dart';
import '../models/update_availability_model.dart';
import 'home_repo.dart';


class HomeRepoImpl implements HomeRepo {
  final ApiService? apiService;
  HomeRepoImpl(this.apiService);


@override
Future<Either<Failure, HomeBannersModel>> getHomeBanners() async{
  try {
    var response = await apiService!.getData(
      endPoint: EndPoints.banners,
    );
    HomeBannersModel result = HomeBannersModel.fromJson(response.data);
    return right(result);
  } catch (e) {
    return left(handleError(e));
  }
}

  @override
  Future<Either<Failure, TeacherStatsModel>> getTeacherStats({required int teacherId}) async{
    try {
      var response = await apiService!.getData(
        endPoint: "${EndPoints.teacherStats}/$teacherId",
      );
      TeacherStatsModel result = TeacherStatsModel.fromJson(response.data);
      return right(result);
    } catch (e) {
      return left(handleError(e));
    }
  }



  @override
  Future<Either<Failure, UpdateAvailabilityModel>> updateAvailability({required String status}) async{
    try {
      /// (active , in-active , on_call)
      ///
      var response = await apiService!.postData(
        endPoint: EndPoints.updateAvailability,
        data: {
          "avaliable" : status,
        }
      );
      UpdateAvailabilityModel result = UpdateAvailabilityModel.fromJson(response.data);
      return right(result);
    } catch (e) {
      return left(handleError(e));
    }
  }


  @override
  Future<Either<Failure, SuccessfulCallsModel>> getSuccessfulCalls({
    int? limit,
  }) async {
    try {
      var response = await apiService!.getData(
        endPoint: EndPoints.teacherCalls,
        query: {
          "limit": (limit ?? 5) > 5 ? 5 : (limit ?? 5),
        },
      );

      SuccessfulCallsModel result =
      SuccessfulCallsModel.fromJson(response.data);
      return right(result);
    } catch (e) {
      return left(handleError(e));
    }
  }



}