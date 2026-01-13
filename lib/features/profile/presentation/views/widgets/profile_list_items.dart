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
            onTap: (){

            },
          ),
          ProfileListItem(
            title: LangKeys.changePassword,
            svgImage: SvgImages.lock,
            onTap: (){
              AppNav.customNavigator(context: context, screen: ChangePasswordView(screenName: "",));
            },
          ),
          ProfileListItem(
            title: LangKeys.contactUs,
            svgImage: SvgImages.callCalling,
            onTap: (){
              AppNav.customNavigator(context: context, screen: ContactUsView());
            },
          ),
          ProfileListItem(
            title: LangKeys.settings,
            svgImage: SvgImages.settings,
            isLast: true,
            onTap: (){
              AppNav.customNavigator(context: context, screen: SettingsView());
            },
          ),



        ],
      ),
    );
  }
}