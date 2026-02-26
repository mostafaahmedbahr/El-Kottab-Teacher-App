import 'package:el_kottab_teacher_app/core/helpers/convert_date.dart';
import 'package:el_kottab_teacher_app/features/chat/presentation/views/chat_view.dart';
import 'package:el_kottab_teacher_app/main_imports.dart';
import 'call_type_indicator.dart';
import '../../../data/models/calls_model.dart';

class CallLogItem extends StatelessWidget {
  final Data callData;

  const CallLogItem({super.key, required this.callData});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFFFBFAF8),
      elevation: 2,
      shadowColor: Color(0xFF8CB982).withValues(alpha: 0.4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
        side: BorderSide(color: Color(0xFFE1E6E1)),
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16.r),
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Row(
            children: [
              CustomNetWorkImage(
                imageUrl: callData.user?.image ?? "",
                raduis: 50.r,
                height: 50.h,
                width: 50.w,
              ),
              Gap(16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            callData.user?.name ?? "Unknown",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF2F3E34),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        CallTypeIndicator(),
                      ],
                    ),
                    Gap(8.h),

                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 14,
                          color: Color(0xFF8BAF9C),
                        ),
                        Gap(4.w),
                        Text(
                          DateFormatterClass.toTimeAgo(callData.startedAt) ,
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Color(0xFF7A8A80),
                          ),
                        ),
                        Gap(16.w),
                        Icon(Icons.timer, size: 14.sp, color: Color(0xFF8BAF9C)),
                        Gap(4.w),
                        Text(
                          "${callData.durationMinutes ?? 0} دقيقة",
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Color(0xFF7A8A80),
                          ),
                        ),
                      ],
                    ),
                    Gap(4.h),

                    Row(
                      children: [
                        Icon(
                          Icons.call_made,
                          size: 14.sp,
                          color: _getStatusColor(callData.status),
                        ),
                        Gap(4.w),
                        Text(
                          _getStatusText(callData.status),
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: AppColors.gold,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Action Button
              IconButton(
                onPressed: () {
                  _showOptions(context);
                },
                icon: Icon(Icons.more_vert, color: Color(0xFF9EADA3)),
                splashRadius: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.info, color: Colors.blue),
                title: const Text('عرض التفاصيل'),
                onTap: () {
                  Navigator.pop(context);
                  _showCallDetails(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.message, color: Colors.purple),
                title: const Text('إرسال رسالة'),
                onTap: () {
                  AppNav.customNavigator(context: context, screen: ChatView(
                    studentName:callData.user?.name  ,
                    studentImage: callData.user?.image,
                    studentId: callData.user?.id,
                  ));
                  // Navigator.pop(context);
                  // Implement message logic
                },
              ),
              Gap(8.h),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('إلغاء'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showCallDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.white,
        title: Text('تفاصيل المكالمة'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('الطالب:', callData.user?.name ?? "Unknown"),
            _buildDetailRow('الوقت:', DateFormatterClass.toTimeAgo(callData.startedAt)),
            _buildDetailRow('المدة:', "${callData.durationMinutes ?? 0} دقيقة"),
            _buildDetailRow('الحالة:', _getStatusText(callData.status)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('حسنًا'),
          ),
        ],
      ),
    );
  }


  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          Gap(8.w),
          Expanded(
            child: Text(value, style: const TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status) {
      case 'completed':
        return Colors.green;
      case 'canceled':
        return Colors.red;
      case 'missed':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(String? status) {
    switch (status) {
      case 'completed':
        return 'مكتملة';
      case 'canceled':
        return 'ملغاة';
      case 'missed':
        return 'فائتة';
      default:
        return 'غير معروفة';
    }
  }
}
