import 'package:el_kottab_teacher_app/features/chat/data/models/chat_models.dart';
import 'package:el_kottab_teacher_app/features/chat/data/repos/chat_repo.dart';
import 'package:el_kottab_teacher_app/features/chat/presentation/view_model/chat_states.dart';
import '../../../../main_imports.dart';

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit(this.chatRepo) : super(ChatInitState());

  ChatRepo? chatRepo;

  static ChatCubit get(context) => BlocProvider.of(context);

  SendMessageModel? sendMessageModel;
  AllMessagesModel? allMessagesModel;

  var messageCon = TextEditingController();


  Future<void> sendMessage({
    required int teacherId,
  }) async {
    if (messageCon.text.trim().isEmpty) return;
    var result = await chatRepo!.sendMessage(
      message: messageCon.text,
      teacherId: teacherId,
    );
    result.fold(
      (failure) {
        emit(SendMessageErrorState(failure.errMessage));
      },
      (data) async {
        sendMessageModel = data;
        messageCon.clear();
        await getAllMessages(
          teacherId: teacherId,
          loading: false,
        );
        emit(SendMessageSuccessState(data));
      },
    );
  }

  Future<void> getAllMessages({
    required int teacherId,
    bool loading = true,
  }) async {
    if (loading) {
      emit(GetAllChatMessagesLoadingState());
    }
    var result = await chatRepo!.getAllMessages(
      userId: CacheHelper.getData(key: "userId"),
      teacherId: teacherId,
    );
    result.fold(
      (failure) {
        emit(GetAllChatMessagesErrorState(failure.errMessage));
      },
      (data) async {
        if (data.status == 200) {
          allMessagesModel = data;
          emit(GetAllChatMessagesSuccessState(data));
        } else {
          emit(GetAllChatMessagesErrorState(data.message.toString()));
        }
      },
    );
  }
}
