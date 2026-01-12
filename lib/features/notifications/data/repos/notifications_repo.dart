import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../models/delete_notification_model.dart';
import '../models/notifications_count_model.dart';
import '../models/notifications_model.dart';
import '../models/read_all_notifications_model.dart';

abstract class NotificationsRepo{

   Future<Either<Failure , NotificationsModel>> getAllNotifications();
  Future<Either<Failure , ReadAllNotificationsModel>> readAllNotifications();
  Future<Either<Failure , NotificationsCountModel>> getNotificationsCount();
   Future<Either<Failure , DeleteAllNotificationsModel>> deleteAllNotification();

}

