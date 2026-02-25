import 'package:easy_localization/easy_localization.dart';
import 'package:el_kottab_teacher_app/features/all_chats/presentation/views/widgets/chat_tile.dart';
import 'package:el_kottab_teacher_app/features/all_chats/presentation/views/widgets/empty_chats.dart';

import '../../../../core/app_services/remote_services/service_locator.dart';
import '../../../../core/shared_widgets/custom_error_widget.dart';
import '../../../../main_imports.dart';
import '../../data/repos/all_chats_repo_impl.dart';
import '../view_model/all_chats_cubit.dart';
import '../view_model/all_chats_states.dart';

class AllChatsView extends StatelessWidget {
  const AllChatsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(   LangKeys.allChats.tr(),)),
      body: BlocProvider(
        create: (context)=>AllChatsCubit(getIt.get<AllChatsRepoImpl>())..getAllChats(),
        child: BlocBuilder<AllChatsCubit, AllChatsStates>(
          buildWhen: (previous, current){
            return current is GetAllChatsSuccessState ||
            current is GetAllChatsErrorState ||
            current is GetAllChatsLoadingState;
          },
          builder: (context, state) {
            if (state is GetAllChatsLoadingState) {
              return CustomLoading();
            }

            if (state is GetAllChatsErrorState) {
              return CustomErrorWidget(onTap: (){
                context.read<AllChatsCubit>().getAllChats();
              }, errorMsg: LangKeys.anErrorOccurredInLoadingTheConversations.tr(),
              );
            }

            if (state is GetAllChatsSuccessState) {
              final chats = state.allChatsModel.data;

              if (chats!.isEmpty) {
                return EmptyChats();
              }

              return RefreshIndicator(
                onRefresh: () async {
                  await context.read<AllChatsCubit>().getAllChats();
                },
                color: AppColors.darkOlive,
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: chats.length,
                  separatorBuilder: (context, index) =>
                        Divider(height: 1, color: Colors.grey[300]!),
                  itemBuilder: (context, index) {
                    final chat = chats[index];
                    return ChatTile(chat: chat);
                  },
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }


}


