import 'package:easy_localization/easy_localization.dart';
import 'package:el_kottab_teacher_app/features/call_log/presentation/view_models/call_logs_cubit.dart';
import '../../../../../main_imports.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({super.key, required this.text, required this.index});
  final String text;
  final int index;

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<CallLogsCubit>();
    final bool isSelected = cubit.selectedFilter == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          cubit.changeSelectedFilter(index);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.darkOlive : AppColors.filterBg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? AppColors.darkOlive
                  : AppColors.filterBorder,
            ),
          ),
          child: Center(
            child: Text(
              text.tr(),
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.darkOlive,
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

