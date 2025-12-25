import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../../main_imports.dart';


class PinCodeFieldsWidget extends StatelessWidget {
  final TextEditingController controller;

  const PinCodeFieldsWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: PinCodeTextField(
        keyboardType : TextInputType.number,
        controller: controller,
        length: 6,
        appContext: context,
        onChanged: (value) {
          CacheHelper.saveData(key: "otp", value: value);
        },
        onCompleted: (_) => FocusScope.of(context).unfocus(),
        animationType: AnimationType.fade,
        pinTheme: PinTheme(
          selectedColor: AppColors.darkOlive,
          selectedFillColor: AppColors.darkOlive,
          inactiveColor: AppColors.darkOlive,
          inactiveFillColor: AppColors.white,
          activeColor: AppColors.gold,
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(12.r),
          fieldHeight: 50.h,
          fieldWidth: 50.w,
          activeFillColor: Colors.white,
        ),
        cursorColor: Colors.white,
        animationDuration: const Duration(milliseconds: 300),
        enableActiveFill: true,
        beforeTextPaste: (text) => true,
      ),
    );
  }
}