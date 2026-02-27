import '../../../../../main_imports.dart';

class PaymentCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  const PaymentCard({
    super.key,
    required this.title,
    required this.subTitle,
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16.r),
      onTap: onTap,
      child: Container(
        padding:   EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Icon(icon, size: 28.sp),
            Gap(12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style:   TextStyle(fontSize: 16.sp)),
                  Text(subTitle,
                      style:   TextStyle(fontSize: 12.sp)),
                ],
              ),
            ),
            // Text(
            //   isActive ? "مفعل" : "إضافة",
            //   style: TextStyle(
            //     color: isActive ? Colors.green : Colors.blue,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}