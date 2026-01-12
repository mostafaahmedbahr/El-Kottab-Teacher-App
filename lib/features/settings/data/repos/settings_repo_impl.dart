import 'package:dartz/dartz.dart';
import 'package:el_kottab_teacher_app/features/settings/data/repos/settings_repo.dart';

import '../../../../main_imports.dart';
import '../models/delete_account_model.dart';
import '../models/terms_and_conditions_model.dart';
import '../models/who_we_are_model.dart';

class SettingsRepoImpl implements SettingsRepo {
  final ApiService? apiService;

  SettingsRepoImpl(this.apiService);

  @override
  Future<Either<Failure, TermsAndConditionsModel>>
  getTermsAndConditions() async {
    try {
      var response = await apiService!.getData(
        endPoint: EndPoints.termsAndConditions,
      );
      TermsAndConditionsModel result = TermsAndConditionsModel.fromJson(
        response.data,
      );
      return right(result);
    } catch (e) {
      return left(handleError(e));
    }
  }

  @override
  Future<Either<Failure, WhoWeAreModel>> getWhoWeAre() async {
    try {
      var response = await apiService!.getData(
        endPoint: EndPoints.whoWeAre,
      );
      WhoWeAreModel result = WhoWeAreModel.fromJson(response.data);
      return right(result);
    } catch (e) {
      return left(handleError(e));
    }
  }

  @override
  Future<Either<Failure, DeleteAccountModel>> deleteAccount() async {
    try {
      var response = await apiService!.deleteData(
        endPoint: EndPoints.deleteAccount,
      );
      DeleteAccountModel result = DeleteAccountModel.fromJson(response.data);
      return right(result);
    } catch (e) {
      return left(handleError(e));
    }
  }
}
