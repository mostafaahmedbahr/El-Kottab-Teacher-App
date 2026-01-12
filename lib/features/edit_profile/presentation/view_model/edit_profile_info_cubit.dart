import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../../../../main_imports.dart';
import '../../../profile/data/models/profile_model.dart';
import '../../data/models/edit_profile_info_model.dart';
import '../../data/repos/edit_profile_info_repo.dart';
import 'edit_profile_info_states.dart';

class EditProfileInfoCubit extends Cubit<EditProfileInfoStates> {
  EditProfileInfoCubit(this.editProfileInfoRepo)
    : super(EditProfileInfoInitState());

  EditProfileInfoRepo? editProfileInfoRepo;

  static EditProfileInfoCubit get(context) => BlocProvider.of(context);

  EditProfileInfoModel? editProfileInfoModel;



  Future<void> editProfileInfoData({
    required String? name,
    required String? email,
    required String? phoneNumber,
    required String? gender,
    required File? image,
    required String? description,
    // required String? categoryId,
  }) async {
    emit(EditProfileInfoLoadingState());

    // دائماً استخدم FormData لسهولة التعامل مع الحالتين
    FormData formData = FormData();

    // إضافة الحقول النصية
    if (name != null && name.isNotEmpty) {
      formData.fields.add(MapEntry('name', name));
    }
    if (email != null && email.isNotEmpty) {
      formData.fields.add(MapEntry('email', email));
    }
    if (phoneNumber != null && phoneNumber.isNotEmpty) {
      formData.fields.add(MapEntry('phone', phoneNumber));
    }
    if (gender != null && gender.isNotEmpty) {
      formData.fields.add(MapEntry('gender', gender));
    }
    if (description != null && description.isNotEmpty) {
      formData.fields.add(MapEntry('description', description));
    }
    // if (categoryId != null) {
    //   formData.fields.add(MapEntry('category_id', categoryId.toString()));
    // }

    // إضافة الصورة إذا كانت موجودة
    if (image != null) {
      formData.files.add(MapEntry(
        'image',
        await MultipartFile.fromFile(
          image.path,
          filename: image.path.split('/').last,
        ),
      ));
    }

    var result = await editProfileInfoRepo!.editProfileInfoData(
      data: formData,
    );

    return result.fold(
          (failure) {
        emit(EditProfileInfoErrorState(failure.errMessage));
      },
          (data) async {
        editProfileInfoModel = data;
        emit(EditProfileInfoSuccessState(data));
      },
    );
  }


  final TextEditingController categoryController = TextEditingController();

  final ImagePicker picker = ImagePicker();
  File? profileImage;

  Future<void> uploadProfilePicture() async {
    try {
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        profileImage = File(pickedFile.path);
        emit(UploadImageSuccessState());
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
      emit(UploadImageErrorState());
    }
  }

  void clearProfileImage() {
    profileImage = null;
    emit(ClearImageSuccessState());
  }

  var nameCon = TextEditingController();
  var emailCon = TextEditingController();
  var phoneCon = TextEditingController();
  String phoneNumber = '';

  // In your EditProfileInfoCubit
void initDateControllers(ProfileModel profile) {
  nameCon.text = profile.data?.name ?? '';
  emailCon.text = profile.data?.email ?? '';
  phoneNumber = profile.data?.phone ?? '';
  descriptionCon.text = profile.data?.description ?? ''; // Add this line
  gender = profile.data?.gender; // Initialize gender from profile
  
  // Rest of the method remains the same
  String? phone = profile.data?.phone;
  if (phone != null && phone.length > 3) {
    phoneCon.text = phone.substring(3);
  } else {
    phoneCon.text = phone ?? '';
  }

  if (profile.data?.categoryId != null) {
    categoryController.text = profile.data!.categoryId!;
  }
}

// Add this method to clear country/city selection
  void clearCountryCitySelection() {
    categoryController.clear();
  }
  // dispose if needed
  void disposeControllers() {
    nameCon.dispose();
    emailCon.dispose();
    phoneCon.dispose();
    categoryController.dispose();
    
  
 
  descriptionCon.dispose(); // Add this line
  }

  // void initCountryCity({
  //   required CountriesModel? country,
  //   required Original? city,
  // }) {
  //   selectedCountry = country;
  //   selectedCity = city;
  // }


// In EditProfileInfoCubit
var descriptionCon = TextEditingController();
String? gender; // Add this line to store the selected gender

 

}
