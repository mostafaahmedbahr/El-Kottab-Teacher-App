
import '../../data/models/contact_us_model.dart';
import '../../data/models/settings_model.dart';

abstract class ContactUsStates{}

class ContactUsInitState extends ContactUsStates{}

class ContactUsLoadingState extends ContactUsStates{}
class ContactUsErrorState extends ContactUsStates{
  final String error;
  ContactUsErrorState(this.error);

}
class ContactUsSuccessState extends ContactUsStates{
  final ContactUsModel contactUsModel;
  ContactUsSuccessState(this.contactUsModel);

}

class GetSettingsDataLoadingState extends ContactUsStates{}
class GetSettingsDataErrorState extends ContactUsStates{
  final String error;
  GetSettingsDataErrorState(this.error);

}
class GetSettingsDataSuccessState extends ContactUsStates{
  final SettingsModel settingsModel;
  GetSettingsDataSuccessState(this.settingsModel);

}
