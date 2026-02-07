import 'package:el_kottab_teacher_app/core/extensions/log_util.dart';
import 'package:el_kottab_teacher_app/features/layout/presentation/views/widgets/bottom_navigation_bar_widget.dart';
import 'package:el_kottab_teacher_app/features/layout/presentation/views/widgets/profile_name_and_notification_icon.dart';
import '../../../../main_imports.dart';
import '../view_model/layout_cubit.dart';
import '../view_model/layout_states.dart';

class LayoutView extends StatelessWidget {
  const LayoutView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, LayoutStates>(

      builder: (context, state) {
        var layoutCubit = LayoutCubit.get(context);
        logSuccess(CacheTokenManger.userToken.toString());
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) async {
            layoutCubit.onPopInvoked(didPop, context);
          },
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
               title: const ProfileNameAndNotificationIcon(),
            ),
            body: layoutCubit.screens[LayoutCubit.pageIndex],
            bottomNavigationBar: const BottomNavigationBarWidget(),
          ),
        );
      },
    );
  }



}