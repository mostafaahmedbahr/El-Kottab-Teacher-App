import 'package:easy_localization/easy_localization.dart';
import 'package:el_kottab_teacher_app/features/register/presentation/views/complete_register_view.dart';
import 'package:el_kottab_teacher_app/features/register/presentation/views/widgets/register_next_button.dart';
import 'package:el_kottab_teacher_app/features/register/presentation/views/widgets/register_name_email_password_form.dart';
import 'package:el_kottab_teacher_app/main_imports.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(title: Text(LangKeys.signUp.tr())),
      body: Padding(
        padding: EdgeInsets.all(20.0.r),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              Row(
                children: [
                  Text(LangKeys.signUpMsg.tr()),
                  // TextButton(
                  //   onPressed: () {
                  //     Navigator.pop(context);
                  //   },
                  //   child: Text(
                  //     LangKeys.signIn.tr(),
                  //     style: AppStyles.primary16SemiBold,
                  //   ),
                  // ),
                ],
              ),
              Gap(32.h),
              RegisterNameEmailPasswordForm(),
              Gap(32.h),
              RegisterNextButton(screen: CompleteRegisterView(),formKey: formKey,screenName: "RegisterView",),
            ],
          ),
        ),
      ),
    );
  }
}
