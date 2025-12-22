import '../../../../core/app_services/remote_services/api_service.dart';
import 'add_appointments_repo.dart';


class AddAppointmentsRepoImpl implements AddAppointmentsRepo {
  final ApiService? apiService;
  AddAppointmentsRepoImpl(this.apiService);




// @override
// Future<Either<Failure, TryThisProductsModel>> getTryThisProductsData() async{
//   try {
//     var response = await apiService!.getData(
//       endPoint: EndPoints.mostSellingProducts,
//     );
//     TryThisProductsModel result = TryThisProductsModel.fromJson(response.data);
//     return right(result);
//   } catch (e) {
//     return left(handleError(e));
//   }
// }








}