import 'package:easy_localization/easy_localization.dart';
import 'package:el_kottab_teacher_app/features/call_log/presentation/view_models/call_logs_cubit.dart';
import 'package:el_kottab_teacher_app/features/call_log/presentation/view_models/call_logs_states.dart';

import '../../../../../main_imports.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({super.key, required this.text, required this.index});
  final  String text;
  final  int index;
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<CallLogsCubit , CallLogsStates>(
      builder: (context,state){
        var callLogsCubit = context.read<CallLogsCubit>();
        bool isSelected = callLogsCubit.selectedFilter == index;
        return Expanded(
          child: GestureDetector(
            onTap: () {
              callLogsCubit.changeSelectedFilter(index);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: isSelected ? Theme.of(context).primaryColor : Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected
                      ? Theme.of(context).primaryColor
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
