import 'package:easy_localization/easy_localization.dart';
import 'package:el_kottab_teacher_app/core/app_services/remote_services/service_locator.dart';
import 'package:el_kottab_teacher_app/features/change_password/data/repos/change_password_repo_imple.dart';
import 'package:el_kottab_teacher_app/features/change_password/presentation/view_model/change_password_cubit.dart';
import 'package:el_kottab_teacher_app/features/change_password/presentation/views/widgets/change_password_view_body.dart';

import '../../../../main_imports.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key, required this.screenName});
  final String screenName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LangKeys.changePassword.tr())),
      body: BlocProvider(
        create: (context) =>
            ChangePasswordCubit(getIt.get<ChangePasswordRepoImpl>()),
        child: ChangePasswordViewBody(screenName: screenName),
      ),
    );
  }
}
