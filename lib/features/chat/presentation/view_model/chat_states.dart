import '../../data/models/all_messages_model.dart';
import '../../data/models/send_message_model.dart';

abstract class ChatStates{}

class ChatInitState extends ChatStates{}

class GetAllChatMessagesLoadingState extends ChatStates{}
class GetAllChatMessagesErrorState extends ChatStates{
  final String error;
  GetAllChatMessagesErrorState(this.error);

}
class GetAllChatMessagesSuccessState extends ChatStates{
  final AllMessagesModel allMessagesModel;
  GetAllChatMessagesSuccessState(this.allMessagesModel);

}



class SendMessageLoadingState extends ChatStates{}
class SendMessageErrorState extends ChatStates{
  final String error;
  SendMessageErrorState(this.error);

}
class SendMessageSuccessState extends ChatStates{
  final SendMessageModel sendMessageModel;
  SendMessageSuccessState(this.sendMessageModel);

}