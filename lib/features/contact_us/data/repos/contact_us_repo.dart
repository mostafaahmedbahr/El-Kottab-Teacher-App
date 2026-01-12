import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../models/contact_us_model.dart';

abstract class ContactUsRepo{

  Future<Either<Failure,ContactUsModel>> contactUs({
    required String email,
    required String phone,
    required String title,
    required String message,
    required String country,
});



}