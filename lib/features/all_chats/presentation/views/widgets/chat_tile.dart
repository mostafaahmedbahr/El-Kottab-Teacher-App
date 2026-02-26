import 'package:el_kottab_teacher_app/features/all_chats/data/models/all_chats_model.dart';
import 'package:el_kottab_teacher_app/features/chat/presentation/views/chat_view.dart';

import '../../../../../main_imports.dart';

class ChatTile extends StatelessWidget {
  final Data chat;
  const ChatTile({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:   EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      leading: Stack(
        children: [
          CustomNetWorkImage(
              height: 60.h,
              width: 60.w,
              imageUrl: chat.otherUser!.image!.toString(), raduis: 28.r),
          // if (chat.isOnline)
          //   Positioned(
          //     bottom: 0,
          //     right: 0,
          //     child: Container(
          //       width: 12,
          //       height: 12,
          //       decoration: BoxDecoration(
          //         color: Colors.green,
          //         border: Border.all(color: Colors.white, width: 2),
          //         borderRadius: BorderRadius.circular(6),
          //       ),
          //     ),
          //   ),
        ],
      ),
      title: Text(
        chat.otherUser!.name!,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: Colors.black87,
        ),
      ),
      subtitle: Text(
        chat.lastMessage!.message!,
        style: TextStyle(fontSize: 14, color: Colors.black54),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _formatTime(chat.lastMessage!.createdAt),
            style: TextStyle(fontSize: 12, color: Colors.black54),
          ),
          if (int.parse(chat.lastMessage!.isRead!) > 0) ...[
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.darkOlive,
                borderRadius: BorderRadius.circular(10),
              ),
              constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
              child: Text(
                int.parse(chat.lastMessage!.isRead!) > 99 ? '99+' : chat.lastMessage!.isRead!.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ],
      ),
      onTap: () {
        AppNav.customNavigator(context: context, screen: ChatView(
          studentId: chat.otherUser!.id,
          studentImage: chat.otherUser!.image!,
          studentName: chat.otherUser!.name,
        ));
      },
    );
  }

  String _formatTime(dynamic dateTime) {
    // لو dateTime String, حاول تحويله
    DateTime parsedDate;
    if (dateTime is String) {
      parsedDate = DateTime.parse(dateTime);
    } else if (dateTime is DateTime) {
      parsedDate = dateTime;
    } else {
      return ''; // لو مش String ولا DateTime
    }

    final now = DateTime.now();
    final difference = now.difference(parsedDate);

    if (difference.inDays > 0) {
      return '${parsedDate.day}/${parsedDate.month}/${parsedDate.year}';
    } else if (difference.inHours > 0) {
      return '${parsedDate.hour}:${parsedDate.minute.toString().padLeft(2, '0')}';
    } else {
      return '${difference.inMinutes} دقيقة';
    }
  }

}