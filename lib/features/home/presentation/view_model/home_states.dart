import '../../data/models/home_banners_model.dart';

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



class ChangeStatusState extends HomeStates{}
