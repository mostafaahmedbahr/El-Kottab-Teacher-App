import 'package:easy_localization/easy_localization.dart';
import 'package:el_kottab_teacher_app/features/notifications/presentation/views/widgets/notification_list.dart';
 import '../../../../main_imports.dart';
import '../view_model/notifications_cubit.dart';
import '../view_model/notifications_states.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  void initState() {
    context.read<NotificationsCubit>().getAllNotifications();
    context.read<NotificationsCubit>().readAllNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationsCubit, NotificationsStates>(
      listener: (context, state) {
        if (state is DeleteNotificationsSuccessState) {
          Toast.showSuccessToast(
            msg: state.deleteNotificationModel.message.toString(),
            context: context,
          );
          context.read<NotificationsCubit>().getAllNotifications();
          // context.read<NotificationsCubit>().getNotificationsCount();
          // context.read<NotificationsCubit>().readAllNotifications();
        } else if (state is DeleteNotificationsErrorState) {
          Toast.showErrorToast(msg: state.error.toString(), context: context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(LangKeys.notifications.tr()),
            actions: [
              if (context.read<NotificationsCubit>().notificationsModel !=
                      null &&
                  context
                      .read<NotificationsCubit>()
                      .notificationsModel!
                      .data!
                      .isNotEmpty)
                TextButton(
                  onPressed: () {
                    context.read<NotificationsCubit>().deleteNotification();
                  },
                  child: Text(
                    LangKeys.deleteAll.tr(),
                    style: TextStyle(color: AppColors.errorDark),
                  ),
                ),
            ],
          ),
          body: NotificationList(),
        );
      },
    );
  }
}
