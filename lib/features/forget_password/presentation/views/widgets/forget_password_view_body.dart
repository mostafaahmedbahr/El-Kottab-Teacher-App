import 'package:el_kottab_teacher_app/features/forget_password/presentation/views/widgets/reset_password_button.dart';

import '../../../../../main_imports.dart';
import 'forget_password_email_form.dart';
import 'forget_password_texts.dart';

class ForgetPasswordViewBody extends StatelessWidget {
  const ForgetPasswordViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: formKey,
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(20.h),
             const  ForgetPasswordTexts(),
            Gap(20.h),
              const  ForgetPasswordEmailForm(),
            Gap(20.h),
            ForgetPasswordButton(formKey),
          ],
        ),
      ),
    );
  }
}
