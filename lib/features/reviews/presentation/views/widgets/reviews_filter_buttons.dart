 import 'package:el_kottab_teacher_app/features/reviews/presentation/views/widgets/reviews_filter_button.dart';
import 'package:el_kottab_teacher_app/main_imports.dart';


class ReviewsFilterButtons extends StatelessWidget {
  const ReviewsFilterButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ReviewsFilterButton(text: LangKeys.teachers, index: 1),
        Gap(12.w),
        ReviewsFilterButton(text: LangKeys.students, index: 2),
      ],
    );
  }
}
