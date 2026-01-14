
import 'package:el_kottab_teacher_app/features/reviews/data/models/teacher_reviews_model.dart';

abstract class ReviewsStates{}

class ReviewsInitState extends ReviewsStates{}

class ChangeSelectedFilterState extends ReviewsStates{}

class GetTeacherReviewsLoadingState extends ReviewsStates{}
class GetTeacherReviewsSuccessState extends ReviewsStates{
  final TeacherReviewsModel teacherReviewsModel;
  GetTeacherReviewsSuccessState(this.teacherReviewsModel);
}
class GetTeacherReviewsErrorState extends ReviewsStates{
  final String error;
  GetTeacherReviewsErrorState(this.error);
}

