import 'package:el_kottab_teacher_app/features/settings/data/models/add_payment_method_model.dart';
import 'package:el_kottab_teacher_app/features/settings/data/models/delete_account_model.dart';

import '../../data/models/get_payment_methods_model.dart';
import '../../data/models/privacy_policy_model.dart';
import '../../data/models/refund_policy_model.dart';
import '../../data/models/terms_and_conditions_model.dart';
import '../../data/models/who_we_are_model.dart';

abstract class SettingsStates {}

class SettingsInitState extends SettingsStates {}

class GetTermsAndConditionsDataLoadingState extends SettingsStates {}

class GetTermsAndConditionsDataErrorState extends SettingsStates {
  final String error;
  GetTermsAndConditionsDataErrorState(this.error);
}

class GetTermsAndConditionsDataSuccessState extends SettingsStates {
  final TermsAndConditionsModel termsAndConditionsModel;
  GetTermsAndConditionsDataSuccessState(this.termsAndConditionsModel);
}

class GetWhoWeAreDataLoadingState extends SettingsStates {}

class GetWhoWeAreDataErrorState extends SettingsStates {
  final String error;
  GetWhoWeAreDataErrorState(this.error);
}

class GetWhoWeAreDataSuccessState extends SettingsStates {
  final WhoWeAreModel whoWeAreModel;
  GetWhoWeAreDataSuccessState(this.whoWeAreModel);
}

class DeleteAccountLoadingState extends SettingsStates {}

class DeleteAccountErrorState extends SettingsStates {
  final String error;
  DeleteAccountErrorState(this.error);
}

class DeleteAccountSuccessState extends SettingsStates {
  final DeleteAccountModel deleteAccountModel;
  DeleteAccountSuccessState(this.deleteAccountModel);
}

class GetRefundPolicyLoadingState extends SettingsStates {}

class GetRefundPolicyErrorState extends SettingsStates {
  final String error;
  GetRefundPolicyErrorState(this.error);
}

class GetRefundPolicySuccessState extends SettingsStates {
  final RefundPolicyModel refundPolicyModel;
  GetRefundPolicySuccessState(this.refundPolicyModel);
}


class GetPrivacyPolicyLoadingState extends SettingsStates {}

class GetPrivacyPolicyErrorState extends SettingsStates {
  final String error;
  GetPrivacyPolicyErrorState(this.error);
}

class GetPrivacyPolicySuccessState extends SettingsStates {
  final PrivacyPolicyModel privacyPolicyModel;
  GetPrivacyPolicySuccessState(this.privacyPolicyModel);
}


class AddPaymentMethodLoadingState extends SettingsStates {}

class AddPaymentMethodErrorState extends SettingsStates {
  final String error;
  AddPaymentMethodErrorState(this.error);
}

class AddPaymentMethodSuccessState extends SettingsStates {
  final AddPaymentMethodModel addPaymentMethodModel;
  AddPaymentMethodSuccessState(this.addPaymentMethodModel);
}


class GetPaymentMethodLoadingState extends SettingsStates {}

class GetPaymentMethodErrorState extends SettingsStates {
  final String error;
  GetPaymentMethodErrorState(this.error);
}

class GetPaymentMethodSuccessState extends SettingsStates {
  final GetPaymentMethodsModel getPaymentMethodsModel;
  GetPaymentMethodSuccessState(this.getPaymentMethodsModel);
}
