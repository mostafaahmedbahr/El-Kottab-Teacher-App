

import '../../../../../main_imports.dart';
import '../../view_model/notifications_cubit.dart';
import '../../view_model/notifications_states.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    super.key,
    required this.id,
    required this.title,
    required this.message,
    required this.time,

    required this.icon,
    required this.onTap,
  });

  final int id;
  final String title;
  final String message;
  final String time;

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsCubit , NotificationsStates>(
      // buildWhen: (previous, current){
      //   return current is DeleteNotificationsErrorState || current is DeleteNotificationsSuccessState || current is DeleteNotificationsLoadingState;
      // },
      builder: (context,state){
        return GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color:   Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color:   Colors.grey.shade200 ,
                width:   1  ,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.darkOlive.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: AppColors.darkOlive,
                    size: 20,
                  ),
                ),
                Gap(12.h),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight:  FontWeight.w500  ,
                                color: AppColors.black,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          InkWell(
                            onTap: (){
                         //     context.read<NotificationsCubit>().deleteNotification(notifyId: id);
                            },
                            child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: AppColors.errorDark.withValues(alpha: 0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: SvgPicture.asset(SvgImages.trash,height: 16.h,)),
                          ),

                        ],
                      ),
                      Gap(4.h),
                      Text(
                        message,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey.shade600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Gap(8.h),
                      Text(
                        time,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },

    );
  }


}