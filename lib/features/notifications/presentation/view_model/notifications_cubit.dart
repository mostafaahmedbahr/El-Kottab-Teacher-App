import '../../../../main_imports.dart';
import '../../data/models/delete_notification_model.dart';
import '../../data/models/notifications_count_model.dart';
import '../../data/models/notifications_model.dart';
import '../../data/models/read_all_notifications_model.dart';
import '../../data/repos/notifications_repo.dart';
import 'notifications_states.dart';

class NotificationsCubit extends Cubit<NotificationsStates> {
  NotificationsCubit(this.notificationsRepo) : super(NotificationsInitState());
  NotificationsRepo? notificationsRepo;

  NotificationsModel? notificationsModel;
  Future<void> getAllNotifications()
  async {
    emit(GetAllNotificationsLoadingState());
    var result = await notificationsRepo!.getAllNotifications();
    return result.fold((failure) {
      emit(GetAllNotificationsErrorState(failure.errMessage));
    }, (data) async {
      notificationsModel = data;
      getNotificationsCount();
      emit(GetAllNotificationsSuccessState(data));

    });
  }

  ReadAllNotificationsModel? readAllNotificationsModel;
  Future<void> readAllNotifications()
  async {
    emit(ReadAllNotificationsLoadingState());
    var result = await notificationsRepo!.readAllNotifications();
    return result.fold((failure) {
      emit(ReadAllNotificationsErrorState(failure.errMessage));
    }, (data) async {
        readAllNotificationsModel = data;
        emit(ReadAllNotificationsSuccessState(data));
    });
  }


  NotificationsCountModel? notificationsCountModel;
  Future<void> getNotificationsCount()
  async {
    emit(NotificationsCountLoadingState());
    var result = await notificationsRepo!.getNotificationsCount();
    return result.fold((failure) {
      emit(NotificationsCountErrorState(failure.errMessage));
    }, (data) async {
        notificationsCountModel = data;
        emit(NotificationsCountSuccessState(data));
    });
  }


  DeleteAllNotificationsModel? deleteAllNotificationsModel;
  Future<void> deleteNotification()
  async {
    emit(DeleteNotificationsLoadingState());

    if (notificationsModel?.data == null || notificationsModel!.data!.isEmpty) {
      emit(DeleteNotificationsSuccessState(DeleteAllNotificationsModel(message: "No notifications to delete", status: 200)));
      return;
    }

    bool hasError = false;
    String errorMessage = "";

    for (var notification in notificationsModel!.data!) {
      if (notification.id != null) {
        var result = await notificationsRepo!.deleteNotificationById(notification.id!);
        result.fold((failure) {
          hasError = true;
          errorMessage = failure.errMessage;
        }, (data) {
          deleteAllNotificationsModel = data;
        });
      }
    }

    if (hasError && deleteAllNotificationsModel == null) {
      emit(DeleteNotificationsErrorState(errorMessage));
    } else {
      deleteAllNotificationsModel ??= DeleteAllNotificationsModel(message: "Success", status: 200);
      notificationsModel?.data?.clear();
      emit(DeleteNotificationsSuccessState(deleteAllNotificationsModel!));
    }
  }

  Future<void> deleteSingleNotification(int notifyId) async {
    print("Test: Deleting single notification with id: $notifyId");
    emit(DeleteNotificationsLoadingState());

    var result = await notificationsRepo!.deleteNotificationById(notifyId);
    
    result.fold((failure) {
      emit(DeleteNotificationsErrorState(failure.errMessage));
    }, (data) {
      // Remove from the local list to update UI immediately
      notificationsModel?.data?.removeWhere((element) => element.id == notifyId);
      emit(DeleteNotificationsSuccessState(data));
    });
  }

}