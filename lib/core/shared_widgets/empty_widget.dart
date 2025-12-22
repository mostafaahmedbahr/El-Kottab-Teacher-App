
import '../../main_imports.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key, required this.msg,});
  final String msg;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(SvgImages.empty,height: 100.h,colorFilter: ColorFilter.mode(AppColors.gold, BlendMode.srcIn),)  ,
        Gap(12.h),
        Text(msg,style: AppStyles.primary16SemiBold,),
      ],
    );
  }
}