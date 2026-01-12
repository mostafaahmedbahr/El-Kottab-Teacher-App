
import '../../data/models/contact_us_model.dart';

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

