import 'package:dartz/dartz.dart';
import 'package:el_kottab_teacher_app/features/register/data/repos/register_repos.dart';
import '../../../../main_imports.dart';
import '../models/categories_model.dart';
import '../models/register_model.dart';

class RegisterRepoImpl implements RegisterRepo {
  final ApiService? apiService;
  RegisterRepoImpl(this.apiService);

  @override
  Future<Either<Failure, RegisterModel>> register({
    required FormData data,
  }) async {
    try {
      final response = await apiService!.postData(
        endPoint: EndPoints.register,
        data: data,
        isMultipart: true,
      );
      final result = RegisterModel.fromJson(response.data);
      return right(result);
    } catch (e) {
      return left(handleError(e));
    }
  }

  @override
  Future<Either<Failure, CategoriesModel>> getAllCategories() async {
    try {
      final response = await apiService!.getData(
        endPoint: EndPoints.categories,
      );
      final result = CategoriesModel.fromJson(response.data);
      return right(result);
    } catch (e) {
      return left(handleError(e));
    }
  }
}
