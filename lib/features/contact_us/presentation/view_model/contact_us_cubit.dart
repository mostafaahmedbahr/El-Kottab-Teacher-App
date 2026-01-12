import '../../../../main_imports.dart';
import '../../data/models/contact_us_model.dart';
import '../../data/repos/contact_us_repo.dart';
import 'contact_us_states.dart';

class ContactUsCubit extends Cubit<ContactUsStates> {
  ContactUsCubit(this.contactUsRepo) : super(ContactUsInitState());

  static ContactUsCubit get(context) => BlocProvider.of(context);

  final ContactUsRepo? contactUsRepo;

  ContactUsModel? contactUsModel;

  Future<void> contactUs() async {
    emit(ContactUsLoadingState());
    var result = await contactUsRepo!.contactUs(
      email: emailCon.text,
      phone: phoneNumber,
      title: titleCon.text,
      message: messageCon.text,
      country: countryName,
    );
    return result.fold(
      (failure) {
        emit(ContactUsErrorState(failure.errMessage));
      },
      (data) async {
        contactUsModel = data;
        emit(ContactUsSuccessState(data));
      },
    );
  }

  var emailCon = TextEditingController();
  var phoneCon = TextEditingController();
  var titleCon = TextEditingController();
  var messageCon = TextEditingController();
  String phoneNumber = '';
  String countryCode = '';
  String countryName = 'Egypt';

}
