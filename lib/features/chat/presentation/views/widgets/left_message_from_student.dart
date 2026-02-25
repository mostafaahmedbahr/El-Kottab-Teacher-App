import '../../../../../core/helpers/convert_date.dart';
import '../../../../../main_imports.dart';

class LeftMessageFromStudent extends StatelessWidget {
  const LeftMessageFromStudent({super.key,   required this.date, required this.message});

  final String date;
  final String message;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding : EdgeInsets.only(bottom: 6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding:   EdgeInsets.all(14.r),
                margin:   EdgeInsets.only(bottom: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4.r,
                      offset: Offset(0, 2),
                    )
                  ],
                ),
                child: Text(
                  message,
                  style: AppStyles.black12SemiBold,
                ),
              ),
            ],
          ),
          Padding(
            padding:   EdgeInsets.only(right: 50.w),
            child: Text(DateFormatterClass.toTimeAgo(date)),
          ),
        ],
      ),
    );
  }
}