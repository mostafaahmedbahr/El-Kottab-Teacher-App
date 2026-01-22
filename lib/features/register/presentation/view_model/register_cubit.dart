// import 'dart:io';

// import 'package:el_kottab_teacher_app/features/register/data/models/categories_model.dart';
// import 'package:el_kottab_teacher_app/features/register/presentation/view_model/register_states.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:image_picker/image_picker.dart';
// import '../../../../core/utils/enums.dart';
// import '../../../../main_imports.dart';
// import '../../data/models/register_model.dart';
// import '../../data/repos/register_repos.dart';

// class RegisterCubit extends Cubit<RegisterStates> {
//   RegisterCubit(this.registerRepo) : super(RegisterInitState());

//   RegisterRepo? registerRepo;
//   static RegisterCubit get(context) => BlocProvider.of(context);

//   bool isVisible = true;

//   void changeSuffixIcon() {
//     isVisible = !isVisible;
//     emit(ChangeSuffixIconState());
//   }

//   String phoneNumber = '';
//   String countryCode = '';
//   String countryName = 'Egypt';
//   bool isVisible2 = true;

//   void changeSuffixIcon2() {
//     isVisible2 = !isVisible2;
//     emit(ChangeSuffixIconState2());
//   }

//   var nameCon = TextEditingController();
//   var emailCon = TextEditingController();
//   var webSiteUrlCon = TextEditingController();
//   var passCon = TextEditingController();
//   var confirmPassCon = TextEditingController();
//   var phoneCon = TextEditingController();

//   RegisterModel? registerModel;
//   Future<void> register()
//   async {
//     emit(SignUpLoading());
//     FormData formData = FormData.fromMap({
//       "name": nameCon.text,
//       "email": emailCon.text,
//       "phone": phoneNumber,
//       "gender": gender,
//       "country": countryName,
//       "image": personalPhoto != null
//           ? await MultipartFile.fromFile(personalPhoto!.path, filename: personalPhoto!.path.split('/').last)
//           : null,
//       "role": "teacher",
//       "password": passCon.text,
//       "password_confirmation":  confirmPassCon.text,
//       "category_id": categoryId,
//       'fcm_token': CacheHelper.getData(key: "fcmToken"),
//       // "attachments[0]" : attachments,
//       "cv_file" : cvFile != null
//           ? await MultipartFile.fromFile(cvFile!.path, filename: cvFile!.path.split('/').last)
//           : null,
//       "kyc_front" : idFront != null
//           ? await MultipartFile.fromFile(idFront!.path, filename: idFront!.path.split('/').last)
//           : null,
//       "kyc_back" : idBack != null
//           ? await MultipartFile.fromFile(idBack!.path, filename: idBack!.path.split('/').last)
//           : null
//     });
//     final result = await registerRepo!.register(data: formData);
//     return result.fold(
//       (failure) {
//         emit(SignUpError(failure.errMessage));
//       },
//       (data) async {
//         registerModel = data;
//         emit(SignUpSuccess(data));
//         clearControllers();
//       },
//     );
//   }

//   clearControllers() {
//     nameCon.clear();
//     emailCon.clear();
//     passCon.clear();
//     confirmPassCon.clear();
//     phoneCon.clear();
//     gender=null;
//     phoneNumber='';
//     selectedCategory=null;
//     idBack=null;
//     idFront=null;
//     cvFile=null;
//     personalPhoto=null;
//     emit(RegisterInitState());
//   }

//   cacheUserInfo({
//     required String token,
//     required String phone,
//     required int id,
//     required String email,
//   }) async {
//     await CacheTokenManger.saveUserToken(token);
//     CacheHelper.saveData(key: "userPhone", value: phone);
//     CacheHelper.saveData(key: "userId", value: id);
//     CacheHelper.saveData(key: "userEmail", value: email);
//   }

//   String? gender;

//   void selectGender(String newGender) {
//     gender = newGender;
//     emit(SelectGenderState());
//   }

