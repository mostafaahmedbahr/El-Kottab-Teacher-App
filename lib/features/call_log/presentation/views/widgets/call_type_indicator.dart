import '../../../../../main_imports.dart';

class CallTypeIndicator extends StatelessWidget {
  const CallTypeIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.darkOlive.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
         'وارد',
        style: TextStyle(
          fontSize: 11.sp,
          color:AppColors.darkOlive.withValues(alpha: 0.1),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
