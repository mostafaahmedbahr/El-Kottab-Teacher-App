import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../models/edit_profile_info_model.dart';

abstract class EditProfileInfoRepo{

  Future<Either<Failure,EditProfileInfoModel>> editProfileInfoData({required var data });


}