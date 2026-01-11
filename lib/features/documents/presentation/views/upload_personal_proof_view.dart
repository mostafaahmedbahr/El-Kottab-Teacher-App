
import 'package:el_kottab_teacher_app/features/documents/presentation/views/widgets/custom_file_picker.dart';
import 'package:el_kottab_teacher_app/main_imports.dart';
import '../view_model/upload_documents_cubit.dart';
import '../view_model/upload_documents_state.dart';

class UploadPersonalProofView extends StatelessWidget {
  const UploadPersonalProofView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UploadDocumentsCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'رفع الإثبات الشخصي',
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.darkOlive,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.w),
          child: BlocBuilder<UploadDocumentsCubit, UploadDocumentsState>(
            builder: (context, state) {
              final cubit = context.read<UploadDocumentsCubit>();
              final model = state.model;

              return Column(
                children: [
                  CustomFilePicker(
                    title: 'الصورة الشخصية',
                    imagePath: model.personalPhotoPath,
                    placeholderAsset: PngImages.presonalphoto,
                    onTap: cubit.pickPersonalPhoto,
                  ),
                  SizedBox(height: 10.h),
                  CustomFilePicker(
                    title: 'السيرة الذاتية',
                    filePath: model.cvPath,
                    placeholderAsset: PngImages.cv,
                    onTap: cubit.pickCV,
                  ),
                  SizedBox(height: 10.h),
                  CustomFilePicker(
                    title: 'البطاقة الشخصية (امام)',
                    imagePath: model.idFrontPath,
                    placeholderAsset: PngImages.id,
                    onTap: cubit.pickIdFront,
                  ),
                  SizedBox(height: 10.h),
                  CustomFilePicker(
                    title: 'البطاقة الشخصية (خلف)',
                    imagePath: model.idBackPath,
                    placeholderAsset: PngImages.id,
                    onTap: cubit.pickIdBack,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
