import 'package:easy_localization/easy_localization.dart';

import '../../../../../main_imports.dart';
import '../../view_model/forget_password_cubit.dart';
import '../../view_model/forget_password_states.dart';

class ForgetPasswordEmailForm extends StatelessWidget {
  const ForgetPasswordEmailForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgetPasswordCubit , ForgetPasswordStates>(
      builder: (context,state){
        var forgetPasswordCubit = context.read<ForgetPasswordCubit>();
        return CustomTextFormField(
          controller: forgetPasswordCubit.emailCon,
          keyboardType: TextInputType.visiblePassword,
          hintText: LangKeys.email.tr(),
          prefixIcon: Padding(
            padding:   EdgeInsets.all(10.0.r),
            child: SvgPicture.asset(SvgImages.email,colorFilter: ColorFilter.mode(AppColors.black, BlendMode.srcIn),),
          ),
          validator: (value)=> AppValidators.emailValidator(value),
        );
      },
    );
  }
}
