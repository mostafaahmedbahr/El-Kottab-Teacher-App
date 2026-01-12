import 'package:dartz/dartz.dart';
import '../../../../main_imports.dart';
import '../models/edit_profile_info_model.dart';
import 'edit_profile_info_repo.dart';

class EditProfileInfoRepoImpl implements EditProfileInfoRepo {
  final ApiService? apiService;
  EditProfileInfoRepoImpl(this.apiService);

  @override
  Future<Either<Failure, EditProfileInfoModel>> editProfileInfoData({
  required var data,
}) async{
    try {
      var response = await apiService!.postData(
        endPoint: EndPoints.profile,
        data: data,
        isMultipart: true,
      );
      EditProfileInfoModel result = EditProfileInfoModel.fromJson(response.data);
      return right(result);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }







}