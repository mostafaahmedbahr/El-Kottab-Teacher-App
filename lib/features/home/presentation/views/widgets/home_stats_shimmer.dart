import 'package:el_kottab_teacher_app/features/home/presentation/views/widgets/teacher_availability_rating_shimmer.dart';
import 'package:el_kottab_teacher_app/features/home/presentation/views/widgets/balance_and_performance_shimmer.dart';
import 'package:el_kottab_teacher_app/features/home/presentation/views/widgets/home_slider_images_loading.dart';
import 'package:el_kottab_teacher_app/main_imports.dart';

class HomeStatsShimmer extends StatelessWidget {
  const HomeStatsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: HomeSliderImagesLoading()),
        SliverToBoxAdapter(child: Gap(12.h)),

        const SliverToBoxAdapter(child: TeacherRatingAndStatusShimmer()),
        SliverToBoxAdapter(child: Gap(12.h)),

        const SliverToBoxAdapter(child: BalanceAndPerformanceShimmer()),
        SliverToBoxAdapter(child: Gap(12.h)),
      ],
    );
  }
}
