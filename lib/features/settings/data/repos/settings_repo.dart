import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../models/delete_account_model.dart';
import '../models/terms_and_conditions_model.dart';
import '../models/who_we_are_model.dart';

abstract class SettingsRepo{

  Future<Either<Failure,TermsAndConditionsModel>> getTermsAndConditions();
  Future<Either<Failure,WhoWeAreModel>> getWhoWeAre();
  Future<Either<Failure,DeleteAccountModel>> deleteAccount();





}