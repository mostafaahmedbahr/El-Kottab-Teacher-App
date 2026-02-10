import 'package:el_kottab_teacher_app/main_imports.dart';
import 'call_type_indicator.dart';
import '../../../data/models/calls_model.dart';
import '../../view_models/call_logs_cubit.dart';
import '../../view_models/call_logs_states.dart';

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
                        const SizedBox(width: 4),
                        Text(
                          callData.startedAt ?? "",
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF7A8A80),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Icon(Icons.timer, size: 14, color: Color(0xFF8BAF9C)),
                        const SizedBox(width: 4),
                        Text(
                          "${callData.durationMinutes ?? 0} دقيقة",
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF7A8A80),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),

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
                            fontSize: 13,
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
                leading: const Icon(Icons.edit, color: Colors.orange),
                title: const Text('مراجعة المكالمة'),
                onTap: () {
                  Navigator.pop(context);
                  _showRevisionDialog(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.call, color: Colors.green),
                title: const Text('الاتصال مرة أخرى'),
                onTap: () {
                  Navigator.pop(context);
                  // Implement call back logic
                },
              ),
              ListTile(
                leading: const Icon(Icons.message, color: Colors.purple),
                title: const Text('إرسال رسالة'),
                onTap: () {
                  Navigator.pop(context);
                  // Implement message logic
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text('حذف السجل'),
                onTap: () {
                  Navigator.pop(context);
                  _showDeleteConfirmation(context);
                },
              ),
              const SizedBox(height: 8),
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
        title: Text('تفاصيل المكالمة'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('الطالب:', callData.user?.name ?? "Unknown"),
            _buildDetailRow('الوقت:', callData.startedAt ?? ""),
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

  void _showRevisionDialog(BuildContext context) {
    final TextEditingController revisionController = TextEditingController();
    final cubit = context.read<CallLogsCubit>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('مراجعة المكالمة'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('أضف ملاحظاتك حول هذه المكالمة:'),
            const SizedBox(height: 16),
            TextField(
              controller: revisionController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'اكتب ملاحظاتك هنا...',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          BlocListener<CallLogsCubit, CallLogsStates>(
            listener: (context, state) {
              if (state is AddRevisionSuccessState) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('تم حفظ المراجعة بنجاح'),
                    backgroundColor: Colors.green,
                  ),
                );
              } else if (state is AddRevisionErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('خطأ: ${state.error}'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: ElevatedButton(
              onPressed: () {
                if (revisionController.text.isNotEmpty) {
                  cubit.addCallRevision(callData.id!, revisionController.text);
                }
              },
              child: const Text('حفظ المراجعة'),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('حذف سجل المكالمة'),
        content: const Text(
          'هل أنت متأكد من حذف هذا السجل؟ لا يمكن التراجع عن هذا الإجراء.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('تم حذف سجل المكالمة'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('حذف'),
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
          const SizedBox(width: 8),
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
