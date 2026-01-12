import '../../../../main_imports.dart';
import '../../data/models/all_messages_model.dart';
import '../../data/models/send_message_model.dart';
import '../../data/repos/chat_repo.dart';
import 'chat_states.dart';

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit(this.chatRepo) : super(ChatInitState());

  ChatRepo? chatRepo;

  static ChatCubit get(context) => BlocProvider.of(context);

  SendMessageModel? sendMessageModel;

  Future<void> sendMessage({
    required String message,
    required int teacherId,
  })
  async {
    emit(SendMessageLoadingState());
    var result = await chatRepo!.sendMessage(
      message: message,
      teacherId: teacherId,
    );
    return result.fold(
      (failure) {
        emit(SendMessageErrorState(failure.errMessage));
      },
      (data) async {
        sendMessageModel = data;
        emit(SendMessageSuccessState(data));
      },
    );
  }


  AllMessagesModel? allMessagesModel;
  Future<void> getAllMessages({
    required int userId , required int teacherId
  })
  async {
    emit(GetAllChatMessagesLoadingState());
    var result = await chatRepo!.getAllMessages(
      userId: userId,
      teacherId: teacherId,
    );
    return result.fold(
          (failure) {
        emit(GetAllChatMessagesErrorState(failure.errMessage));
      },
          (data) async {
            if(data.status==200){
              allMessagesModel = data;
              emit(GetAllChatMessagesSuccessState(data));
            }else{
              emit(GetAllChatMessagesErrorState(data.message.toString()));
            }

      },
    );
  }

  var messageCon = TextEditingController();
}
