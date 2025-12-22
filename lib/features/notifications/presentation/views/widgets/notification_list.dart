

import '../../../../../main_imports.dart';
import '../../view_model/notifications_cubit.dart';
import '../../view_model/notifications_states.dart';
import 'notification_item.dart';

class NotificationList extends StatelessWidget {
  const NotificationList({super.key, required this.scrollController});
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsCubit, NotificationsStates>(
      builder: (context, state) {
        final cubit = context.read<NotificationsCubit>();
       // final notifications = cubit.notificationsModel?.data ?? [];

        // if (notifications.isEmpty &&
        //     state is! GetAllNotificationsLoadingState &&
        //     state is! GetAllNotificationsLoadingMoreState) {
        //   return Center(
        //     child: Text(
        //       LangKeys.noNotifications.tr(),
        //       style: TextStyle(
        //         fontSize: 16,
        //         color: Colors.grey[600],
        //       ),
        //     ),
        //   );
        // }

        return Column(
          children: [
            Expanded(
              child: ListView.separated(
                controller: scrollController,
                padding: EdgeInsets.all(16),
               // itemCount: notifications.length + (cubit.hasMore ? 1 : 0),
                itemCount:  10,
                separatorBuilder: (context, index) => Gap(12.h),
                itemBuilder: (context, index) {
                  // if (index == notifications.length && cubit.hasMore) {
                  //   return Center(
                  //     child: Padding(
                  //       padding: EdgeInsets.all(16),
                  //       child: CustomLoading(),
                  //     ),
                  //   );
                  // }


                //  final notify = notifications[index];
                  return NotificationItem(
                    id: "1",
                    title: "notify.title",
                    message: "notify.message",
                    time: "notify.createdAt",
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