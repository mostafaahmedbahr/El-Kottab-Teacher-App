import 'package:easy_localization/easy_localization.dart';

import '../../../../../main_imports.dart';
import '../../view_model/chat_cubit.dart';
import '../../view_model/chat_states.dart';

class MessageInput extends StatelessWidget {
  const MessageInput({super.key, required this.teacherId});
  final int teacherId;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit , ChatStates>(
      listener: (context , state){
        if(state is SendMessageSuccessState){
          Toast.showSuccessToast(msg: state.sendMessageModel.message.toString(), context: context);
           context.read<ChatCubit>().messageCon.clear();
        }
        else if(state is SendMessageErrorState){
          Toast.showErrorToast(msg: state.error.toString(), context: context);
        }
      } ,
      builder:  (context , state){
        var chatCubit = context.read<ChatCubit>();
        return  Container(
          padding:   EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6.r,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            children: [
              // IconButton(
              //   onPressed: () {},
              //   icon: const Icon(Icons.emoji_emotions_outlined),
              //   color: Colors.grey[700],
              // ),
              Expanded(
                child: Container(
                  padding:   EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: const Color(0xffF0F2F5),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child:   TextField(
                    controller: chatCubit.messageCon,
                    decoration: InputDecoration(
                      hintText: LangKeys.typeMessage.tr(),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),

              // Gap(8.w),
              //
              // CircleAvatar(
              //   radius: 22.r,
              //   backgroundColor: Color(0xffE8ECF1),
              //   child: Icon(Icons.attach_file, color: Colors.black87),
              // ),
              Gap(8.w),

              InkWell(
                radius: 22.r,
                onTap: (){
                  if(chatCubit.messageCon.text.isNotEmpty){
                    chatCubit.sendMessage(message: chatCubit.messageCon.text, teacherId: teacherId);
                  }

                },
                child: CircleAvatar(
                  radius: 22.r,
                  backgroundColor: AppColors.darkOlive,
                  child: Icon(Icons.send, color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },


    );
  }
}