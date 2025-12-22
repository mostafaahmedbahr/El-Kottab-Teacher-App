import 'package:easy_localization/easy_localization.dart';
import 'package:el_kottab_teacher_app/features/login/presentation/views/widgets/do_not_have_account.dart';
import 'package:el_kottab_teacher_app/features/login/presentation/views/widgets/forget_password.dart';
import 'package:el_kottab_teacher_app/features/login/presentation/views/widgets/login_button.dart';
import 'package:el_kottab_teacher_app/features/login/presentation/views/widgets/login_email_and_password_form.dart';
import 'package:el_kottab_teacher_app/features/login/presentation/views/widgets/logo_widget.dart';

import '../../../../core/app_services/remote_services/service_locator.dart';
import '../../../../main_imports.dart';
import '../../data/repos/login_repo_impl.dart';
import '../view_model/login_cubit.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    final loginKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LangKeys.signIn.tr(),
        ),
      ),
      body: BlocProvider(
          create: (context) => LoginCubit(getIt.get<LoginRepoImpl>()),
        child: SingleChildScrollView(
          child: Padding(
            padding:   EdgeInsets.all(20.r),
            child: Form(
              key: loginKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Logo(),
                  Gap(30.h),
                  LoginEmailAndPasswordForm(),
                  Gap(12.h),
                  LoginButton(formKey: loginKey,),
                  Gap(24.h),
                  ForgetPassword(),
                  Gap(24.h),
                  DoNotHaveAccount(),

                ],
              ),
            ),
          ),
        ),
      ),

    );
  }
}
