import 'package:el_kottab_teacher_app/core/shared_widgets/empty_widget.dart';
import 'package:el_kottab_teacher_app/features/chat/presentation/view_model/chat_cubit.dart';
import 'package:el_kottab_teacher_app/features/chat/presentation/view_model/chat_states.dart';
import 'package:el_kottab_teacher_app/features/chat/presentation/views/widgets/right_message_by_me.dart';
import '../../../../../main_imports.dart';
import 'left_message_from_student.dart';

class MessageList extends StatelessWidget {
  const MessageList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatStates>(
      builder: (context, state) {
        final chatCubit = context.watch<ChatCubit>();
        final messages = chatCubit.allMessagesModel?.data ?? [];

        if (state is GetAllChatMessagesLoadingState && messages.isEmpty) {
          return const CustomLoading();
        }

        if (state is GetAllChatMessagesErrorState) {
          return Center(
            child: Text(state.error, style: AppStyles.black16SemiBold),
          );
        }

        if (messages.isEmpty) {
          return EmptyWidget(msg: LangKeys.noMessagesFound);
        }

        return Padding(
          padding: EdgeInsets.all(12.0.r),
          child: ListView.separated(
            itemCount: messages.length,
            separatorBuilder: (_, __) => Gap(12.h),
            itemBuilder: (context, index) {
              final message = messages[index];
              return message.senderRole == "teacher"
                  ? RightMessageByMe(
                      date: message.createdAt.toString(),
                      message: message.message.toString(),
                    )
                  : LeftMessageFromStudent(
                      date: message.createdAt.toString(),
                      message: message.message.toString(),
                    );
            },
          ),
        );
      },
    );
  }
}
