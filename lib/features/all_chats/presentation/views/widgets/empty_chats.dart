import '../../../../../main_imports.dart';

class EmptyChats extends StatelessWidget {
  const EmptyChats({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 64.sp,
            color: Colors.grey[400],
          ),
          Gap(16.h),
          Text(
            'لا توجد محادثات حالياً',
            style: TextStyle(fontSize: 16.sp, color: Colors.grey[600]),
          ),
       Gap(8.h),

          Text(
            'ابدأ محادثة جديدة للتواصل مع المعلمين',
            style: TextStyle(fontSize: 14.sp, color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
