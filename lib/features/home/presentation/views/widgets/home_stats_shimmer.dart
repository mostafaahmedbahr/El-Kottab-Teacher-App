import 'package:el_kottab_teacher_app/features/home/presentation/views/widgets/teacher_rating_shimmer.dart';

import '../../../../../main_imports.dart';
import 'balance_card_shimmer.dart';
import 'home_slider_images_loading.dart';

class HomeStatsShimmer extends StatelessWidget {
  const HomeStatsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const HomeSliderImagesLoading(),
          Gap(12.h),
          const TeacherRatingShimmer(),
          Gap(12.h),
          const BalanceCardShimmer(),
          Gap(12.h),
          const BalanceCardShimmer(),
        ],
      ),
    );
  }
}
