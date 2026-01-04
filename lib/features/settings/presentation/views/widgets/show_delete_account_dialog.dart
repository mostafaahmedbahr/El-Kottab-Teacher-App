import 'package:easy_localization/easy_localization.dart';
import 'package:el_kottab_teacher_app/features/layout/presentation/view_model/layout_cubit.dart';
import 'package:el_kottab_teacher_app/features/login/presentation/views/login_view.dart';

import '../../../../../main_imports.dart';
import '../../view_model/settings_cubit.dart';
import '../../view_model/settings_states.dart';

void showDeleteAccountDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => BlocConsumer<SettingsCubit, SettingsStates>(
      listener: (context, state) {
        if (state is DeleteAccountSuccessState) {
          Toast.showSuccessToast(
            msg: state.deleteAccountModel.message.toString(),
            context: context,
          );
          AppNav.customNavigator(
            context: context,
            screen: LoginView(),
            finish: true,
          );
          LayoutCubit.pageIndex = 0;
        } else if (state is DeleteAccountErrorState) {
          Toast.showErrorToast(msg: state.error.toString(), context: context);
        }
      },
      builder: (context, state) {
        var settingsCubit = context.read<SettingsCubit>();
        return AlertDialog(
          title: Text(LangKeys.confirmDeleteAccount.tr()),
          content: Text(LangKeys.areYouSureToDeleteYourAccount.tr()),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(LangKeys.cancel.tr()),
            ),
            TextButton(
              onPressed: () {
                settingsCubit.deleteAccount();
              },
              child: ConditionalBuilder(
                condition: state is! DeleteAccountLoadingState,
                fallback: (context) =>
                    SizedBox(height: 30.h, width: 30.w, child: CustomLoading()),
                builder: (context) {
                  return Text(
                    LangKeys.delete.tr(),
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
