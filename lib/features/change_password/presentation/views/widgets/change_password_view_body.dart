import 'package:el_kottab/main_imports.dart';
 import 'change_password_button.dart';
import 'change_password_form.dart';
import 'change_password_image.dart';

class ChangePasswordViewBody extends StatelessWidget {
  const ChangePasswordViewBody({super.key, required this.screenName});
  final String screenName;
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return   Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: formKey,
        child: ListView(
          children: [
              ChangePasswordForm(screenName: screenName,),
            Gap(30.h),
             ChangePasswordButton(formKey: formKey,screenName: screenName,),
            Gap(70.h),
            const ChangePasswordImage(),

          ],
        ),
      ),
    );
  }
}
