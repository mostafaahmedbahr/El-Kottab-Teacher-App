import 'package:easy_localization/easy_localization.dart';
import 'package:el_kottab_teacher_app/features/forget_password/presentation/views/widgets/forget_password_view_body.dart';
import '../../../../main_imports.dart';
import '../view_model/forget_password_cubit.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {

  @override
  void initState() {
    super.initState();

    /// امسح القيم أول ما الصفحة تفتح
    context.read<ForgetPasswordCubit>().emailCon.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LangKeys.resetPassword.tr()),
      ),
      body: const ForgetPasswordViewBody(),
    );
  }
}