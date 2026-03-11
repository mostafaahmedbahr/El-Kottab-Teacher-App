import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import '../../../../../main_imports.dart';
import '../../../../home/presentation/view_model/home_cubit.dart';
import '../../../../layout/presentation/view_model/layout_cubit.dart';
import '../../../../login/presentation/views/login_view.dart';
import '../../view_model/profile_cubit.dart';
import '../../view_model/profile_states.dart';

void showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => BlocConsumer<ProfileCubit, ProfileStates>(
      listener: (context, state) {
        if (state is LogoutSuccessState) {
          CacheTokenManger.userToken=null;
          CacheTokenManger.clearUserToken();
          context.read<HomeCubit>().resetHomeModels();
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
        return CupertinoAlertDialog(
          title: Text(LangKeys.confirmLogout.tr()),
          content: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(LangKeys.areYouSureLogout.tr()),
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(context),
              child: Text(LangKeys.cancel.tr()),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () {
                profileCubit.logout();
              },
              child: state is LogoutLoadingState
                  ? SizedBox(height: 30, width: 30, child: CustomLoading())
                  : Text(
                LangKeys.logout.tr(),
                style: TextStyle(color: AppColors.errorDark),
              ),
            ),
          ],
        );
      },
    ),
  );
}
