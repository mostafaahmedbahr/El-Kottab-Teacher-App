import 'package:el_kottab_teacher_app/features/call_log/presentation/models/call_log_model.dart';
import 'package:el_kottab_teacher_app/features/call_log/presentation/view_models/call_log_view_model.dart';
import 'package:flutter/material.dart';

class CallLogItem extends StatelessWidget {
  final CallLogModel call;
  final CallLogViewModel viewModel;

  const CallLogItem({super.key, required this.call, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          // Handle call log tap - show details
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Profile Avatar
              _buildAvatar(),
              const SizedBox(width: 16),

              // Call Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            call.studentName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        _buildCallTypeIndicator(),
                      ],
                    ),
                    const SizedBox(height: 8),

                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 14,
                          color: Colors.grey[500],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          viewModel.formatDate(call.callTime),
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Icon(
                          Icons.timer,
                          size: 14,
                          color: Colors.grey[500],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          viewModel.formatDuration(call.callDuration),
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),

                    Row(
                      children: [
                        Icon(
                          call.isOutgoing ? Icons.call_made : Icons.call_received,
                          size: 14,
                          color: _getStatusColor(call.status),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _getStatusText(call.status),
                          style: TextStyle(
                            fontSize: 13,
                            color: _getStatusColor(call.status),
                            fontWeight: FontWeight.w500,
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
                  // Show more options
                  _showOptions(context);
                },
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.grey[500],
                ),
                splashRadius: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Stack(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: _getStatusColor(call.status).withOpacity(0.3),
              width: 2,
            ),
          ),
          child: ClipOval(
            child: Image.network(
              call.studentImage,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[200],
                  child: const Icon(
                    Icons.person,
                    size: 28,
                    color: Colors.grey,
                  ),
                );
              },
            ),
          ),
        ),
        // Online/Status Indicator
        if (call.status == CallStatus.completed)
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildCallTypeIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getStatusColor(call.status).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        call.isOutgoing ? 'صادر' : 'وارد',
        style: TextStyle(
          fontSize: 11,
          color: _getStatusColor(call.status),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Color _getStatusColor(CallStatus status) {
    switch (status) {
      case CallStatus.completed:
        return Colors.green;
      case CallStatus.canceled:
        return Colors.orange;
      case CallStatus.missed:
        return Colors.red;
    }
  }

  String _getStatusText(CallStatus status) {
    switch (status) {
      case CallStatus.completed:
        return 'مكتملة';
      case CallStatus.canceled:
        return 'ملغاة';
      case CallStatus.missed:
        return 'فائتة';
    }
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
        title: Text('تفاصيل المكالمة - ${call.studentName}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('الوقت:', viewModel.formatDate(call.callTime)),
            _buildDetailRow('المدة:', viewModel.formatDuration(call.callDuration)),
            _buildDetailRow('النوع:', call.isOutgoing ? 'صادر' : 'وارد'),
            _buildDetailRow('الحالة:', _getStatusText(call.status)),
            // if (call.note != null && call.note!.isNotEmpty)
            //   _buildDetailRow('ملاحظة:', call.note!),
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
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.grey),
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
        content: const Text('هل أنت متأكد من حذف هذا السجل؟ لا يمكن التراجع عن هذا الإجراء.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Implement delete logic
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('تم حذف سجل مكالمة ${call.studentName}'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('حذف'),
          ),
        ],
      ),
    );
  }
}