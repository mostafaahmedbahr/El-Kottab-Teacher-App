import 'package:easy_localization/easy_localization.dart';
import 'package:el_kottab_teacher_app/features/login/presentation/views/login_view.dart';

import '../../../../../main_imports.dart';
import '../../../../layout/presentation/view_model/layout_cubit.dart';
import '../../view_model/profile_cubit.dart';
import '../../view_model/profile_states.dart';

void showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => BlocConsumer<ProfileCubit, ProfileStates>(
      listener: (context, state) {
        if (state is LogoutSuccessState) {
          Toast.showSuccessToast(
            msg: state.logoutModel.message.toString(),
            context: context,
          );
          AppNav.customNavigator(
            context: context,
            screen: LoginView(),
            finish: true,
          );
          LayoutCubit.pageIndex = 0;
        } else if (state is LogoutErrorState) {
          Toast.showErrorToast(msg: state.error.toString(), context: context);
        }
      },
      builder: (context, state) {
        var profileCubit = context.read<ProfileCubit>();
        return AlertDialog(
          title: Text(LangKeys.confirmLogout.tr()),
          content: Text(LangKeys.areYouSureLogout.tr()),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(LangKeys.cancel.tr()),
            ),
            TextButton(
              onPressed: () {
                profileCubit.logout();
              },
              child: ConditionalBuilder(
                condition: state is! LogoutLoadingState,
                fallback: (context) =>
                    SizedBox(height: 30.h, width: 30.w, child: CustomLoading()),
                builder: (context) {
                  return Text(
                    LangKeys.logout.tr(),
                    style: TextStyle(color: AppColors.errorDark),
                  );
                },
              ),
            ),
          ],
        );
      },
    ),
  );
}
