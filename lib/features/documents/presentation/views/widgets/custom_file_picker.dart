
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:el_kottab_teacher_app/main_imports.dart';

class CustomFilePicker extends StatelessWidget {
  final String title;
  final String? imagePath;
  final String? filePath;
  final VoidCallback onTap;
  final String placeholderAsset;

  const CustomFilePicker({
    super.key,
    required this.title,
    this.imagePath,
    this.filePath,
    required this.onTap,
    required this.placeholderAsset,
  });

  @override
  Widget build(BuildContext context) {
    Widget leftWidget;

    if (imagePath != null) {
      leftWidget = ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.file(
          File(imagePath!),
          width: 70.w,
          height: 70.h,
          fit: BoxFit.cover,
        ),
      );
    } else {
      leftWidget = Image.asset(
        placeholderAsset,
        width: 70.w,
        height: 70.h,
        fit: BoxFit.cover,
      );
    }

    return Card(
      color: AppColors.cream,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.darkOlive),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 18),
        child: Row(
          children: [
            leftWidget,
            Gap(8.w),
            Expanded(
              child: Text(
                title.tr(),
                style: AppStyles.primary16SemiBold,
              ),
            ),
            ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.darkOlive,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Icon(Icons.upload_file, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
