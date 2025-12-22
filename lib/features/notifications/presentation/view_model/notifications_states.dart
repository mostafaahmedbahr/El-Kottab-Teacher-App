
import '../../data/models/delete_notification_model.dart';
import '../../data/models/notifications_count_model.dart';
import '../../data/models/notifications_model.dart';

abstract class NotificationsStates{}

class NotificationsInitState extends NotificationsStates{}

class GetAllNotificationsLoadingState extends NotificationsStates{}
class GetAllNotificationsSuccessState extends NotificationsStates {
  final NotificationsModel notificationsModel;
  final bool isLoadMore;

  GetAllNotificationsSuccessState(this.notificationsModel, {this.isLoadMore = false});
}
class GetAllNotificationsErrorState extends NotificationsStates{
  final String error;
  GetAllNotificationsErrorState(this.error);
}
class GetAllNotificationsLoadingMoreState extends NotificationsStates {}


class ReadAllNotificationsLoadingState extends NotificationsStates{}
class ReadAllNotificationsSuccessState extends NotificationsStates{
  // ReadAllNotificationsModel readAllNotificationsModel;
  // ReadAllNotificationsSuccessState(this.readAllNotificationsModel);
}
class ReadAllNotificationsErrorState extends NotificationsStates{
  final String error;
  ReadAllNotificationsErrorState(this.error);
}

class NotificationsCountLoadingState extends NotificationsStates{}
class NotificationsCountSuccessState extends NotificationsStates{
  NotificationsCountModel notificationsCountModel;
  NotificationsCountSuccessState(this.notificationsCountModel);
}
class NotificationsCountErrorState extends NotificationsStates{
  final String error;
  NotificationsCountErrorState(this.error);
}

class DeleteNotificationsLoadingState extends NotificationsStates{}
class DeleteNotificationsSuccessState extends NotificationsStates{
  DeleteNotificationModel deleteNotificationModel;
  DeleteNotificationsSuccessState(this.deleteNotificationModel);
}
class DeleteNotificationsErrorState extends NotificationsStates{
  final String error;
  DeleteNotificationsErrorState(this.error);
}