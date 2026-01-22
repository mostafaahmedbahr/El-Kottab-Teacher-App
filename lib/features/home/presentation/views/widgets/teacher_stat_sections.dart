import 'package:el_kottab_teacher_app/features/home/presentation/views/widgets/teacher_rating_and_status.dart';
import 'package:el_kottab_teacher_app/main_imports.dart';

import 'balance_and_performance.dart';

class TeacherStatSections extends StatelessWidget {
  const TeacherStatSections({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        TeacherRatingAndStatus(),
        BalanceAndPerformance(),
      ],
    );
  }
}
