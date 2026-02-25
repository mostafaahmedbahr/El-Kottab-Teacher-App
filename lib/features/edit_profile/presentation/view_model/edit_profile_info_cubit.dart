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

  /// Repository
  final EditProfileInfoRepo? editProfileInfoRepo;

  /// Cubit Getter
  static EditProfileInfoCubit get(context) => BlocProvider.of(context);

  /// Models
  EditProfileInfoModel? editProfileInfoModel;

  /// Controllers
  final TextEditingController nameCon = TextEditingController();
  final TextEditingController emailCon = TextEditingController();
  final TextEditingController phoneCon = TextEditingController();
  final TextEditingController descriptionCon = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  String phoneNumber = '';
  String? gender;

  /// Image Picker
  final ImagePicker picker = ImagePicker();
  File? profileImage;

  // ================== Methods ==================

  /// Edit Profile Info
  Future<void> editProfileInfoData({
    required String? name,
    required String? email,
    required String? phoneNumber,
    required String? gender,
    required File? image,
    required String? description,
  }) async {
    emit(EditProfileInfoLoadingState());

    FormData formData = FormData();

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
    if (image != null) {
      formData.files.add(
        MapEntry(
          'image',
          await MultipartFile.fromFile(
            image.path,
            filename: image.path.split('/').last,
          ),
        ),
      );
    }

    var result = await editProfileInfoRepo!.editProfileInfoData(data: formData);

    result.fold(
      (failure) => emit(EditProfileInfoErrorState(failure.errMessage)),
      (data) {
        editProfileInfoModel = data;
        emit(EditProfileInfoSuccessState(data));
      },
    );
  }

  /// Upload Profile Picture
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

  /// Clear Profile Image
  void clearProfileImage() {
    profileImage = null;
    emit(ClearImageSuccessState());
  }

  /// Initialize Controllers with Profile Data
  void initDateControllers(ProfileModel profile) {
    nameCon.text = profile.data?.name ?? '';
    emailCon.text = profile.data?.email ?? '';
    descriptionCon.text = profile.data?.description ?? '';
    gender = profile.data?.gender;

    String? phone = profile.data?.phone;
    if (phone != null && phone.length > 3) {
      phoneCon.text = phone.substring(3);
    } else {
      phoneCon.text = phone ?? '';
    }

    phoneNumber = profile.data?.phone ?? '';

    if (profile.data?.categoryId != null) {
      categoryController.text = profile.data!.categoryId!;
    }
  }

  /// Clear Category / Selection
  void clearCountryCitySelection() {
    categoryController.clear();
  }

  /// Dispose Controllers
  void disposeControllers() {
    nameCon.dispose();
    emailCon.dispose();
    phoneCon.dispose();
    descriptionCon.dispose();
    categoryController.dispose();
  }
}
