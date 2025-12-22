import '../../main_imports.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.height,
    this.width,
    this.btnColor,
    this.btnText,
    this.child,
    required this.onPressed,
    this.borderColor,
    this.radius,
    this.padding,
  }) : assert(btnText != null || child != null, 'يجب توفير btnText أو child');

  final double? height;
  final double? width;
  final Color? btnColor;
  final Color? borderColor;
  final double? radius;
  final String? btnText;
  final Widget? child;
  final void Function()? onPressed;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    Widget buildChild() {
      if (child != null) {
        return child!;
      } else {
        return Text(
          btnText!,
          style: AppStyles.white16SemiBold,
        );
      }
    }

    return SizedBox(
      height: height ?? 54.h,
      width: width ?? double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 8.r),
            side: BorderSide(
              width: 1.0,
              color: borderColor ?? AppColors.darkOlive,
            ),
          ),
          backgroundColor: btnColor ?? AppColors.darkOlive,
          foregroundColor: AppColors.darkOlive,
          padding: padding ??   EdgeInsets.symmetric(horizontal: 16.w),
        ),
        child: buildChild(),
      ),
    );
  }
}