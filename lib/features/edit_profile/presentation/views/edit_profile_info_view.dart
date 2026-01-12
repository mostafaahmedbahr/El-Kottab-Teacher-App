import 'package:easy_localization/easy_localization.dart';
import 'package:el_kottab_teacher_app/features/edit_profile/presentation/views/widgets/edit_profile_info_view_body.dart';
import '../../../../main_imports.dart';

class EditProfileInfoView extends StatelessWidget {
  const EditProfileInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LangKeys.editProfileInfo.tr()),
      ),
      body: const EditProfileInfoViewBody(),
    );
  }
}
