import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../models/add_appointment_model.dart';

abstract class AddAppointmentsRepo {
  Future<Either<Failure, AddAppointmentModel>> addAppointment({
    required String day,
    required String from,
    required String to,
  });
}
