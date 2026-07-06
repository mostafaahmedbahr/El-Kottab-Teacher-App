import 'package:el_kottab_teacher_app/core/app_services/remote_services/service_locator.dart';
import 'package:el_kottab_teacher_app/features/chat/data/repos/chat_repo_imple.dart';
import 'package:el_kottab_teacher_app/features/chat/presentation/view_model/chat_cubit.dart';
import 'package:el_kottab_teacher_app/features/chat/presentation/views/widgets/message_input.dart';
import 'package:el_kottab_teacher_app/features/chat/presentation/views/widgets/message_list.dart';
import '../../../../main_imports.dart';

class ChatView extends StatelessWidget {
  const ChatView({
    super.key,
    this.studentName,
    this.studentImage,
    this.studentId,
  });
  final String? studentName;
  final String? studentImage;
  final int? studentId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ChatCubit(getIt.get<ChatRepoImpl>())
            ..getAllMessages(teacherId: studentId!),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              title: Row(
                children: [
                  CustomNetWorkImage(
                    imageUrl: studentImage.toString(),
                    height: 40.h,
                    width: 40.w,
                    raduis: 50,
                  ),
                  Gap(10.w),
                  Text(
                    studentName.toString(),
                    style: AppStyles.black16SemiBold,
                  ),
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(child: MessageList()),
                if (context.watch<ChatCubit>().allMessagesModel?.data?.isNotEmpty ?? false)
                  MessageInput(teacherId: studentId!),
              ],
            ),
          );
        },
      ),
    );
  }
}
