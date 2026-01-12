import 'package:easy_localization/easy_localization.dart';
import '../../../../../main_imports.dart';
import '../../../../layout/presentation/views/layout_view.dart';
import '../../../../profile/presentation/view_model/profile_cubit.dart';
import '../../view_model/edit_profile_info_cubit.dart';
import '../../view_model/edit_profile_info_states.dart';

class EditProfileButton extends StatelessWidget {
  const EditProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditProfileInfoCubit, EditProfileInfoStates>(
      buildWhen: (previous, current) {
        return current is EditProfileInfoLoadingState ||
            current is EditProfileInfoErrorState ||
            current is EditProfileInfoSuccessState;
      },
      listener: (context, state) {
        if (state is EditProfileInfoErrorState) {
          Toast.showErrorToast(
              msg: state.error.toString(),
              context: context
          );
        }
        if (state is EditProfileInfoSuccessState) {
          // تحديث بيانات الملف الشخصي
          context.read<ProfileCubit>().getProfileData();

          // العودة للشاشة الرئيسية
          AppNav.customNavigator(
            context: context,
            screen: const LayoutView(),
            finish: true,
          );

          // عرض رسالة النجاح
          Toast.showSuccessToast(
            msg: state.editProfileInfoModel.message?.toString() ?? "تم التعديل بنجاح",
            context: context,
          );
        }
      },
      builder: (context, state) {
        final editProfileInfoCubit = context.read<EditProfileInfoCubit>();
        final isLoading = state is EditProfileInfoLoadingState;

        return isLoading
            ? const Center(child: CustomLoading())
            : CustomButton(
          btnText: LangKeys.save.tr(),
          onPressed: () {
            // جمع رقم الهاتف الكامل (مع رمز الدولة)
            String fullPhoneNumber = '';
            if (editProfileInfoCubit.phoneCon.text.isNotEmpty) {
              // إذا كان رقم الهاتف يبدأ بـ 0، أضف رمز الدولة
              if (editProfileInfoCubit.phoneCon.text.startsWith('0')) {
                fullPhoneNumber = '+20${editProfileInfoCubit.phoneCon.text}';
              } else {
                fullPhoneNumber = editProfileInfoCubit.phoneCon.text;
              }
            }

            // استدعاء دالة التعديل
          // Uncomment and update the editProfileInfoData call in the onPressed callback
editProfileInfoCubit.editProfileInfoData(
  name: editProfileInfoCubit.nameCon.text.isNotEmpty
      ? editProfileInfoCubit.nameCon.text
      : null,
  email: editProfileInfoCubit.emailCon.text.isNotEmpty
      ? editProfileInfoCubit.emailCon.text
      : null,
  phoneNumber: fullPhoneNumber.isNotEmpty
      ? fullPhoneNumber
      : null,
  gender: editProfileInfoCubit.gender,
  image: editProfileInfoCubit.profileImage,
  description: editProfileInfoCubit.descriptionCon.text.isNotEmpty
      ? editProfileInfoCubit.descriptionCon.text
      : null,
  // categoryId: editProfileInfoCubit.categoryController.text.isNotEmpty
  //     ? editProfileInfoCubit.categoryController.text
  //     : null,
);
          },
        );
      },
    );
  }
}