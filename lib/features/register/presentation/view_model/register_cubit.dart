import 'dart:io';
import 'package:el_kottab_teacher_app/features/register/data/models/categories_model.dart';
import 'package:el_kottab_teacher_app/features/register/data/models/register_model.dart';
import 'package:el_kottab_teacher_app/features/register/data/repos/register_repos.dart';
import 'package:el_kottab_teacher_app/features/register/presentation/view_model/register_states.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/utils/enums.dart';
import '../../../../main_imports.dart';
import 'package:dio/dio.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit(this.registerRepo) : super(RegisterInitState());

  RegisterRepo? registerRepo;
  static RegisterCubit get(context) => BlocProvider.of(context);

  /// ==== Password visibility ====
  bool isVisible = true;
  bool isVisible2 = true;

  void changeSuffixIcon() {
    isVisible = !isVisible;
    emit(ChangeSuffixIconState());
  }

  void changeSuffixIcon2() {
    isVisible2 = !isVisible2;
    emit(ChangeSuffixIconState2());
  }

  /// ==== Controllers ====
  var nameCon = TextEditingController();
  var emailCon = TextEditingController();
  var webSiteUrlCon = TextEditingController();
  var passCon = TextEditingController();
  var confirmPassCon = TextEditingController();
  var phoneCon = TextEditingController();

  /// ==== FocusNodes ====
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();

  /// ==== User Data ====
  String phoneNumber = '';
  String countryCode = '';
  String countryName = 'Egypt';
  String? gender;

  void selectGender(String newGender) {
    gender = newGender;
    emit(SelectGenderState());
  }

  CategoriesModel? categoriesModel;
  List<CategoryData> categories = [];
  CategoryData? selectedCategory;
  int? categoryId;

  void selectCategory(CategoryData category) {
    selectedCategory = category;
    categoryId = category.id;
    emit(CategorySelectedState());
  }

  /// ==== Files ====
  File? personalPhoto;
  File? cvFile;
  File? idFront;
  File? idBack;
  File? qualificationFile;
  File? degreePath;

  String? get personalPhotoPath => personalPhoto?.path;
  String? get cvPath => cvFile?.path;
  String? get idFrontPath => idFront?.path;
  String? get idBackPath => idBack?.path;
  String? get qualificationPath => qualificationFile?.path;
  String? get degree => degreePath?.path;

  /// ==== Pick files / images ====
  Future<void> pickRegisterFile(RegisterFileType type) async {
    final picker = ImagePicker();

    if (type == RegisterFileType.cv ||
        type == RegisterFileType.qualification ||
        type == RegisterFileType.degreePath) {
      // ملفات PDF / DOC
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
      );

      if (result != null && result.files.single.path != null) {
        final file = File(result.files.single.path!);
        switch (type) {
          case RegisterFileType.cv:
            cvFile = file;
            break;
          case RegisterFileType.qualification:
            qualificationFile = file;
            break;
          case RegisterFileType.degreePath:
            degreePath = file;
            break;
          default:
            break;
        }
      }
    } else {
      // صور
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
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

  /// ==== Get categories ====
  Future<void> getAllCategories() async {
    emit(GetAllCategoriesLoadingState());
    final result = await registerRepo!.getAllCategories();

    result.fold(
      (failure) => emit(GetAllCategoriesErrorState(failure.errMessage)),
      (data) {
        categoriesModel = data;
        categories = data.data ?? [];
        emit(GetAllCategoriesSuccessState(data));
      },
    );
  }

  /// ==== Registration ====
  RegisterModel? registerModel;

  Future<void> register() async {
    emit(SignUpLoading());

    try {
      Map<String, dynamic> dataMap = {
        "name": nameCon.text,
        "email": emailCon.text,
        "phone": phoneNumber,
        "gender": gender,
        "country": countryName,
        "role": "teacher",
        "password": passCon.text,
        "password_confirmation": confirmPassCon.text,
        "category_id": categoryId,
        'fcm_token': CacheHelper.getData(key: "fcmToken"),
      };

      if (personalPhoto != null && await personalPhoto!.exists()) {
        dataMap["image"] = await MultipartFile.fromFile(
          personalPhoto!.path,
          filename: personalPhoto!.path.split('/').last,
        );
      }
      if (cvFile != null && await cvFile!.exists()) {
        dataMap["cv_file"] = await MultipartFile.fromFile(
          cvFile!.path,
          filename: cvFile!.path.split('/').last,
        );
      }
      if (idFront != null && await idFront!.exists()) {
        dataMap["kyc_front"] = await MultipartFile.fromFile(
          idFront!.path,
          filename: idFront!.path.split('/').last,
        );
      }
      if (idBack != null && await idBack!.exists()) {
        dataMap["kyc_back"] = await MultipartFile.fromFile(
          idBack!.path,
          filename: idBack!.path.split('/').last,
        );
      }
      if (qualificationFile != null && await qualificationFile!.exists()) {
        dataMap["attachments[0]"] = await MultipartFile.fromFile(
          qualificationFile!.path,
          filename: qualificationFile!.path.split('/').last,
        );
      }
      if (degreePath != null && await degreePath!.exists()) {
        dataMap["attachments[1]"] = await MultipartFile.fromFile(
          degreePath!.path,
          filename: degreePath!.path.split('/').last,
        );
      }

      FormData formData = FormData.fromMap(dataMap);

      final result = await registerRepo!.register(data: formData);

      result.fold((failure) => emit(SignUpError(failure.errMessage)), (
        data,
      ) async {
        registerModel = data;
        emit(SignUpSuccess(data));
        CacheHelper.saveData(key: "userEmail", value:  emailCon.text);
        clearControllers();
      });
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

  /// ==== Clear controllers ====
  void clearControllers() {
    nameCon.clear();
    emailCon.clear();
    passCon.clear();
    confirmPassCon.clear();
    phoneCon.clear();
    gender = null;
    phoneNumber = '';
    selectedCategory = null;
    categoryId = null;
    idBack = null;
    idFront = null;
    cvFile = null;
    personalPhoto = null;
    qualificationFile = null;
    degreePath = null;
    emit(RegisterInitState());
  }

  /// ==== Cache user info ====
  Future<void> cacheUserInfo({
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
}
