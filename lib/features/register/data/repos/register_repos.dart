import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/errors/failure.dart';
import '../models/categories_model.dart';
import '../models/register_model.dart';

abstract class RegisterRepo{


 Future<Either<Failure,RegisterModel>> register({required FormData data});
 Future<Either<Failure,CategoriesModel>> getAllCategories();





}