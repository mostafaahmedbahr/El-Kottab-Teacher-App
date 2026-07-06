import 'package:el_kottab_teacher_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:el_kottab_teacher_app/features/home/presentation/views/widgets/successful_calls.dart';
import 'package:el_kottab_teacher_app/features/home/presentation/views/widgets/teacher_stat_sections.dart';

import '../../../../../main_imports.dart';
import 'home_slider_images.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: AppColors.darkOlive,
      backgroundColor: AppColors.white,
      onRefresh: () async {
        final homeCubit = context.read<HomeCubit>();
        final userId = CacheHelper.getData(key: "userId");

        // Fetch all data again for refresh
        homeCubit.getHomeBanners();
        homeCubit.getSuccessfulCalls();
        homeCubit.getTeacherPerformance();
        if (userId != null) {
          homeCubit.getTeacherStats(teacherId: userId);
        }

        // Add a small delay to allow animations to complete smoothly
        await Future.delayed(const Duration(milliseconds: 500));
      },
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Column(children: [HomeSliderImages(), Gap(12.h)]),
          ),
          const SliverToBoxAdapter(child: TeacherStatSections()),
          SliverToBoxAdapter(child: SuccessfulCalls()),
        ],
      ),
    );
  }
}
