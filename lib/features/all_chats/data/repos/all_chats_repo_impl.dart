import 'package:dartz/dartz.dart';
import '../../../../main_imports.dart';
import '../models/all_chats_model.dart';
import 'all_chats_repo.dart';

class AllChatsRepoImpl implements AllChatsRepo {
  final ApiService? apiService;

  AllChatsRepoImpl(this.apiService);

  @override
  Future<Either<Failure, AllChatsModel>> getAllChats() async {
    try {
      var response = await apiService!.getData(
        endPoint: EndPoints.chats,
      );
      AllChatsModel result = AllChatsModel.fromJson(
        response.data,
      );
      return right(result);
    } catch (e) {
      return left(handleError(e));
    }
  }


}
