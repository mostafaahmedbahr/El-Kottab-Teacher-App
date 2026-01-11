import 'package:el_kottab_teacher_app/features/register/data/models/categories_model.dart';
import 'package:el_kottab_teacher_app/features/register/presentation/view_model/register_states.dart';
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
  Future<void> register({
    required String name,
    required String email,
    required String phone,
    required String gender,
    // required File? image,
    required int categoryId,
    required String password,
    required String confirmPassword,
    required String country,
  }) async {
    emit(SignUpLoading());
    FormData formData = FormData.fromMap({
      "name": name,
      "email": email,
      "phone": phone,
      "gender": gender,
      "country": country,
      // "image": image != null
      //     ? await MultipartFile.fromFile(image.path, filename: image.path.split('/').last)
      //     : null,
      "role": "user",
      "password": password,
      "password_confirmation": password,
      "category_id": categoryId,
      'fcm_token': CacheHelper.getData(key: "fcmToken"),
    });
    final result = await registerRepo!.register(data: formData);
    return result.fold(
      (failure) {
        emit(SignUpError(failure.errMessage));
      },
      (data) async {
        registerModel = data;
        emit(SignUpSuccess(data));
        CacheHelper.saveData(key: "userEmail", value: email);
        // cacheUserInfo(
        //   token: "${data.data!.token}",
        //   phone: data.data!.phone.toString(),
        //   id:  data.data!.id!,
        //   email: "${data.data!.email}",
        // );
        // clearProfileImage();
        clearControllers();
      },
    );
  }

  clearControllers() {
    nameCon.clear();
    emailCon.clear();
    passCon.clear();
    confirmPassCon.clear();
    phoneCon.clear();
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
}
