import 'package:el_kottab_teacher_app/features/add_appointments/presentation/views/widgets/teacher_bookings_view.dart';
import 'package:el_kottab_teacher_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:el_kottab_teacher_app/features/home/presentation/views/widgets/balance_dialog.dart';
import 'package:el_kottab_teacher_app/features/profile/presentation/views/widgets/profile_list_item.dart';

import '../../../../../main_imports.dart';
import '../../../../change_password/presentation/views/change_password_view.dart';
import '../../../../contact_us/presentation/views/contact_us_view.dart';
import '../../../../settings/presentation/views/settings_view.dart';

class ProfileListItems extends StatelessWidget {
  const ProfileListItems({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: AppColors.darkOlive.withValues(alpha: .2),
      ),
      child: Column(
        children: [
          ProfileListItem(
            title: LangKeys.balance,
            svgImage: SvgImages.dollar,
            onTap: () {
              final stats = context.read<HomeCubit>().teacherStatsModel?.data;

              if (stats != null) {
                showBalanceDialog(
                  context: context,
                  balance: stats.walletMoney ?? 0,
                  minutes: stats.walletMinutes ?? 0,
                  currency: stats.currency ?? 'ج.م',
                );
              }
            },
          ),
          ProfileListItem(
            title: LangKeys.changePassword,
            svgImage: SvgImages.lock,
            onTap: () {
              AppNav.customNavigator(
                context: context,
                screen: ChangePasswordView(screenName: ""),
              );
            },
          ),
          ProfileListItem(
            title: LangKeys.contactUs,
            svgImage: SvgImages.callCalling,
            onTap: () {
              AppNav.customNavigator(context: context, screen: ContactUsView());
            },
          ),
          ProfileListItem(
            title: LangKeys.settings,
            svgImage: SvgImages.settings,
            isLast: false,
            onTap: () {
              AppNav.customNavigator(context: context, screen: SettingsView());
            },
          ),

          ProfileListItem(
            title: "الحجوزات",
            svgImage: SvgImages.chat,

            isLast: true,
            onTap: () {
              AppNav.customNavigator(
                context: context,
                screen: const TeacherBookingsView(),
              );
            },
          ),
        ],
      ),
    );
  }
}
