import '../../data/models/edit_profile_info_model.dart';

abstract class EditProfileInfoStates{}

class EditProfileInfoInitState extends EditProfileInfoStates{}

class EditProfileInfoLoadingState extends EditProfileInfoStates{}
class EditProfileInfoSuccessState extends EditProfileInfoStates{
  final EditProfileInfoModel editProfileInfoModel;
  EditProfileInfoSuccessState(this.editProfileInfoModel);

}
class EditProfileInfoErrorState extends EditProfileInfoStates{
  final String error;
  EditProfileInfoErrorState(this.error);
}


class UploadImageSuccessState  extends EditProfileInfoStates{}
class UploadImageErrorState  extends EditProfileInfoStates{}
class ClearImageSuccessState  extends EditProfileInfoStates{}


class SelectCategoryState  extends EditProfileInfoStates{}
class EditProfileImageLoadingState extends EditProfileInfoStates{}
class EditProfileImageSuccessState extends EditProfileInfoStates{
  final EditProfileInfoModel editProfileInfoModel;
  EditProfileImageSuccessState(this.editProfileInfoModel);

}
class EditProfileImageErrorState extends EditProfileInfoStates{
  final String error;
  EditProfileImageErrorState(this.error);
}