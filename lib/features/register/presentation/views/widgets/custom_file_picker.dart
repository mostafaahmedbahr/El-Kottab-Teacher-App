import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:el_kottab_teacher_app/main_imports.dart';

class CustomFilePicker extends StatelessWidget {
  final String title;
  final String? imagePath;
  final String? filePath;
  final String? fileName;
  final VoidCallback onTap;
  final String placeholderAsset;

  const CustomFilePicker({
    super.key,
    required this.title,
    this.imagePath,
    this.filePath,
    this.fileName,
    required this.onTap,
    required this.placeholderAsset,
  });

  bool get hasImage => imagePath != null;
  bool get hasFile => imagePath != null || filePath != null || fileName != null;

  String get displayName {
    if (imagePath != null) {
      return _fileName(imagePath!);
    }
    if (fileName != null) return fileName!;
    if (filePath != null) return _fileName(filePath!);
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260.h,
      child: Card(
        color: AppColors.cream,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppColors.darkOlive),
        ),
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Column(
            children: [
              /// 🔹 Preview Area (ثابت)
              SizedBox(
                height: 90.h,
                child: Center(
                  child: hasImage
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            File(imagePath!),
                            fit: BoxFit.cover,
                            width: 90.w,
                            height: 90.h,
                          ),
                        )
                      : SvgPicture.asset(
                          placeholderAsset,
                          width: 50.w,
                          height: 50.h,
                        ),
                ),
              ),

              Gap(8.h),

              /// 🔹 Title (سطرين ثابتين)
              SizedBox(
                height: 45.h,
                child: Text(
                  title.tr(),
                  style: AppStyles.primary16SemiBold,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              /// 🔹 File name (Expandable)
              Expanded(
                child: hasFile
                    ? Center(
                        child: Text(
                          displayName,
                          style: AppStyles.primary14Medium,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    : const SizedBox(),
              ),

              /// 🔹 Button (Pinned)
              SizedBox(
                width: double.infinity,
                height: 40.h,
                child: ElevatedButton.icon(
                  onPressed: onTap,
                  icon: const Icon(Icons.upload_file, color: Colors.white),
                  label: Text(
                    LangKeys.upload.tr(),
                    style: AppStyles.white12SemiBold,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.darkOlive,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _fileName(String path) => path.split(Platform.pathSeparator).last;
}
