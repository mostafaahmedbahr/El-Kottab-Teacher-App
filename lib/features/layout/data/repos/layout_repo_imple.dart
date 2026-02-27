import 'package:dartz/dartz.dart';
import '../../../../main_imports.dart';
import '../models/rate_student_model.dart';
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
}
