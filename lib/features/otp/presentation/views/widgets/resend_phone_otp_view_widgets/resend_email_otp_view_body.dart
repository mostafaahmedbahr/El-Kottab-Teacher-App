import 'package:easy_localization/easy_localization.dart';

import '../../../../../../main_imports.dart';
import '../../../view_model/otp_cubit.dart';
import '../../../view_model/otp_states.dart';

class ResendEmailOtpViewBody extends StatelessWidget {
  const ResendEmailOtpViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return BlocBuilder<OtpCubit , OtpStates>(
      builder: (context,state){
        var otpCubit = context.read<OtpCubit>();
        return Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(30.h),
                CustomTextFormField(
                  controller: otpCubit.emailCon,
                  keyboardType: TextInputType.emailAddress,
                  hintText: LangKeys.email.tr(),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SvgPicture.asset(SvgImages.email,colorFilter: ColorFilter.mode(AppColors.black, BlendMode.srcIn)),
                  ),
                  //validator: (value) => MyValidators.emailValidator(value),
                ),
                    Gap(20.h),
                // ResendEmailOtpButton(formKey: formKey),
              ],
            ),
          ),
        );
      },

    );
  }
}
