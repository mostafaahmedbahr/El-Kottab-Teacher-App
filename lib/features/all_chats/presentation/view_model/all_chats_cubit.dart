 import '../../../../main_imports.dart';
import '../../data/models/all_chats_model.dart';
import '../../data/repos/all_chats_repo.dart';
import 'all_chats_states.dart';

class AllChatsCubit extends Cubit<AllChatsStates> {
  AllChatsCubit(this.allChatsRepo) : super(AllChatsInitState());

  AllChatsRepo? allChatsRepo;

  static AllChatsCubit get(context) => BlocProvider.of(context);

  AllChatsModel? allChatsModel;
  Future<void> getAllChats() async {
    emit(GetAllChatsLoadingState());
    var result = await allChatsRepo!.getAllChats();
    result.fold(
          (failure) {
        emit(GetAllChatsErrorState(failure.errMessage));
      },
          (data) async {
          allChatsModel = data;
          emit(GetAllChatsSuccessState(data));

      },
    );
  }



}
