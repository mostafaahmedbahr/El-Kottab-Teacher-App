import '../../../../core/app_services/remote_services/api_service.dart';
 import 'call_logs_repo.dart';


class CallLogsRepoImpl implements CallLogsRepo {
  final ApiService? apiService;
  CallLogsRepoImpl(this.apiService);




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