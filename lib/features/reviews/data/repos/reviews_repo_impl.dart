import 'package:dartz/dartz.dart';

import '../../../../main_imports.dart';
import '../models/teacher_reviews_model.dart';
import 'reviews_repo.dart';


class ReviewsRepoImpl implements ReviewsRepo {
  final ApiService? apiService;
  ReviewsRepoImpl(this.apiService);


@override
Future<Either<Failure, TeacherReviewsModel>> getTeacherReviews({required String type}) async{
  try {
    var response = await apiService!.getData(
      endPoint: "${EndPoints.teacherReviews}/${CacheHelper.getData(key: "userId")}",
      query: {
        "type" : type,
      }
    );
    TeacherReviewsModel result = TeacherReviewsModel.fromJson(response.data);
    return right(result);
  } catch (e) {
    return left(handleError(e));
  }
}







}