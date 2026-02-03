import 'package:easy_localization/easy_localization.dart';
import 'package:el_kottab_teacher_app/core/extensions/lang.dart';
import 'package:el_kottab_teacher_app/features/settings/presentation/views/price_policy_view.dart';
import 'package:el_kottab_teacher_app/features/settings/presentation/views/refund_policy_view.dart';
import 'package:el_kottab_teacher_app/features/settings/presentation/views/terms_view.dart';
import 'package:el_kottab_teacher_app/features/settings/presentation/views/who_we_are_view.dart';
import 'package:el_kottab_teacher_app/features/settings/presentation/views/widgets/show_delete_account_dialog.dart';
import '../../../../main_imports.dart';
import '../../../profile/presentation/views/widgets/profile_list_item.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LangKeys.settings.tr())),
      body: Padding(
        padding: EdgeInsets.all(12.0.r),
        child: Column(
          children: [
            Gap(12.h),
            ProfileListItem(
              title: LangKeys.aboutUs,
              svgImage: SvgImages.warning,
              onTap: () {
                AppNav.customNavigator(
                  context: context,
                  screen: WhoWeAreView(),
                );
              },
            ),
            Gap(12.h),
            ProfileListItem(
              title: LangKeys.privacyAndTerms,
              svgImage: SvgImages.terms,
              onTap: () {
                AppNav.customNavigator(context: context, screen: TermsView());
              },
            ),
            Gap(12.h),
            ProfileListItem(
              title: LangKeys.pricePolicy,
              svgImage: SvgImages.title,
              onTap: () {
                AppNav.customNavigator(context: context, screen: PricePolicyView());
              },
            ),
            Gap(12.h),
            ProfileListItem(
              isLast: true,
              title: LangKeys.refundPolicy,
              svgImage: SvgImages.settings,
              onTap: () {
                AppNav.customNavigator(context: context, screen: RefundPolicyView());
              },
            ),
            Gap(24.h),
            InkWell(
              onTap: () {
                showDeleteAccountDialog(context);
              },
              child: Container(
                padding: EdgeInsets.all(12.r),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: AppColors.errorDark,
                  border: Border.all(color: AppColors.errorDark),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(6.r),
                          height: 40.h,
                          width: 40.w,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(SvgImages.logout),
                        ),
                        Gap(8.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              LangKeys.deleteAccount.tr(),
                              style: AppStyles.white16SemiBold,
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        showDeleteAccountDialog(context);
                      },
                      icon: SvgPicture.asset(
                        context.isArabic
                            ? SvgImages.arrowLeft
                            : SvgImages.arrowRight,
                        colorFilter: ColorFilter.mode(
                          AppColors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
