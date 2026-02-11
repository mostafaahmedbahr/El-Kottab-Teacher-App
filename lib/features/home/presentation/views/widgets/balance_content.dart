import 'package:easy_localization/easy_localization.dart';
import 'package:el_kottab_teacher_app/main_imports.dart';

class BalanceContent extends StatelessWidget {
  final num balance;
  final int minutes;
  final String currency;
  final bool compact;

  const BalanceContent({
    super.key,
    required this.balance,
    required this.minutes,
    required this.currency,
    this.compact = true, // true = home | false = dialog
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // 🔹 Row with Icon + "الرصيد"
        Row(
          children: [
            Icon(
              Icons.account_balance_wallet_rounded,
              color: Colors.black,
              size: compact ? 20.sp : 24.sp,
            ),
            Gap(8.w),
            Text(
              LangKeys.balance.tr(),
              style: TextStyle(
                fontSize: compact ? 14.sp : 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                decoration: TextDecoration.none,
              ),
            ),
          ],
        ),
        Gap(12.h),

        // 🔹 Balance number
        Text(
          '$balance $currency',
          style: TextStyle(
            fontSize: compact ? 24.sp : 32.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            decoration: TextDecoration.none,
          ),
        ),
        Gap(6.h),

        // 🔹 Minutes remaining
        Row(
          children: [
            Icon(
              Icons.access_time_rounded,
              size: 16.sp,
              color: Colors.grey[600],
            ),
            Gap(4.w),
            Text(
              '$minutes ${LangKeys.minuteRemaining.tr()}',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey[600],
                decoration: TextDecoration.none,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
