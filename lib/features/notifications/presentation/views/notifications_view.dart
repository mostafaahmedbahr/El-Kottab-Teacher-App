import 'package:easy_localization/easy_localization.dart';
import 'package:el_kottab_teacher_app/features/notifications/presentation/views/widgets/notification_list.dart';

import '../../../../core/app_services/remote_services/service_locator.dart';
import '../../../../main_imports.dart';
import '../../data/repos/notifications_repo_imple.dart';
import '../view_model/notifications_cubit.dart';
import '../view_model/notifications_states.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadNotifications();
    });
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // context.read<NotificationsCubit>().loadMoreNotifications();
    }
  }

  Future<void> _loadNotifications() async {
    // await context.read<NotificationsCubit>().getAllNotifications();
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> NotificationsCubit(getIt.get<NotificationsRepoImpl>()),
      child: BlocConsumer<NotificationsCubit , NotificationsStates>(
        // buildWhen:  (previous, current){
        //   return current is GetAllNotificationsErrorState
        //       || current is GetAllNotificationsLoadingState ||
        //       current is GetAllNotificationsSuccessState || current is DeleteNotificationsSuccessState;
        // },
        listener: (context,state){
          // if(state is DeleteNotificationsSuccessState){
          //   context.read<NotificationsCubit>().getAllNotifications(refresh: false,);
          //   NewToast.showNewSuccessToast(msg: state.deleteNotificationModel.message.toString(), context: context);
          // }
          // else if (state is DeleteNotificationsErrorState){
          //   NewToast.showNewErrorToast(msg: state.error, context: context);
          // }
        },
        builder:  (context,state){
          return Scaffold(
            appBar: AppBar(
              title: Text(LangKeys.notifications.tr()),
              actions: [
             //   if(context.read<NotificationsCubit>().notificationsModel!=null && context.read<NotificationsCubit>().notificationsModel!.data!.isNotEmpty)
                TextButton(
                  onPressed: (){
                   // context.read<NotificationsCubit>().deleteNotification(notifyId: "all");
                  },
                    child: Text(LangKeys.deleteAll.tr(),style: TextStyle(
                      color: AppColors.errorDark,
                    ),),
                ),
              ],
            ),
            body:  NotificationList( scrollController: _scrollController,),
            // body: RefreshIndicator(
            //   onRefresh: () => context.read<NotificationsCubit>().refreshNotifications(),
            //   child:  state is GetAllNotificationsLoadingState
            //       ? NotificationsLoadingShimmer():
            //   state is GetAllNotificationsErrorState ?
            //   ErrorUi(errorState: state.error,
            //       onPressed: (){
            //         context.read<NotificationsCubit>().getAllNotifications();
            //       }):
            //   NotificationList( scrollController: _scrollController,),
            // ),
          );
        },

      ),
    );
  }
}