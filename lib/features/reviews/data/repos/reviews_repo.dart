import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../models/teacher_reviews_model.dart';

abstract class ReviewsRepo{

   Future<Either<Failure,TeacherReviewsModel>> getTeacherReviews({required String type});





}