import 'package:el_kottab_teacher_app/features/settings/presentation/views/widgets/payment_methods_view_body.dart';
import 'package:el_kottab_teacher_app/features/settings/presentation/views/widgets/show_payment_bottom_sheet.dart';

import '../../../../main_imports.dart';

class PaymentMethodsView extends StatelessWidget {
  const PaymentMethodsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("وسيلة استلام الأرباح")),
      body: PaymentMethodsViewBody(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.darkOlive,
        onPressed: () => showPaymentBottomSheet(context),
        child: const Icon(Icons.add,color: AppColors.white,),
      ),
    );
  }
}