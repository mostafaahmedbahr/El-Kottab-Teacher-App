import 'package:el_kottab_teacher_app/features/home/data/models/teacher_stats_model.dart';
import 'package:el_kottab_teacher_app/features/home/data/models/update_availability_model.dart';

import '../../data/models/home_banners_model.dart';
import '../../data/models/successful_calls_model.dart';

abstract class HomeStates{}

class HomeInitState extends HomeStates{}

class ChangeHomeSliderImageState extends HomeStates{}

class GetHomeSliderLoadingState extends HomeStates{}
class GetHomeSliderErrorState extends HomeStates{
  final String error;
  GetHomeSliderErrorState(this.error);

}
class GetHomeSliderSuccessState extends HomeStates{
  final HomeBannersModel homeBannersModel;
  GetHomeSliderSuccessState(this.homeBannersModel);

}

class GetTeacherStatsLoadingState extends HomeStates{}
class GetTeacherStatsErrorState extends HomeStates{
  final String error;
  GetTeacherStatsErrorState(this.error);

}
class GetTeacherStatsSuccessState extends HomeStates{
  final TeacherStatsModel teacherStatsModel;
  GetTeacherStatsSuccessState(this.teacherStatsModel);

}


class ChangeStatusState extends HomeStates{}
class ChangeStatusLoadingState extends HomeStates{}
class ChangeStatusSuccessState extends HomeStates{
  final UpdateAvailabilityModel updateAvailabilityModel;
  ChangeStatusSuccessState(this.updateAvailabilityModel);
}
class ChangeStatusErrorState extends HomeStates{
  final String error;
  ChangeStatusErrorState(this.error);

}

class GetSuccessfulCallsLoadingState extends HomeStates{}
class GetSuccessfulCallsSuccessState extends HomeStates{
  final SuccessfulCallsModel successfulCallsModel;
  GetSuccessfulCallsSuccessState(this.successfulCallsModel);
}
class GetSuccessfulCallsErrorState extends HomeStates{
  final String error;
  GetSuccessfulCallsErrorState(this.error);
}