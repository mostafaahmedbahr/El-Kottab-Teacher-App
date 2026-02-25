
import '../../data/models/all_chats_model.dart';

abstract class AllChatsStates{}

class AllChatsInitState extends AllChatsStates{}

class GetAllChatsLoadingState extends AllChatsStates{}
class GetAllChatsErrorState extends AllChatsStates{
  final String error;
  GetAllChatsErrorState(this.error);

}
class GetAllChatsSuccessState extends AllChatsStates{
  final AllChatsModel allChatsModel;
  GetAllChatsSuccessState(this.allChatsModel);

}