import 'package:easy_localization/easy_localization.dart';
import 'package:el_kottab_teacher_app/core/extensions/lang.dart';
import 'package:el_kottab_teacher_app/main_imports.dart';

import 'call_item.dart';

class SuccessfulCalls extends StatelessWidget {
  final List<CallItemModel> calls = [
    CallItemModel(
      name: 'أحمد محمد',
      imageUrl: 'https://via.placeholder.com/150',
      time: '15 دقيقة',
      date: 'اليوم',
    ),
    CallItemModel(
      name: 'سارة علي',
      imageUrl: 'https://via.placeholder.com/150',
      time: '30 دقيقة',
      date: 'أمس',
    ),
    CallItemModel(
      name: 'محمد خالد',
      imageUrl: 'https://via.placeholder.com/150',
      time: '45 دقيقة',
      date: 'قبل يومين',
    ),
    CallItemModel(
      name: 'فاطمة حسن',
      imageUrl: 'https://via.placeholder.com/150',
      time: '20 دقيقة',
      date: 'الأسبوع الماضي',
    ),
    CallItemModel(
      name: 'عمر يوسف',
      imageUrl: 'https://via.placeholder.com/150',
      time: '60 دقيقة',
      date: 'منذ أسبوعين',
    ),
  ];

    SuccessfulCalls({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LangKeys.successfulCalls.tr(),
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        LangKeys.viewAll.tr(),
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.darkOlive,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Gap(8.w),
                      SvgPicture.asset(context.isArabic ? SvgImages.arrowLeft :SvgImages.arrowRight )
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            height: 130.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: calls.length,
              separatorBuilder: (context, index) => SizedBox(width: 12.w),
              itemBuilder: (context, index) {
                return  CallItem(call: calls[index]);
              },
            ),
          ),
        ],
      ),
    );
  }


}

// Model class for call items
class CallItemModel {
  final String name;
  final String imageUrl;
  final String time;
  final String date;

  CallItemModel({
    required this.name,
    required this.imageUrl,
    required this.time,
    required this.date,
  });
}