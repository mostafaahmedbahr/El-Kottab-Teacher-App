import 'package:el_kottab_teacher_app/features/call_log/data/repos/call_logs_repo.dart';

import '../../../../main_imports.dart';
import 'call_logs_states.dart';

class CallLogsCubit extends Cubit<CallLogsStates> {
  CallLogsCubit(this.callLogsRepo) : super(CallLogsInitState());

  static CallLogsCubit get(context) => BlocProvider.of(context);
  CallLogsRepo? callLogsRepo;
  int selectedFilter = 0;
  changeSelectedFilter(int newIndex)
  {
    selectedFilter = newIndex;
    emit(ChangeSelectedFilterState());
  }

}