//   CategoriesModel? categoriesModel;
//   List<CategoryData> categories = [];
//   CategoryData? selectedCategory;
//   int? categoryId;
//   Future<void> getAllCategories() async {
//     emit(GetAllCategoriesLoadingState());
//     final result = await registerRepo!.getAllCategories();
//     result.fold(
//       (failure) {
//         emit(GetAllCategoriesErrorState(failure.errMessage));
//       },
//       (data) {
//         categoriesModel = data;
//         categories = data.data ?? [];
//         emit(GetAllCategoriesSuccessState(data));
//       },
//     );
//   }

//   void selectCategory(CategoryData category) {
//     selectedCategory = category;
//     categoryId = category.id;
//     emit(CategorySelectedState());
//   }

//   File? personalPhoto;
//   File? cvFile;
//   File? idFront;
//   File? idBack;
//   String? get personalPhotoPath => personalPhoto?.path;
//   String? get cvPath => cvFile?.path;
//   String? get idFrontPath => idFront?.path;
//   String? get idBackPath => idBack?.path;

//   Future<void> pickRegisterFile(RegisterFileType type) async {
//     final picker = ImagePicker();
//     XFile? pickedFile;
//     if (type == RegisterFileType.cv) {
//       // ملفات PDF / DOC
//       final result = await FilePicker.platform.pickFiles(
//         type: FileType.custom,
//         allowedExtensions: ['pdf', 'doc', 'docx'],
//       );
//       if (result != null) {
//         cvFile = File(result.files.single.path!);
//       }
//     } else {
//       // صور
//       pickedFile = await picker.pickImage(source: ImageSource.gallery);
//       if (pickedFile != null) {
//         final file = File(pickedFile.path);
//         switch (type) {
//           case RegisterFileType.personalPhoto:
//             personalPhoto = file;
//             break;
//           case RegisterFileType.idFront:
//             idFront = file;
//             break;
//           case RegisterFileType.idBack:
//             idBack = file;
//             break;
//           default:
//             break;
//         }
//       }
//     }

//     emit(RegisterPickFileState());
//   }

//   final FocusNode nameFocusNode = FocusNode();
//   final FocusNode emailFocusNode = FocusNode();
//   final FocusNode passwordFocusNode = FocusNode();
//   final FocusNode confirmPasswordFocusNode = FocusNode();

// }
import 'dart:io';

