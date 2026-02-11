import 'package:el_kottab_teacher_app/features/home/presentation/views/widgets/home_content.dart';
import 'package:el_kottab_teacher_app/features/home/presentation/views/widgets/home_stats_shimmer.dart';
import '../../../../core/errors/error_ui.dart';
import '../../../../main_imports.dart';
import '../view_model/home_cubit.dart';
import '../view_model/home_states.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    // Load performance data when HomeView is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userId = CacheHelper.getData(key: "userId");
      if (userId != null) {
        context.read<HomeCubit>().getTeacherStats(teacherId: userId);
        context.read<HomeCubit>().getTeacherPerformance();
      }
    });

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<HomeCubit, HomeStates>(
          buildWhen: (previous, current) =>
              current is GetTeacherStatsLoadingState ||
              current is GetTeacherStatsErrorState ||
              current is GetTeacherStatsSuccessState ||
              current is GetTeacherPerformanceLoadingState ||
              current is GetTeacherPerformanceErrorState ||
              current is GetTeacherPerformanceSuccessState,
          builder: (context, state) {
            // 🔹 Loading (either stats or performance loading)
            if (state is GetTeacherStatsLoadingState ||
                state is GetTeacherPerformanceLoadingState) {
              return const HomeStatsShimmer();
            }

            // 🔹 Error (either stats or performance error)
            if (state is GetTeacherStatsErrorState ||
                state is GetTeacherPerformanceErrorState) {
              return ErrorUi(
                errorState: state is GetTeacherStatsErrorState
                    ? state.error
                    : (state as GetTeacherPerformanceErrorState).error,
                onPressed: () {
                  final userId = CacheHelper.getData(key: "userId");
                  if (userId != null) {
                    context.read<HomeCubit>().getTeacherStats(
                      teacherId: userId,
                    );
                    context.read<HomeCubit>().getTeacherPerformance();
                  }
                },
              );
            }

            // 🔹 Success (both stats and performance loaded)
            if (state is GetTeacherStatsSuccessState ||
                state is GetTeacherPerformanceSuccessState) {
              return const HomeContent();
            }

            // 🔹 Default state
            return const HomeStatsShimmer();
          },
        ),
      ),
    );
  }
}
