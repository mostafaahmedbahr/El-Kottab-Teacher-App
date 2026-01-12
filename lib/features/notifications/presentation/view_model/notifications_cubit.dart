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
        getNotificationsCount();
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
    var result = await notificationsRepo!.deleteAllNotification();
    return result.fold((failure) {
      emit(DeleteNotificationsErrorState(failure.errMessage));
    }, (data) async {
      deleteAllNotificationsModel = data;
        emit(DeleteNotificationsSuccessState(data));

    });
  }

}