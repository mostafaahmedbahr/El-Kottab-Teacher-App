
import 'package:el_kottab_teacher_app/features/settings/presentation/views/widgets/payment_bottom_sheet_content.dart';

import '../../../../../main_imports.dart';

void showPaymentBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.white,
    shape:   RoundedRectangleBorder(

      borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
    ),
    builder: (_) {
      return const PaymentBottomSheetContent();
    },
  );
}