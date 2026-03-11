import 'package:el_kottab_teacher_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:el_kottab_teacher_app/features/home/presentation/views/widgets/home_content.dart';
import '../../../../main_imports.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    var homeCubit = context.read<HomeCubit>();
    if(homeCubit.homeBannersModel==null){
      context.read<HomeCubit>().getHomeBanners();
    }
    if(homeCubit.teacherStatsModel==null){
      context.read<HomeCubit>().getTeacherStats(teacherId: CacheHelper.getData(key: "userId"));
    }
    if(homeCubit.successfulCallsModel==null){
      context.read<HomeCubit>().getSuccessfulCalls();
    }
    if(homeCubit.teacherPerformanceModel==null){
      context.read<HomeCubit>().getTeacherPerformance();
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: HomeContent(),
      ),
    );
  }
}
