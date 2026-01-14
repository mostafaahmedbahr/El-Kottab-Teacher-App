import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../models/home_banners_model.dart';
import '../models/update_availability_model.dart';

abstract class HomeRepo{

   Future<Either<Failure,HomeBannersModel>> getHomeBanners();
   Future<Either<Failure,UpdateAvailabilityModel>> updateAvailability({required String status});





}