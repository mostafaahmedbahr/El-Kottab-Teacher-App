
import '../../main_imports.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    super.key,
    required this.onTap,
    required this.errorMsg,
  });
  final void Function()? onTap;
  final String errorMsg;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            SvgImages.serverErrorImage,
            colorFilter: const ColorFilter.mode(
              AppColors.gray,
              BlendMode.srcIn,
            ),
          ),
          Gap(10.h),
          InkWell(
            onTap: onTap,
            child: Text(
              errorMsg,
              style: const TextStyle(color: AppColors.black),
            ),
          ),
        ],
      ),
    );
  }
}
