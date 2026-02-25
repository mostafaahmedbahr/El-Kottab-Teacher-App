import 'package:el_kottab_teacher_app/core/app_services/remote_services/service_locator.dart';
import 'package:el_kottab_teacher_app/features/chat/data/repos/chat_repo_imple.dart';
import 'package:el_kottab_teacher_app/features/chat/presentation/view_model/chat_cubit.dart';
import 'package:el_kottab_teacher_app/features/chat/presentation/views/widgets/message_input.dart';
import 'package:el_kottab_teacher_app/features/chat/presentation/views/widgets/message_list.dart';
import '../../../../main_imports.dart';

class ChatView extends StatelessWidget {
  const ChatView({
    super.key,
    this.teacherName,
    this.teacherImage,
    this.teacherId,
  });
  final String? teacherName;
  final String? teacherImage;
  final int? teacherId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ChatCubit(getIt.get<ChatRepoImpl>())
            ..getAllMessages( teacherId: teacherId!),
      child: Scaffold(
        backgroundColor: const Color(0xffF5F7FA),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Row(
            children: [
              CustomNetWorkImage(
                imageUrl: teacherImage.toString(),
                height: 40.h,
                width: 40.w,
                raduis: 50,
              ),
              Gap(10.w),
              Text(teacherName.toString(), style: AppStyles.black16SemiBold),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(child: MessageList()),
            MessageInput(teacherId: teacherId!),
          ],
        ),
      ),
    );
  }
}
