import 'package:easy_localization/easy_localization.dart';

import '../../../../../main_imports.dart';
import '../../../../profile/presentation/view_model/profile_cubit.dart';
import '../../../../profile/presentation/view_model/profile_states.dart';
import '../../view_model/edit_profile_info_cubit.dart';
import '../../view_model/edit_profile_info_states.dart';


class EditProfileImage extends StatelessWidget {
  const EditProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder< ProfileCubit, ProfileStates>(
      buildWhen: (previous, current){
        return current is EditProfileImageSuccessState || current is EditProfileImageLoadingState || current is EditProfileImageErrorState;
      },
      builder: (context, state) {
        return BlocConsumer<EditProfileInfoCubit, EditProfileInfoStates>(
          listener: (context,state){
            if(state is EditProfileImageSuccessState){
              Toast.showSuccessToast(msg: state.editProfileInfoModel.message.toString(),
                  context: context);
              context.read<ProfileCubit>().getProfileData();
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            var editProfileInfoCubit = EditProfileInfoCubit.get(context);
            String? imageUrl = context.read<ProfileCubit>()
                .profileModel?.data?.image;

            return Row(
              children: [
                GestureDetector(
                  onTap: editProfileInfoCubit.uploadProfilePicture,
                  child: Container(
                    height: 84,
                    width: 84,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.white,
                      image: editProfileInfoCubit.profileImage != null
                          ? DecorationImage(
                        image: FileImage(editProfileInfoCubit.profileImage!),
                        fit: BoxFit.cover,
                      )
                          : null,
                    ),
                    child: editProfileInfoCubit.profileImage != null
                        ? null
                        : imageUrl != null && imageUrl.isNotEmpty
                        ? ClipOval(
                      child: CustomNetWorkImage(
                        fit: BoxFit.cover,
                        height: 84,
                        width: 84,
                        imageUrl: imageUrl,
                        raduis: 50,
                      ),
                    )
                        : Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SvgPicture.asset(SvgImages.camera),
                    ),
                  ),
                ),
                Gap(20.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(LangKeys.profilePhoto.tr(),
                      style: AppStyles.black16SemiBold,
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: editProfileInfoCubit.uploadProfilePicture,
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.darkOlive,
                          ),
                          child:  Text(
                            LangKeys.change.tr(),
                            style: AppStyles.black14Medium,
                          ),
                        ),
                        if (editProfileInfoCubit.profileImage != null)
                          TextButton(
                            onPressed: editProfileInfoCubit.clearProfileImage,
                            style: TextButton.styleFrom(
                              foregroundColor: AppColors.darkOlive,
                            ),
                            child:  Text(
                              LangKeys.delete.tr(),
                              style: AppStyles.black14Medium.copyWith(
                                color: AppColors.errorDark,
                              ),
                            ),
                          ),
                        if (editProfileInfoCubit.profileImage != null)
                          ConditionalBuilder(
                            condition: state is ! EditProfileImageLoadingState,
                            fallback: (context)=>CustomLoading(color: AppColors.darkOlive,size: 25,),
                           builder: (context){
                              return TextButton(
                                onPressed: (){
                                 // editProfileInfoCubit.editProfileImage(image: editProfileInfoCubit.profileImage);
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: AppColors.darkOlive,
                                ),
                                child: Text(
                                  LangKeys.save.tr(),
                                  style: AppStyles.black14Medium.copyWith(
                                    color: AppColors.darkOlive,
                                  ),
                                ),
                              );
                           },
                          ),
                      ],
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }
}
