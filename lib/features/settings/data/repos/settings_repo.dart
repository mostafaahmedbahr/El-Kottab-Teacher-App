import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../models/add_payment_method_model.dart';
import '../models/delete_account_model.dart';
import '../models/get_payment_methods_model.dart';
import '../models/privacy_policy_model.dart';
import '../models/refund_policy_model.dart';
import '../models/terms_and_conditions_model.dart';
import '../models/who_we_are_model.dart';

abstract class SettingsRepo{

  Future<Either<Failure,TermsAndConditionsModel>> getTermsAndConditions();
  Future<Either<Failure,WhoWeAreModel>> getWhoWeAre();
  Future<Either<Failure,DeleteAccountModel>> deleteAccount();
  Future<Either<Failure,RefundPolicyModel>> getRefundPolicy();
  Future<Either<Failure,PrivacyPolicyModel>> getPrivacyPolicy();
  Future<Either<Failure,GetPaymentMethodsModel>> getPaymentMethods();
  Future<Either<Failure,AddPaymentMethodModel>> addPaymentMethod(String? methodType , String? phoneNumber,
      String? bankName,String accountNumber , String? receiverName , String? isDefault
      );





}