import 'package:el_kottab_teacher_app/core/app_services/remote_services/service_locator.dart';
import 'package:el_kottab_teacher_app/features/profile/data/repos/profile_repo.dart';
import 'package:el_kottab_teacher_app/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:el_kottab_teacher_app/features/profile/presentation/views/widgets/logout.dart';
import 'package:el_kottab_teacher_app/features/profile/presentation/views/widgets/profile_info_data.dart';
import 'package:el_kottab_teacher_app/features/profile/presentation/views/widgets/profile_list_items.dart';
import '../../../../main_imports.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(getIt<ProfileRepo>())..getProfileData(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(12.0.r),
            child: ListView(
              children: const [
                ProfileInfoData(),
                Gap(16),
                ProfileListItems(),
                Gap(16),
                Logout(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
