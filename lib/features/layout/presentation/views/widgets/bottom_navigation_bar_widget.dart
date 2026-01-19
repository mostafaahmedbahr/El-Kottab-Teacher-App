import 'package:easy_localization/easy_localization.dart';
import '../../../../../main_imports.dart';
import '../../view_model/layout_cubit.dart';
import '../../view_model/layout_states.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, LayoutStates>(
      builder: (context, state) {
        return BottomNavigationBar(
          currentIndex: LayoutCubit.pageIndex,
          onTap: (index) {
            context.read<LayoutCubit>().changeBottomNav(index, context);
          },
          type: BottomNavigationBarType.fixed,
          elevation: 4.0,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: AppColors.darkOlive,
          unselectedItemColor: AppColors.gray,
          backgroundColor: AppColors.white,
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
          ),
          unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 12.sp,
          ),
          items: [
            _buildTabItem(icon: SvgImages.home, title: LangKeys.home, index: 0),
            _buildTabItem(
              icon: SvgImages.teachers,
              title: LangKeys.callLog,
              index: 1,
            ),
            _buildTabItem(
              icon: SvgImages.sessions,
              title: LangKeys.appointments,
              index: 2,
            ),
            _buildTabItem(
              icon: SvgImages.rating,
              title: LangKeys.ratings,
              index: 3,
            ),
            _buildTabItem(
              icon: SvgImages.profile,
              title: LangKeys.profile,
              index: 4,
            ),
          ],
        );
      },
    );
  }

  BottomNavigationBarItem _buildTabItem({
    required String icon,
    required String title,
    required int index,
  }) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        icon,
        width: 24.w,
        height: 24.h,
        colorFilter: ColorFilter.mode(
          LayoutCubit.pageIndex == index ? AppColors.darkOlive : AppColors.gray,
          BlendMode.srcIn,
        ),
      ),
      activeIcon: SvgPicture.asset(
        icon,
        width: 24.w,
        height: 24.h,
        colorFilter: ColorFilter.mode(AppColors.darkOlive, BlendMode.srcIn),
      ),
      label: title.tr(),
    );
  }
}
