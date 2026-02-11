import 'package:el_kottab_teacher_app/features/add_appointments/data/models/booking_model.dart';
import 'package:el_kottab_teacher_app/main_imports.dart';

class BookingCard extends StatelessWidget {
  final BookingModel booking;
  final bool isFinished;

  const BookingCard({
    super.key,
    required this.booking,
    required this.isFinished,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: .05), blurRadius: 6),
        ],
      ),
      child: Row(
        children: [
          /// صورة الطالب
          CircleAvatar(
            radius: 28.r,
            backgroundImage: NetworkImage(booking.studentImage),
          ),

          SizedBox(width: 12.w),

          /// الاسم + المعاد
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  booking.studentName,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  _formatDate(booking.dateTime),
                  style: TextStyle(fontSize: 13.sp, color: Colors.grey),
                ),
              ],
            ),
          ),

          /// زرار الغاء (بس في القادمة)
          if (!isFinished)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.errorDark,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              onPressed: () {},
              child: const Text("إلغاء", style: TextStyle(color: Colors.white)),
            ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year} - ${date.hour}:${date.minute}";
  }
}
