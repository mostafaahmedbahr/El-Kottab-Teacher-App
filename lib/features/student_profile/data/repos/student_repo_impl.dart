import 'package:el_kottab_teacher_app/features/student_profile/data/repos/student_repo.dart';
import '../../../../main_imports.dart';



class StudentRepoImpl implements StudentRepo {
  final ApiService? apiService;
  StudentRepoImpl(this.apiService);


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