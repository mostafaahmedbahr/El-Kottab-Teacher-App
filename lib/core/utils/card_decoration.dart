// ===== Card Decoration =====
import '../../main_imports.dart';

BoxDecoration cardDecoration() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16.r),
    border: Border.all(color: Colors.grey[300]!),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withValues(alpha: 0.1),
        blurRadius: 8,
        spreadRadius: 2,
      ),
    ],
  );
}