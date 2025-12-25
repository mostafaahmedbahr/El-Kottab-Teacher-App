import '../../../../../main_imports.dart';
import 'filter_button.dart';

class FilterButtons extends StatelessWidget {
  const FilterButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FilterButton(text: LangKeys.all , index: 0),
        Gap(8.w),
        FilterButton(text: LangKeys.completed , index: 1),
        Gap(8.w),
        FilterButton(text: LangKeys.canceled , index: 2),
      ],
    );
  }
}
