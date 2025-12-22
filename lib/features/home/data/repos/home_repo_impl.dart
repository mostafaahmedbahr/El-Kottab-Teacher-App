import 'package:dartz/dartz.dart';
import '../../../../main_imports.dart';
 import '../models/home_banners_model.dart';
import 'home_repo.dart';


class HomeRepoImpl implements HomeRepo {
  final ApiService? apiService;
  HomeRepoImpl(this.apiService);


// @override
// Future<Either<Failure, HomeBannersModel>> getHomeBanners() async{
//   try {
//     var response = await apiService!.getData(
//       endPoint: EndPoints.banners,
//     );
//     HomeBannersModel result = HomeBannersModel.fromJson(response.data);
//     return right(result);
//   } catch (e) {
//     return left(handleError(e));
//   }
// }
//
//
//




}