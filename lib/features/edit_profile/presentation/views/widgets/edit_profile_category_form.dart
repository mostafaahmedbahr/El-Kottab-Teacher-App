import 'package:easy_localization/easy_localization.dart';

import '../../../../../main_imports.dart';
import '../../../../profile/presentation/view_model/profile_cubit.dart';
import '../../../../register/data/models/categories_model.dart';
import '../../../../register/presentation/view_model/register_cubit.dart';
import '../../../../register/presentation/view_model/register_states.dart';
import '../../view_model/edit_profile_info_cubit.dart';

class EditProfileCategoryForm extends StatefulWidget {
  const EditProfileCategoryForm({super.key});

  @override
  State<EditProfileCategoryForm> createState() =>
      _EditProfileCategoryFormState();
}

class _EditProfileCategoryFormState
    extends State<EditProfileCategoryForm> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final registerCubit = context.read<RegisterCubit>();
      registerCubit.getAllCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final registerCubit = context.read<RegisterCubit>();
        final editPersonalInfoCubit = EditProfileInfoCubit.get(context);
        final profile = context.read<ProfileCubit>().profileModel;

        return Column(
          children: [
            Gap(20.h),

            /// Category Autocomplete
            state is GetAllCategoriesLoadingState
                ? const Center(child: CustomLoading())
                : state is GetAllCategoriesErrorState
                ? Center(
              child: Text(
                state.error.toString(),
                style: TextStyle(color: AppColors.errorDark),
              ),
            )
                : Autocomplete<CategoryData>(
              displayStringForOption: (CategoryData option) =>
              option.name ?? '',
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text.isEmpty) {
                  return registerCubit.categoriesModel?.data ??
                      const Iterable<CategoryData>.empty();
                }
                return registerCubit.categoriesModel?.data
                    ?.where((CategoryData option) {
                  return option.name!
                      .toLowerCase()
                      .contains(
                      textEditingValue.text.toLowerCase());
                }) ??
                    const Iterable<CategoryData>.empty();
              },
              onSelected: (CategoryData selection) {
                // تحديث قيمة الـ controller
                editPersonalInfoCubit.categoryController.text =
                    selection.name ?? '';

                // حفظ الـ category id في الكيوبت
                // editPersonalInfoCubit.selectedCategoryId = selection.id;

                // تحديث الواجهة
                setState(() {});

                // إضافة أي منطق إضافي هنا إذا لزم
                print('Selected category: ${selection.name}, ID: ${selection.id}');
              },
              fieldViewBuilder: (context, textEditingController,
                  focusNode, onFieldSubmitted) {
                // ✅ تهيئة بقيمة الملف الشخصي إذا كانت موجودة
                // if (textEditingController.text.isEmpty &&
                //     profile?.data?.plan?.categories != null &&
                //     profile!.data!.plan!.categories!.isNotEmpty) {
                //   WidgetsBinding.instance.addPostFrameCallback((_) {
                //     // أخذ أول category id من المصفوفة
                //     int? firstCategoryId = profile!.data!.plan!.categories![0].id;
                //     if (firstCategoryId != null) {
                //       textEditingController.text = firstCategoryId.toString();
                //
                //       // أيضاً تهيئة الـ ID
                //       // editPersonalInfoCubit. = firstCategoryId;
                //     }
                //   });
                // }

                return CustomTextFormField(
                  controller: textEditingController,
                  focusNode: focusNode,
                  hintText: LangKeys.educationalPath.tr(),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SvgPicture.asset(SvgImages.home,colorFilter: ColorFilter.mode(AppColors.gray, BlendMode.srcIn),), // تأكد من وجود أيقونة مناسبة
                  ),
                  onChanged: (value) {
                    editPersonalInfoCubit.categoryController.text = value;

                    // إذا تم مسح الحقل، امسح الـ ID أيضاً
                    // if (value.isEmpty) {
                    //   editPersonalInfoCubit.selectedCategoryId = null;
                    // }
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }
}