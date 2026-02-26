import 'package:el_kottab_teacher_app/features/home/presentation/views/widgets/home_content.dart';
import '../../../../main_imports.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: HomeContent(),
      ),
    );
  }
}
