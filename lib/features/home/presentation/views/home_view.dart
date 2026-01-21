import 'package:el_kottab_teacher_app/features/home/presentation/views/widgets/balance_and_performance.dart';
import 'package:el_kottab_teacher_app/features/home/presentation/views/widgets/home_slider_images.dart';
import 'package:el_kottab_teacher_app/features/home/presentation/views/widgets/successful_calls.dart';
import 'package:el_kottab_teacher_app/features/home/presentation/views/widgets/teacher_rating_and_status.dart';
import '../../../../core/app_services/remote_services/service_locator.dart';
import '../../../../main_imports.dart';
import '../../data/repos/home_repo_impl.dart';
import '../view_model/home_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocProvider(
          create: (context) => HomeCubit(getIt.get<HomeRepoImpl>())
            ..getHomeBanners()
            ..getTeacherStats(teacherId: CacheHelper.getData(key: "userId"))..getSuccessfulCalls(),
          child: SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(children: [HomeSliderImages(), Gap(12.h)]),
                ),
                SliverToBoxAdapter(child: const TeacherRatingAndStatus()),
                SliverToBoxAdapter(child: const BalanceAndPerformance()),
                SliverToBoxAdapter(child: SuccessfulCalls()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
