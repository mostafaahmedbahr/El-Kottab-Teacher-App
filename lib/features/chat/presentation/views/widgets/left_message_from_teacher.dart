import '../../../../../core/helpers/convert_date.dart';
import '../../../../../main_imports.dart';

class LeftMessageFromTeacher extends StatelessWidget {
  const LeftMessageFromTeacher({super.key,  required this.date, required this.message});
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CustomNetWorkImage(
              //   imageUrl: image,
              //   height: 34.h,
              //   width: 34.w,
              //   raduis: 50.r,
              // ),
              // Gap(10.w),
              Expanded(
                child: Container(
                  padding:   EdgeInsets.all(14.r),
                  margin:   EdgeInsets.only(bottom: 6.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4.r,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(message, style: AppStyles.black14Medium),
                ),
              ),
            ],
          ),
          Padding(
            padding:   EdgeInsets.only(left: 50.w),
            child: Text(DateFormatterClass.toTimeAgo(date)),
          ),
        ],
      ),
    );
  }
}