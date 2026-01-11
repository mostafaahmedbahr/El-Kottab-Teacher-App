import 'package:easy_localization/easy_localization.dart';
import 'package:el_kottab_teacher_app/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:el_kottab_teacher_app/features/profile/presentation/view_model/profile_states.dart';
import 'package:el_kottab_teacher_app/features/profile/presentation/views/widgets/profile_image.dart';

import '../../../../../main_imports.dart';

class ProfileInfoData extends StatelessWidget {
  const ProfileInfoData({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileStates>(
      builder: (context, state) {
        var profileCubit = context.read<ProfileCubit>();
        return Container(
          padding: EdgeInsets.all(12.r),
          height: 135.h,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: AppColors.darkOlive.withValues(alpha: .2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  ProfileImage(
                    imageUrl: profileCubit.profileModel?.data?.image ?? "",
                  ),
                  Gap(20.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profileCubit.profileModel?.data?.name ?? "",
                        style: AppStyles.black16SemiBold,
                      ),
                      Gap(8.h),
                      // Row(
                      //   children: [
                      //     SvgPicture.asset(
                      //       SvgImages.star,
                      //       colorFilter: ColorFilter.mode(
                      //         AppColors.warningDark,
                      //         BlendMode.srcIn,
                      //       ),
                      //     ),
                      //     Gap(4.w),
                      //     Text("4.6"),
                      //   ],
                      // ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      //     AppNav.customNavigator(context: context, screen: EditProfileInfoView());
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(SvgImages.edit),
                        Gap(8.w),
                        Text(
                          LangKeys.editProfile.tr(),
                          style: AppStyles.primary16SemiBold,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
