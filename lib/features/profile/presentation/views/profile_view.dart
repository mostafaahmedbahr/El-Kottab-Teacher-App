import 'package:el_kottab_teacher_app/features/profile/presentation/views/widgets/logout.dart';
import 'package:el_kottab_teacher_app/features/profile/presentation/views/widgets/profile_info_data.dart';
import 'package:el_kottab_teacher_app/features/profile/presentation/views/widgets/profile_list_items.dart';

import '../../../../core/shared_cubits/auth_cubit/auth_cubit.dart';
import '../../../../main_imports.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Padding(
        padding:   EdgeInsets.all(12.0.r),
        child:
        ListView(
          children: [
            ProfileInfoData(),
            Gap(16.h),
            ProfileListItems(),
            Gap(16.h),
            Logout(),

          ],
        ),
      )),
    );
  }
}