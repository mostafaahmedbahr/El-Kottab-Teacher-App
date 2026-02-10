import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../models/calls_model.dart';
import '../models/call_revision_model.dart';

abstract class CallLogsRepo {
  Future<Either<Failure, CallsModel>> getAllCalls(String? type);

  Future<Either<Failure, CallRevisionModel>> addCallRevision(
    int callId,
    String revision,
  );
}
