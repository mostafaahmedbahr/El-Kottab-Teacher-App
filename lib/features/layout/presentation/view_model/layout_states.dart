import '../../data/models/rate_student_model.dart';

abstract class LayoutStates {}

class LayoutInitState extends LayoutStates {}

class ChangeBottomNavState extends LayoutStates {}

class RateStudentLoadingState extends LayoutStates {}
class RateStudentSuccessState extends LayoutStates {
  final RateStudentModel rateStudentModel;
  RateStudentSuccessState(this.rateStudentModel);

}
class RateStudentErrorState extends LayoutStates {
  final String error;
  RateStudentErrorState(this.error);

}
