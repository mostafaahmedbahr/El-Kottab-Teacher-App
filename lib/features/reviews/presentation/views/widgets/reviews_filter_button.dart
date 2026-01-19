import 'package:easy_localization/easy_localization.dart';
import '../../../../../main_imports.dart';
import '../../view_model/reviews_cubit.dart';
import '../../view_model/reviews_states.dart';

class ReviewsFilterButton extends StatelessWidget {
  const ReviewsFilterButton({
    super.key,
    required this.text,
    required this.index,
  });
  final String text;
  final int index;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewsCubit, ReviewsStates>(
      builder: (context, state) {
        var reviewsCubit = context.read<ReviewsCubit>();
        bool isSelected = reviewsCubit.selectedFilter == index;
        return Expanded(
          child: GestureDetector(
            onTap: () {
              reviewsCubit.changeSelectedFilter(index);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.darkOlive : Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected
                      ? Theme.of(context).cardColor
                      : Colors.grey[300]!,
                ),
              ),
              child: Center(
                child: Text(
                  text.tr(),
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey[700],
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
