import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../models/logout_model.dart';
import '../models/profile_model.dart';

abstract class ProfileRepo{

    Future<Either<Failure,LogoutModel>> logout();
    Future<Either<Failure,ProfileModel>> getProfileData();




}