import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../core/shared_cubits/auth_cubit/auth_cubit.dart';
import '../../../../../main_imports.dart';
import '../../../../notifications/presentation/view_model/notifications_cubit.dart';
import '../../../../notifications/presentation/view_model/notifications_states.dart';
import 'package:badges/badges.dart' as badges;

import '../../../../notifications/presentation/views/notifications_view.dart';
import '../../../../profile/presentation/view_model/profile_cubit.dart';
import '../../../../profile/presentation/view_model/profile_states.dart';
class ProfileNameAndNotificationIcon extends StatefulWidget {
  const ProfileNameAndNotificationIcon({super.key});

  @override
  State<ProfileNameAndNotificationIcon> createState() => _ProfileNameAndNotificationIconState();
}

class _ProfileNameAndNotificationIconState extends State<ProfileNameAndNotificationIcon> {
  @override
  void initState() {
    super.initState();

    final authCubit = context.read<AuthCubit>();

    if (authCubit.isGuest) return;

    final profileCubit = context.read<ProfileCubit>();
    final notificationsCubit = context.read<NotificationsCubit>();

    if (profileCubit.profileModel == null) {
      profileCubit.getProfileData();
    }

    notificationsCubit.getNotificationsCount();
    notificationsCubit.getAllNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileStates>(
      builder: (context, state) {
        final profileCubit = context.read<ProfileCubit>();
        final profile = profileCubit.profileModel;
        return
          Skeletonizer(
            enabled: profile == null || state is GetProfileDataLoadingState,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CustomNetWorkImage(
                      raduis: 50.r,
                      imageUrl: profile?.data?.image ?? "",
                      width: 40.w,
                      height: 40.h,
                      fit: BoxFit.cover,
                    ),
                    const Gap(6),
                    Padding(
                      padding:   EdgeInsets.symmetric(horizontal: 10.w),
                      child: Text(
                        profile?.data?.name ?? " ",
                        style: AppStyles.black16SemiBold,
                      ),
                    ),
                  ],
                ),
                BlocBuilder<NotificationsCubit , NotificationsStates>(
                  buildWhen:  (previous, current) {
                    return current is NotificationsCountLoadingState
                        || current is NotificationsCountSuccessState
                        || current is NotificationsCountErrorState;
                  },
                  builder: (context,state){
                    final int count = context.read<NotificationsCubit>().notificationsCountModel?.data?.count ?? 0;
                    return InkWell(
                      onTap: () {
                        AppNav.customNavigator(
                          context: context,
                          screen: const NotificationView(),
                        );
                      },
                      child: badges.Badge(
                        position: badges.BadgePosition.topEnd(top: 5.h, end: 10.h),
                        showBadge: count > 0,
                        badgeContent: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder: (child, animation) =>
                              ScaleTransition(scale: animation, child: child),
                          child: Text(
                            "$count",
                            key: ValueKey<int>(count),
                            style:   TextStyle(color: Colors.white, fontSize: 10.sp),
                          ),
                        ),
                        child: SvgPicture.asset(
                          SvgImages.notify,
                          colorFilter: const ColorFilter.mode(
                            AppColors.darkOlive,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
      },
    );
  }
}