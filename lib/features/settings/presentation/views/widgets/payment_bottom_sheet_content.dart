import '../../../../../core/utils/enums.dart';
import '../../../../../main_imports.dart';
import '../../view_model/settings_cubit.dart';
import '../../view_model/settings_states.dart';

class PaymentBottomSheetContent extends StatefulWidget {
  const PaymentBottomSheetContent({super.key});

  @override
  State<PaymentBottomSheetContent> createState() =>
      PaymentBottomSheetContentState();
}

class PaymentBottomSheetContentState
    extends State<PaymentBottomSheetContent> {

  PaymentType selected = PaymentType.none;

  final bankName = TextEditingController();
  final accountNumber = TextEditingController();
  final receiverName = TextEditingController();
  final phoneNumber = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16.w,
        right: 16.w,
        top: 20.h,
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              /// 🔹 اختيار الوسيلة
              Row(
                children: [
                  _typeButton(
                    title: "حساب بنكي",
                    icon: Icons.account_balance,
                    type: PaymentType.bank,
                  ),
                  const SizedBox(width: 12),
                  _typeButton(
                    title: "محفظة",
                    icon: Icons.phone_android,
                    type: PaymentType.wallet,
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// 🔹 الفورم يظهر حسب الاختيار
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _buildForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// زرار الاختيار
  Widget _typeButton({
    required String title,
    required IconData icon,
    required PaymentType type,
  }) {
    final isSelected = selected == type;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selected = type),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: EdgeInsets.all(isSelected ? 10.r : 20.r),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.darkOlive : AppColors.grayLightest,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            children: [
              Icon(icon,
                  size: isSelected ? 20.sp : 32.sp,
                  color: isSelected ? Colors.white : Colors.black),
              Gap(6.h),
              Text(
                title,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// الفورم
  Widget _buildForm() {
    if (selected == PaymentType.none) return const SizedBox();

    return BlocConsumer<SettingsCubit, SettingsStates>(
      listener: (context, state) {
        if (state is AddPaymentMethodSuccessState) {
          Toast.showSuccessToast(msg: state.addPaymentMethodModel.message.toString(), context: context);
          Navigator.pop(context);
          context.read<SettingsCubit>().getPaymentMethods();
        }

        if (state is AddPaymentMethodErrorState) {
          Toast.showSuccessToast(msg: state.error.toString(), context: context);
        }
      },
      builder: (context, state) {
        final cubit = context.read<SettingsCubit>();

        return Form(
          key: formKey,
          child: Column(
            key: ValueKey(selected),
            children: [

              /// 🔹 الحقول
              if (selected == PaymentType.bank) ...[
                _field(bankName, "اسم البنك"),
                _field(accountNumber, "رقم الحساب"),
                _field(receiverName, "اسم المستلم"),
              ],

              if (selected == PaymentType.wallet)
                _field(phoneNumber, "رقم الموبايل"),

              Gap(16.h),

              /// 🔹 زر الحفظ
              state is AddPaymentMethodLoadingState
                  ? const CustomLoading()
                  : CustomButton(
                btnText: "حفظ",
                onPressed: () {
                  _submit(cubit);
                },
              ),

              Gap(20.h),
            ],
          ),
        );
      },
    );
  }

  Widget _field(TextEditingController c, String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: CustomTextFormField(
        controller: c,
        validator: (v) => v!.isEmpty ? "مطلوب" : null,
        hintText: hint,
      ),
    );
  }

  void _submit(SettingsCubit cubit) {
    if (!formKey.currentState!.validate()) return;

    if (selected == PaymentType.bank) {
      cubit.addPaymentMethod(
        "bank_account",
        null,
        bankName.text,
        accountNumber.text,
        receiverName.text,
        "1",
      );
    } else if (selected == PaymentType.wallet) {
      cubit.addPaymentMethod(
        "mobile_wallet",
        phoneNumber.text,
        null,
        "",
        null,
        "1",
      );
    }
  }
}