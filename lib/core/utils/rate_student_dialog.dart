   import 'package:el_kottab_teacher_app/features/layout/presentation/view_model/layout_cubit.dart';
import 'package:el_kottab_teacher_app/features/layout/presentation/view_model/layout_states.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../main_imports.dart';

class RateStudentDialog extends StatefulWidget {
  final String studentName;
  final String studentId;
  final Function(double rating, String message) onSubmit;

  const RateStudentDialog({
    super.key,
    required this.studentName,
    required this.onSubmit,
    required this.studentId,
  });

  @override
  State<RateStudentDialog> createState() => _RateStudentDialogState();
}

class _RateStudentDialogState extends State<RateStudentDialog> {
  double rating = 0;
  final TextEditingController controller = TextEditingController();
  bool isLoading = false; // <-- الحالة الجديدة للتحميل

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: BlocListener<LayoutCubit, LayoutStates>(
        listener: (context, state) {
          if (state is RateStudentSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppColors.success,
                content: Text("⭐${state.rateStudentModel.message.toString()}"),
              ),
            );
            setState(() => isLoading = false); // ✅ أوقف اللودر
            Navigator.pop(context);            // ✅ اقفل الدialog

          }

          if (state is RateStudentErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppColors.errorDark,
                content: Text("⭐${state.error.toString()}"),
              ),
            );
            setState(() => isLoading = false); // أوقف التحميل عند الخطأ
          }
        },
        child: Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "قيّم ${widget.studentName}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 35,
                  itemBuilder: (context, _) =>
                      const Icon(Icons.star, color: Colors.amber),
                  onRatingUpdate: (value) {
                    setState(() {
                      rating = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: controller,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: "اكتب رأيك عن الطالب...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity, // الزر يأخذ العرض بالكامل
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: isLoading || rating == 0
                        ? null
                        : () {
                      setState(() => isLoading = true);
                      // نكتفي باستدعاء الـ onSubmit، والـ Listener سيقوم بالباقي
                      widget.onSubmit(
                        rating,
                        controller.text.trim(),
                      );
                    },
                    child: isLoading
                        ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                        : const Text(
                      "إرسال التقييم",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
