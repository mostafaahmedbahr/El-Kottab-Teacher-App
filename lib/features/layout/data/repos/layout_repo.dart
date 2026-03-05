import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../models/end_call_model.dart';
import '../models/rate_student_model.dart';
import '../models/start_call_model.dart';

abstract class LayoutRepo{

  Future<Either<Failure , RateStudentModel>> rateStudent({
    required dynamic comment ,
    required dynamic rate ,
    required dynamic targetId,
  });
  Future<Either<Failure , StartCallModel>> startCall({required dynamic studentId , required dynamic roomId});
  Future<Either<Failure , EndCallModel>> endCall({required dynamic durationMinutes , required dynamic roomId});



}
