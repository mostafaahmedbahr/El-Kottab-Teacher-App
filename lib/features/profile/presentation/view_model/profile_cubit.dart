import 'package:el_kottab_teacher_app/features/profile/presentation/view_model/profile_states.dart';

import '../../../../main_imports.dart';
import '../../data/models/logout_model.dart';
import '../../data/models/profile_model.dart';
import '../../data/repos/profile_repo.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit(this.profileRepo) : super(ProfileInitState());

  ProfileRepo? profileRepo;
  static ProfileCubit get(context) => BlocProvider.of(context);



  LogoutModel? logoutModel;
  Future<void> logout()
  async {
    emit(LogoutLoadingState());
    var result = await profileRepo!.logout();
    return result.fold((failure) {
      emit(LogoutErrorState(failure.errMessage));
    }, (data) async {
      logoutModel = data;
      emit(LogoutSuccessState(data));
    });
  }

  ProfileModel? profileModel;
  Future<void> getProfileData()
  async {
    emit(GetProfileDataLoadingState());
    var result = await profileRepo!.getProfileData();
    return result.fold((failure) {
      emit(GetProfileDataErrorState(failure.errMessage));
    }, (data) async {
      profileModel = data;
      emit(GetProfileDataSuccessState(data));
    });
  }


}