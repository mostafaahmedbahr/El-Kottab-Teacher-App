import '../../../../main_imports.dart';
import 'reviews_repo.dart';


class ReviewsRepoImpl implements ReviewsRepo {
  final ApiService? apiService;
  ReviewsRepoImpl(this.apiService);


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