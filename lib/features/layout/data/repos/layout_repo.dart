import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../models/rate_student_model.dart';

abstract class LayoutRepo{

  Future<Either<Failure , RateStudentModel>> rateStudent({
    required dynamic comment ,
    required dynamic rate ,
    required dynamic targetId,
  });




}
