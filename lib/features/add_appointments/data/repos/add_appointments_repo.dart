import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../models/add_appointment_model.dart';
import '../models/all_schedules_model.dart';
import '../models/delete_schedules_model.dart';

abstract class AddAppointmentsRepo {
  Future<Either<Failure, AddAppointmentModel>> addAppointment({
    required String day,
    required String from,
    required String to,
  });


  Future<Either<Failure, DeleteScheduleModel>> deleteSchedule({
    required String scheduleId,
  });

  Future<Either<Failure, AllSchedulesModel>> getAllSchedules();

}
