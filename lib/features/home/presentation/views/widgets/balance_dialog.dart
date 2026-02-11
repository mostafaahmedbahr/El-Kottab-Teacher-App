import 'package:easy_localization/easy_localization.dart';
import 'package:el_kottab_teacher_app/main_imports.dart';
import 'balance_content.dart';
import 'dart:ui';

void showBalanceDialog({
  required BuildContext context,
  required num balance,
  required int minutes,
  required String currency,
}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Balance",
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, anim1, anim2) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            padding: EdgeInsets.all(20.r),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 12,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 🔹 Icon
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.darkOlive.withOpacity(0.1),
                  ),
                  padding: EdgeInsets.all(12.r),
                  child: Icon(
                    Icons.account_balance_wallet_rounded,
                    size: 28.sp,
                    color: AppColors.darkOlive,
                  ),
                ),
                Gap(12.h),

                // 🔹 Title
                Text(
                  LangKeys.balance.tr(),
                  style: AppStyles.black20Bold.copyWith(
                    decoration: TextDecoration.none,
                    color: AppColors.darkOlive,
                  ),
                ),

                Gap(12.h),

                // 🔹 Balance Content
                BalanceContent(
                  balance: balance,
                  minutes: minutes,
                  currency: currency,
                  compact: false,
                ),
                Gap(20.h),

                // 🔹 Close Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkOlive,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    child: Text(
                      LangKeys.close.tr(),
                      style: AppStyles.white16SemiBold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return FadeTransition(
        opacity: CurvedAnimation(parent: anim1, curve: Curves.easeOut),
        child: ScaleTransition(
          scale: CurvedAnimation(parent: anim1, curve: Curves.easeOutBack),
          child: child,
        ),
      );
    },
  );
}
