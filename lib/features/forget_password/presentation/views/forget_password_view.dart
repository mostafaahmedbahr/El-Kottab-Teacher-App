import 'package:easy_localization/easy_localization.dart';
import 'package:el_kottab_teacher_app/features/forget_password/presentation/views/widgets/forget_password_view_body.dart';
 import '../../../../main_imports.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LangKeys.resetPassword.tr() ),
      ),
      body:   ForgetPasswordViewBody(),
    );
  }
}
