import 'package:dartz/dartz.dart';
import 'package:el_kottab_teacher_app/features/profile/data/models/logout_model.dart';
import 'package:el_kottab_teacher_app/features/profile/data/repos/profile_repo.dart';

import '../../../../main_imports.dart';
import '../models/profile_model.dart';

class ProfileRepoImpl implements ProfileRepo {
  final ApiService? apiService;

  ProfileRepoImpl(this.apiService);

  @override
  Future<Either<Failure, LogoutModel>> logout() async {
    try {
      var response = await apiService!.deleteData(endPoint: EndPoints.logout);
      LogoutModel result = LogoutModel.fromJson(response.data);
      return right(result);
    } catch (e) {
      return left(handleError(e));
    }
  }

  @override
  Future<Either<Failure, ProfileModel>> getProfileData() async {
    try {
      var response = await apiService!.getData(endPoint: EndPoints.profile);
      ProfileModel result = ProfileModel.fromJson(response.data);
      return right(result);
    } catch (e) {
      return left(handleError(e));
    }
  }
}
