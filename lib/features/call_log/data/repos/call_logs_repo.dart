import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../models/calls_model.dart';

abstract class CallLogsRepo{

  Future<Either<Failure,CallsModel>> getAllCalls(String? type);




}