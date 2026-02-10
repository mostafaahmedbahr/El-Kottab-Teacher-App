import 'package:el_kottab_teacher_app/features/call_log/data/models/calls_model.dart';
import '../../data/models/call_revision_model.dart';

abstract class CallLogsStates {}

class CallLogsInitState extends CallLogsStates {}

class ChangeSelectedFilterState extends CallLogsStates {}

class GetCallsLoadingState extends CallLogsStates {}

class GetCallsSuccessState extends CallLogsStates {
  final CallsModel callsModel;
  GetCallsSuccessState(this.callsModel);
}

class GetCallsErrorState extends CallLogsStates {
  final String error;
  GetCallsErrorState(this.error);
}

class AddRevisionLoadingState extends CallLogsStates {}

class AddRevisionSuccessState extends CallLogsStates {
  final CallRevisionModel revision;
  AddRevisionSuccessState(this.revision);
}

class AddRevisionErrorState extends CallLogsStates {
  final String error;
  AddRevisionErrorState(this.error);
}
