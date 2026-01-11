
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:el_kottab_teacher_app/main_imports.dart';
import 'package:el_kottab_teacher_app/core/themes/app_colors.dart';

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
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF4A5330),
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                ),
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
