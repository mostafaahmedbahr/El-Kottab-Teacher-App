import 'package:el_kottab_teacher_app/features/home/presentation/views/widgets/home_content.dart';
import 'package:el_kottab_teacher_app/features/home/presentation/views/widgets/home_stats_shimmer.dart';
import '../../../../core/app_services/remote_services/service_locator.dart';
import '../../../../core/errors/error_ui.dart';
import '../../../../main_imports.dart';
import '../../data/repos/home_repo_impl.dart';
import '../view_model/home_cubit.dart';
import '../view_model/home_states.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<HomeCubit, HomeStates>(
          buildWhen: (previous, current) =>
          current is GetTeacherStatsLoadingState ||
              current is GetTeacherStatsErrorState ||
              current is GetTeacherStatsSuccessState,
          builder: (context, state) {
            // 🔹 Loading
            if (state is GetTeacherStatsLoadingState) {
              return const HomeStatsShimmer();
            }

            // 🔹 Error
            if (state is GetTeacherStatsErrorState) {
              return ErrorUi(
                errorState: state.error,
                onPressed: () {
                  context.read<HomeCubit>().getTeacherStats(
                    teacherId:
                    CacheHelper.getData(key: "userId"),
                  );
                },
              );
            }

            // 🔹 Success
            return const HomeContent();
          },
        ),
      ),
    );
  }
}

