 import '../../../../../core/app_services/remote_services/service_locator.dart';
import '../../../../../main_imports.dart';
import '../../../data/repos/edit_profile_repo_imple.dart';
import '../../view_model/edit_profile_info_cubit.dart';
import '../../view_model/edit_profile_info_states.dart';
import 'edit_profile_button.dart';
 import 'edit_profile_image.dart';
import 'edit_profile_name_email_phone_form.dart';

class EditProfileInfoViewBody extends StatelessWidget {
  const EditProfileInfoViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>EditProfileInfoCubit(getIt.get<EditProfileInfoRepoImpl>()),
      child: BlocBuilder<EditProfileInfoCubit, EditProfileInfoStates>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                 EditProfileImage(),
                EditProfileNameEmailPhoneForm(),
                Gap(40.h),
                EditProfileButton(),
              ],
            ),
          );
        },
      ),
    );
  }
}
