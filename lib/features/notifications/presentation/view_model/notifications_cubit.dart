
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

  // int currentPage = 1;
  // bool hasMore = true;
  // bool isLoadingMore = false;
  // NotificationsModel? notificationsModel;
  // Future<void> getAllNotifications({bool loadMore = false , bool refresh = true}) async {
  //   try {
  //     if(refresh == true) {
  //       if (loadMore) {
  //         if (!hasMore || isLoadingMore) return;
  //         isLoadingMore = true;
  //         emit(GetAllNotificationsLoadingMoreState());
  //       } else {
  //         currentPage = 1;
  //         hasMore = true;
  //
  //         emit(GetAllNotificationsLoadingState());
  //       }
  //     }
  //     var result = await notificationsRepo!.getAllNotifications(page: currentPage);
  //
  //     return result.fold((failure) {
  //       emit(GetAllNotificationsErrorState(failure.errMessage));
  //       isLoadingMore = false;
  //     }, (data) async {
  //       if (data.code == 200) {
  //         if (loadMore && notificationsModel != null && data.data != null) {
  //           notificationsModel!.data!.addAll(data.data!);
  //           notificationsModel!.currentPage = data.currentPage;
  //           notificationsModel!.nextPageUrl = data.nextPageUrl;
  //         } else {
  //           notificationsModel = data;
  //         }
  //         currentPage = data.currentPage ?? currentPage;
  //         hasMore = data.nextPageUrl != null && data.nextPageUrl.toString().isNotEmpty;
  //
  //         emit(GetAllNotificationsSuccessState(data, isLoadMore: loadMore));
  //         isLoadingMore = false;
  //
  //         if (!loadMore) {
  //           readAllNotifications();
  //         }
  //       } else {
  //         final errorMessage = data.message?.toString() ?? 'Get All Notifications failed with code ${data.code}';
  //         emit(GetAllNotificationsErrorState(errorMessage));
  //         isLoadingMore = false;
  //       }
  //     });
  //   } catch (e) {
  //     emit(GetAllNotificationsErrorState(e.toString()));
  //     isLoadingMore = false;
  //   }
  // }
  //
  // Future<void> loadMoreNotifications() async {
  //   if (hasMore && !isLoadingMore) {
  //     currentPage++;
  //     await getAllNotifications(loadMore: true);
  //   }
  // }
  //
  // Future<void> refreshNotifications() async {
  //   await getAllNotifications(loadMore: false);
  // }
  //
  //
  //
  // ReadAllNotificationsModel? readAllNotificationsModel;
  // Future<void> readAllNotifications()
  // async {
  //   emit(ReadAllNotificationsLoadingState());
  //   var result = await notificationsRepo!.readAllNotifications();
  //   return result.fold((failure) {
  //     emit(ReadAllNotificationsErrorState(failure.errMessage));
  //   }, (data) async {
  //     if(data.code==200){
  //       readAllNotificationsModel = data;
  //       emit(ReadAllNotificationsSuccessState(data));
  //       notificationsCount();
  //     }
  //     else{
  //       final errorMessage = data.message?.toString() ?? 'Read All Notifications failed with code ${data.code}';
  //       emit(ReadAllNotificationsErrorState(errorMessage));
  //     }
  //   });
  // }
  //
  //
  // NotificationsCountModel? notificationsCountModel;
  // Future<void> notificationsCount()
  // async {
  //   emit(NotificationsCountLoadingState());
  //   var result = await notificationsRepo!.notificationsCount();
  //   return result.fold((failure) {
  //     emit(NotificationsCountErrorState(failure.errMessage));
  //   }, (data) async {
  //     if(data.code==200){
  //       notificationsCountModel = data;
  //       emit(NotificationsCountSuccessState(data));
  //     }
  //     else{
  //       final errorMessage = data.message?.toString() ?? 'Notifications Count failed with code ${data.code}';
  //       emit(NotificationsCountErrorState(errorMessage));
  //     }
  //   });
  // }
  //
  //
  // DeleteNotificationModel? deleteNotificationModel;
  // Future<void> deleteNotification({required String notifyId })
  // async {
  //   emit(DeleteNotificationsLoadingState());
  //   var result = await notificationsRepo!.deleteNotification(notifyId: notifyId);
  //   return result.fold((failure) {
  //     emit(DeleteNotificationsErrorState(failure.errMessage));
  //   }, (data) async {
  //     if(data.code==200){
  //       deleteNotificationModel = data;
  //       emit(DeleteNotificationsSuccessState(data));
  //     }
  //     else{
  //       final errorMessage = data.message?.toString() ?? 'Delete Notifications failed with code ${data.code}';
  //       emit(DeleteNotificationsErrorState(errorMessage));
  //     }
  //   });
  // }

}