import 'package:el_kottab_teacher_app/features/register/data/models/categories_model.dart';
import 'package:el_kottab_teacher_app/features/register/presentation/view_model/register_states.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/utils/enums.dart';
import '../../../../main_imports.dart';
import '../../data/models/register_model.dart';
import '../../data/repos/register_repos.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit(this.registerRepo) : super(RegisterInitState());

  RegisterRepo? registerRepo;
  static RegisterCubit get(context) => BlocProvider.of(context);

  bool isVisible = true;

  void changeSuffixIcon() {
    isVisible = !isVisible;
    emit(ChangeSuffixIconState());
  }

  String phoneNumber = '';
  String countryCode = '';
  String countryName = 'Egypt';
  bool isVisible2 = true;

  void changeSuffixIcon2() {
    isVisible2 = !isVisible2;
    emit(ChangeSuffixIconState2());
  }

  var nameCon = TextEditingController();
  var emailCon = TextEditingController();
  var webSiteUrlCon = TextEditingController();
  var passCon = TextEditingController();
  var confirmPassCon = TextEditingController();
  var phoneCon = TextEditingController();

  RegisterModel? registerModel;

  Future<void> register() async {
    emit(SignUpLoading());

    try {
      FormData formData = FormData.fromMap({
        "name": nameCon.text,
        "email": emailCon.text,
        "phone": phoneNumber,
        "gender": gender,
        "country": countryName,
        "image": personalPhoto != null
            ? await MultipartFile.fromFile(
                personalPhoto!.path,
                filename: personalPhoto!.path.split('/').last,
              )
            : null,
        "role": "teacher",
        "password": passCon.text,
        "password_confirmation": confirmPassCon.text,
        "category_id": categoryId,
        'fcm_token': CacheHelper.getData(key: "fcmToken"),
        "cv_file": cvFile != null
            ? await MultipartFile.fromFile(
                cvFile!.path,
                filename: cvFile!.path.split('/').last,
              )
            : null,
        "kyc_front": idFront != null
            ? await MultipartFile.fromFile(
                idFront!.path,
                filename: idFront!.path.split('/').last,
              )
            : null,
        "kyc_back": idBack != null
            ? await MultipartFile.fromFile(
                idBack!.path,
                filename: idBack!.path.split('/').last,
              )
            : null,
      });

      final result = await registerRepo!.register(data: formData);

      result.fold(
        (failure) {
          emit(SignUpError(failure.errMessage));
        },
        (data) async {
          registerModel = data;
          emit(SignUpSuccess(data));
          clearControllers();
        },
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.receiveTimeout) {
        emit(
          SignUpError("السيرفر بياخد وقت طويل للرد. حاول مرة تانية لاحقًا."),
        );
      } else if (e.type == DioExceptionType.connectionTimeout) {
        emit(
          SignUpError("فشل الاتصال بالسيرفر. تحقق من الإنترنت وحاول مرة أخرى."),
        );
      } else {
        emit(SignUpError("حدث خطأ غير متوقع. حاول مرة أخرى."));
      }
    } catch (e) {
      emit(SignUpError("حدث خطأ ما: $e"));
    }
  }

  clearControllers() {
    nameCon.clear();
    emailCon.clear();
    passCon.clear();
    confirmPassCon.clear();
    phoneCon.clear();
    gender = null;
    phoneNumber = '';
    selectedCategory = null;
    idBack = null;
    idFront = null;
    cvFile = null;
    personalPhoto = null;
    emit(RegisterInitState());
  }

  cacheUserInfo({
    required String token,
    required String phone,
    required int id,
    required String email,
  }) async {
    await CacheTokenManger.saveUserToken(token);
    CacheHelper.saveData(key: "userPhone", value: phone);
    CacheHelper.saveData(key: "userId", value: id);
    CacheHelper.saveData(key: "userEmail", value: email);
  }

  String? gender;

  void selectGender(String newGender) {
    gender = newGender;
    emit(SelectGenderState());
  }

  CategoriesModel? categoriesModel;
  List<CategoryData> categories = [];
  CategoryData? selectedCategory;
  int? categoryId;

  Future<void> getAllCategories() async {
    emit(GetAllCategoriesLoadingState());
    final result = await registerRepo!.getAllCategories();
    result.fold(
      (failure) {
        emit(GetAllCategoriesErrorState(failure.errMessage));
      },
      (data) {
        categoriesModel = data;
        categories = data.data ?? [];
        emit(GetAllCategoriesSuccessState(data));
      },
    );
  }

  void selectCategory(CategoryData category) {
    selectedCategory = category;
    categoryId = category.id;
    emit(CategorySelectedState());
  }

  File? personalPhoto;
  File? cvFile;
  File? idFront;
  File? idBack;
  String? get personalPhotoPath => personalPhoto?.path;
  String? get cvPath => cvFile?.path;
  String? get idFrontPath => idFront?.path;
  String? get idBackPath => idBack?.path;

  Future<void> pickRegisterFile(RegisterFileType type) async {
    final picker = ImagePicker();
    XFile? pickedFile;

    if (type == RegisterFileType.cv) {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
      );
      if (result != null) {
        cvFile = File(result.files.single.path!);
      }
    } else {
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final file = File(pickedFile.path);
        switch (type) {
          case RegisterFileType.personalPhoto:
            personalPhoto = file;
            break;
          case RegisterFileType.idFront:
            idFront = file;
            break;
          case RegisterFileType.idBack:
            idBack = file;
            break;
          default:
            break;
        }
      }
    }

    emit(RegisterPickFileState());
  }

  final FocusNode nameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();
}
