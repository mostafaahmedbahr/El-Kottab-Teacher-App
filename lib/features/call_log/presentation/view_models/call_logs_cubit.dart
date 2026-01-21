import 'package:el_kottab_teacher_app/features/call_log/data/models/calls_model.dart';
import 'package:el_kottab_teacher_app/features/call_log/data/repos/call_logs_repo.dart';

import '../../../../main_imports.dart';
import 'call_logs_states.dart';

class CallLogsCubit extends Cubit<CallLogsStates> {
  CallLogsCubit(this.callLogsRepo) : super(CallLogsInitState());

  static CallLogsCubit get(context) => BlocProvider.of(context);

  final CallLogsRepo callLogsRepo;

  int selectedFilter = 0;
  String? status;
  void changeSelectedFilter(int newIndex) {
    selectedFilter = newIndex;
    emit(ChangeSelectedFilterState());

    String? status;
    if (newIndex == 1) {
      status = 'completed';
    } else if (newIndex == 2) {
      status = 'canceled';
    } else {
      status = null;
    }

    getAllCalls(status);
  }


  CallsModel? callsModel;

  Future<void> getAllCalls(String? type) async {
    emit(GetCallsLoadingState());
    var result = await callLogsRepo.getAllCalls(type);
    result.fold(
          (failure) {
        emit(GetCallsErrorState(failure.errMessage));
      },
          (data) {
        callsModel = data;
        emit(GetCallsSuccessState(data));
      },
    );
  }
}
