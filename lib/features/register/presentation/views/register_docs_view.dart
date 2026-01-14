import 'package:easy_localization/easy_localization.dart';
import 'package:el_kottab_teacher_app/features/register/presentation/view_model/register_states.dart';
import 'package:el_kottab_teacher_app/features/register/presentation/views/widgets/custom_file_picker.dart';
import 'package:el_kottab_teacher_app/features/register/presentation/views/widgets/register_button.dart';
import '../../../../core/utils/enums.dart';
import '../../../../main_imports.dart';
 import '../view_model/register_cubit.dart';

class RegisterDocsView extends StatelessWidget {
    RegisterDocsView({super.key, });
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LangKeys.uploadingPersonalIdentification.tr(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: BlocBuilder<RegisterCubit, RegisterStates>(
          buildWhen: (previous, current){
            return current is RegisterPickFileState;
          },
          builder: (context, state) {
            final registerCubit = context.read<RegisterCubit>();
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomFilePicker(
                    title: LangKeys.personalPhoto,
                    imagePath: registerCubit.personalPhotoPath,
                    placeholderAsset: PngImages.presonalphoto,
                    onTap: () => registerCubit.pickRegisterFile(
                      RegisterFileType.personalPhoto,
                    ),
                  ),
                  Gap(10.h),
                  CustomFilePicker(
                    title: LangKeys.cv,
                    fileName: registerCubit.cvPath,
                    filePath: registerCubit.cvPath,
                    placeholderAsset: PngImages.cv,
                    onTap: () => registerCubit.pickRegisterFile(
                      RegisterFileType.cv,
                    ),
                  ),
                  Gap(10.h),
                  CustomFilePicker(
                    title: LangKeys.personalIDCardFront,
                    imagePath: registerCubit.idFrontPath,
                    placeholderAsset: PngImages.id,
                    onTap: () => registerCubit.pickRegisterFile(
                      RegisterFileType.idFront,
                    ),
                  ),

                  Gap(10.h),
                  CustomFilePicker(
                    title: LangKeys.personalIDCardBack,
                    imagePath: registerCubit.idBackPath,
                    placeholderAsset: PngImages.id,
                    onTap: () => registerCubit.pickRegisterFile(
                      RegisterFileType.idBack,
                    ),
                  ),
                  Gap(24.h),
                  RegisterButton(formKey: _formKey,),

                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
