import 'package:el_kottab_teacher_app/features/chat/presentation/views/widgets/message_input.dart';
import 'package:el_kottab_teacher_app/features/chat/presentation/views/widgets/message_list.dart';

import '../../../../core/app_services/remote_services/service_locator.dart';
import '../../../../main_imports.dart';
import '../../data/repos/chat_repo_imple.dart';
import '../view_model/chat_cubit.dart';

class  ChatView extends StatelessWidget {
  const  ChatView({super.key,   this.teacherName, this.teacherImage ,this.teacherId, this.userId});
  final String? teacherName;
  final String? teacherImage;
  final int? teacherId;
  final int? userId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> ChatCubit(getIt.get<ChatRepoImpl>())..getAllMessages(userId: userId!, teacherId: teacherId!),
      child: Scaffold(
        backgroundColor: const Color(0xffF5F7FA),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Row(
            children: [
              CustomNetWorkImage(
                imageUrl:teacherImage.toString(),
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
            MessageInput(teacherId: teacherId!,),
          ],
        ),
      ),
    );
  }




}