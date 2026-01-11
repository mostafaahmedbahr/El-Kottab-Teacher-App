import 'package:el_kottab_teacher_app/features/profile/data/models/logout_model.dart';
import 'package:el_kottab_teacher_app/features/profile/data/models/profile_model.dart';
import 'package:el_kottab_teacher_app/features/profile/presentation/view_model/profile_states.dart';

import '../../../../main_imports.dart';
import '../../data/repos/profile_repo.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit(this.profileRepo) : super(ProfileInitState());

  final ProfileRepo profileRepo;

  static ProfileCubit get(BuildContext context) =>
      BlocProvider.of<ProfileCubit>(context);

  LogoutModel? logoutModel;

  Future<void> logout() async {
    emit(LogoutLoadingState());
    final result = await profileRepo.logout();
    result.fold(
      (failure) {
        emit(LogoutErrorState(failure.errMessage));
      },
      (data) {
        logoutModel = data;
        emit(LogoutSuccessState(data));
      },
    );
  }

  ProfileModel? profileModel;

  Future<void> getProfileData() async {
    emit(GetProfileDataLoadingState());
    final result = await profileRepo.getProfileData();
    result.fold(
      (failure) {
        emit(GetProfileDataErrorState(failure.errMessage));
      },
      (data) {
        profileModel = data;
        emit(GetProfileDataSuccessState(data));
      },
    );
  }
}
