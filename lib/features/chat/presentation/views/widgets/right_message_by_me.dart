import '../../../../../core/helpers/convert_date.dart';
import '../../../../../main_imports.dart';

class RightMessageByMe extends StatelessWidget {
  const RightMessageByMe({super.key,   required this.date, required this.message});

  final String date;
  final String message;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding : EdgeInsets.only(bottom: 6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:   EdgeInsets.all(14.r),
                margin:   EdgeInsets.only(bottom: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.darkOlive,
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
                  style: AppStyles.white12SemiBold,
                ),
              ),
              // Gap(10.w),
              // CustomNetWorkImage(
              //   imageUrl:  image,
              //   height: 34.h,
              //   width: 34.w,
              //   raduis: 50.r,
              // ),
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