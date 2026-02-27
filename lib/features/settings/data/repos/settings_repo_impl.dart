import 'package:dartz/dartz.dart';
import 'package:el_kottab_teacher_app/features/settings/data/repos/settings_repo.dart';

import '../../../../main_imports.dart';
import '../models/add_payment_method_model.dart';
import '../models/delete_account_model.dart';
import '../models/get_payment_methods_model.dart';
import '../models/privacy_policy_model.dart';
import '../models/refund_policy_model.dart';
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


  @override
  Future<Either<Failure, RefundPolicyModel>> getRefundPolicy() async {
    try {
      var response = await apiService!.getData(
        endPoint: EndPoints.refundPolicy,
      );
      RefundPolicyModel result = RefundPolicyModel.fromJson(
        response.data,
      );
      return right(result);
    } catch (e) {
      return left(handleError(e));
    }
  }

  @override
  Future<Either<Failure, PrivacyPolicyModel>> getPrivacyPolicy() async {
    try {
      var response = await apiService!.getData(
        endPoint: EndPoints.privacyPolicy,
      );
      PrivacyPolicyModel result = PrivacyPolicyModel.fromJson(
        response.data,
      );
      return right(result);
    } catch (e) {
      return left(handleError(e));
    }
  }

  @override
  Future<Either<Failure, GetPaymentMethodsModel>> getPaymentMethods() async {
    try {
      var response = await apiService!.getData(
        endPoint: EndPoints.teacherPaymentMethods,
      );
      GetPaymentMethodsModel result = GetPaymentMethodsModel.fromJson(
        response.data,
      );
      return right(result);
    } catch (e) {
      return left(handleError(e));
    }
  }


  @override
  Future<Either<Failure, AddPaymentMethodModel>> addPaymentMethod(
      String? methodType,
      String? phoneNumber,
      String? bankName,
      String? accountNumber,
      String? receiverName,
      String? isDefault,
      ) async {
    try {
      final Map<String, dynamic> body = {};

      /// ضيف بس القيم اللي مش فاضية
      void addIfNotEmpty(String key, dynamic value) {
        if (value != null &&
            value.toString().isNotEmpty) {
          body[key] = value;
        }
      }

      addIfNotEmpty('method_type', methodType);
      addIfNotEmpty('phone_number', phoneNumber);
      addIfNotEmpty('bank_name', bankName);
      addIfNotEmpty('account_number', accountNumber);
      addIfNotEmpty('receiver_name', receiverName);
      addIfNotEmpty('is_default', isDefault);

      final data = FormData.fromMap(body);

      var response = await apiService!.postData(
        endPoint: EndPoints.teacherPaymentMethods,
        data: data,
      );

      AddPaymentMethodModel result =
      AddPaymentMethodModel.fromJson(response.data);

      return right(result);
    } catch (e) {
      return left(handleError(e));
    }
  }
}
