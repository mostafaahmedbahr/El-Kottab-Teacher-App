import 'package:easy_localization/easy_localization.dart';
import 'package:el_kottab_teacher_app/features/register/presentation/view_model/register_states.dart';
import 'package:el_kottab_teacher_app/features/register/presentation/views/widgets/custom_file_picker.dart';
import 'package:el_kottab_teacher_app/features/register/presentation/views/widgets/register_button.dart';
import '../../../../core/utils/enums.dart';
import '../../../../main_imports.dart';
import '../view_model/register_cubit.dart';

class RegisterDocsView extends StatelessWidget {
  RegisterDocsView({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LangKeys.uploadingPersonalIdentification.tr()),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: BlocBuilder<RegisterCubit, RegisterStates>(
          buildWhen: (previous, current) {
            return current is RegisterPickFileState;
          },
          builder: (context, state) {
            final registerCubit = context.read<RegisterCubit>();

            final List<Widget> cards = [
              CustomFilePicker(
                title: LangKeys.personalPhoto,

                imagePath: registerCubit.personalPhotoPath,
                placeholderAsset: SvgImages.camera2,
                onTap: () => registerCubit.pickRegisterFile(
                  RegisterFileType.personalPhoto,
                ),
              ),
              CustomFilePicker(
                title: LangKeys.cv,

                filePath: registerCubit.cvPath,
                placeholderAsset: SvgImages.cv,
                onTap: () =>
                    registerCubit.pickRegisterFile(RegisterFileType.cv),
              ),
              CustomFilePicker(
                title: LangKeys.personalIDCardFront,
                imagePath: registerCubit.idFrontPath,
                placeholderAsset: SvgImages.id,
                onTap: () =>
                    registerCubit.pickRegisterFile(RegisterFileType.idFront),
              ),
              CustomFilePicker(
                title: LangKeys.personalIDCardBack,
                imagePath: registerCubit.idBackPath,
                placeholderAsset: SvgImages.id,
                onTap: () =>
                    registerCubit.pickRegisterFile(RegisterFileType.idBack),
              ),

              CustomFilePicker(
                title: LangKeys.qualifications,
                filePath: registerCubit.qualificationPath,
                placeholderAsset: SvgImages.qualifications,
                onTap: () => registerCubit.pickRegisterFile(
                  RegisterFileType.qualification,
                ),
              ),

              CustomFilePicker(
                title: LangKeys.degreePath,
                filePath: registerCubit.degree,
                placeholderAsset: SvgImages.degree,
                onTap: () =>
                    registerCubit.pickRegisterFile(RegisterFileType.degreePath),
              ),
            ];

            return Form(
              key: _formKey,
              child: Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      itemCount: cards.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.w,
                        mainAxisSpacing: 10.h,
                        childAspectRatio: 0.65,
                      ),
                      itemBuilder: (context, index) {
                        return cards[index];
                      },
                    ),
                  ),

                  RegisterButton(formKey: _formKey),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
