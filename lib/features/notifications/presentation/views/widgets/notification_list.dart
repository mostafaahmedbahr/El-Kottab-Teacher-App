import 'package:easy_localization/easy_localization.dart';

import '../../../../../core/shared_widgets/custom_error_widget.dart';
import '../../../../../main_imports.dart';
import '../../view_model/notifications_cubit.dart';
import '../../view_model/notifications_states.dart';
import 'notification_item.dart';

class NotificationList extends StatelessWidget {
  const NotificationList({super.key,  });


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsCubit, NotificationsStates>(
      builder: (context, state) {
        final cubit = context.read<NotificationsCubit>();
        final notifications = cubit.notificationsModel?.data ?? [];

        if (notifications.isEmpty &&
            state is! GetAllNotificationsLoadingState &&
            state is! GetAllNotificationsLoadingMoreState) {
          return Center(
            child: Text(
              LangKeys.noNotifications.tr(),
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          );
        }

        return Column(
          children: [
            Expanded(
              child:state is GetAllNotificationsLoadingState ? CustomLoading() :
                  state is GetAllNotificationsErrorState ? CustomErrorWidget(onTap: (){
                    context.read<NotificationsCubit>().getAllNotifications();
                  }, errorMsg: state.error.toString())
                  : ListView.separated(
                padding: EdgeInsets.all(16),
               itemCount: notifications.length  ,
                separatorBuilder: (context, index) => Gap(12.h),
                itemBuilder: (context, index) {
                  final notify = notifications[index];
                  return NotificationItem(
                    id: notify.id!,
                    title: notify.title!,
                    message: notify.body!,
                    time: notify.createdAt.toString(),
                    icon: Icons.rice_bowl,
                    onTap: () {
                      // Handle notification tap
                    },
                  );
                },
              ),
            ),

            // if (!cubit.hasMore && notifications.isNotEmpty)
            //   Container(
            //     padding: EdgeInsets.all(16),
            //     child: Text(
            //       LangKeys.noMoreNotifications.tr(),
            //       style: TextStyle(
            //         color: Colors.grey[600],
            //         fontSize: 14,
            //       ),
            //       textAlign: TextAlign.center,
            //     ),
            //   ),
          ],
        );
      },
    );
  }
}