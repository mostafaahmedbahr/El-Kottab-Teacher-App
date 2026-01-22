import 'package:el_kottab_teacher_app/features/home/presentation/views/widgets/successful_calls.dart';
import 'package:el_kottab_teacher_app/features/home/presentation/views/widgets/teacher_stat_sections.dart';

import '../../../../../main_imports.dart';
import 'home_slider_images.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              HomeSliderImages(),
              Gap(12.h),
            ],
          ),
        ),
        const SliverToBoxAdapter(
          child: TeacherStatSections(),
        ),
        SliverToBoxAdapter(
          child: SuccessfulCalls(),
        ),
      ],
    );
  }
}
