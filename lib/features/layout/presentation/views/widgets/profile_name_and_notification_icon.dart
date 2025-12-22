import '../../../../../main_imports.dart';
import '../../../../notifications/presentation/views/notifications_view.dart';

class ProfileNameAndNotificationIcon extends StatelessWidget {
  const ProfileNameAndNotificationIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CustomNetWorkImage(
              raduis: 50,
              imageUrl:   "",
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
            const Gap(6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                  " ",
                style: AppStyles.black16SemiBold,
              ),
            ),
          ],
        ),
        InkWell(
          onTap: () {
            AppNav.customNavigator(
              context: context,
              screen: const NotificationView(),
            );
          },
          child: SvgPicture.asset(
            SvgImages.notify,
            colorFilter: const ColorFilter.mode(
              AppColors.darkOlive,
              BlendMode.srcIn,
            ),
          ),
        ),
      ],
    );
  }
}
