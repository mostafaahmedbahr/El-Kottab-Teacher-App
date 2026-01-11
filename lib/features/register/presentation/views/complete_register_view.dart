import 'package:easy_localization/easy_localization.dart';

import 'package:el_kottab_teacher_app/features/register/presentation/views/widgets/complete_register_button.dart';
import 'package:el_kottab_teacher_app/features/register/presentation/views/widgets/complete_register_form.dart';
import 'package:el_kottab_teacher_app/main_imports.dart';

class CompleteRegisterView extends StatelessWidget {
  const CompleteRegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(title: Text(LangKeys.primaryData.tr())),
      body: Padding(
        padding: EdgeInsets.all(20.0.r),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              Text(
                LangKeys.pleaseEnterTheFollowingData.tr(),
                style: AppStyles.black16SemiBold,
              ),
              Text(
                LangKeys
                    .enterTheFollowingInformationToSuccessfullyCreateAnAccount
                    .tr(),
                style: AppStyles.gray14SemiBold,
              ),
              Gap(20.h),
              CompleteRegisterForm(),
              Gap(32.h),
              CompleteRegisterButton(formKey: formKey),
            ],
          ),
        ),
      ),
    );
  }
}
