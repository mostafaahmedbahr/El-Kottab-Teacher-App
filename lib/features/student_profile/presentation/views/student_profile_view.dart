import 'package:el_kottab_teacher_app/main_imports.dart';
import '../../../../core/shared_widgets/global_app_bar.dart';

class StudentProfileView extends StatefulWidget {
  final String personId;
  final String personName;
  final String personImage;

  const StudentProfileView({
    super.key,
    required this.personId,
    required this.personName,
    required this.personImage,
  });

  @override
  State<StudentProfileView> createState() => _StudentProfileViewState();
}

class _StudentProfileViewState extends State<StudentProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppBar(
        title: widget.personName,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Fixed Info Section
            _buildPersonInfoSection(),

            // Action Buttons (Block & Report)
            _buildActionButtons(),

            // Sessions History List
            _buildSessionsHistory(),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonInfoSection() {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey[300]!),
        ),
      ),
      child: Column(
        children: [
          // Profile Image
          Container(
            width: 100.w,
            height: 100.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.darkOlive, width: 3),
            ),
            child: ClipOval(
              child: Image.network(
                widget.personImage,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.person,
                    size: 50.sp,
                    color: Colors.grey[400],
                  );
                },
              ),
            ),
          ),
          Gap(16.h),

          // Name
          Text(
            widget.personName,
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          Gap(8.h),

          // Stats Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatItem(
                title: 'المكالمات',
                value: '24',
                icon: Icons.call,
              ),
              _buildStatItem(
                title: 'إجمالي الوقت',
                value: '18 ساعة',
                icon: Icons.timer,
              ),
              _buildStatItem(
                title: 'آخر مكالمة',
                value: 'أمس',
                icon: Icons.calendar_today,
              ),
            ],
          ),
          Gap(12.h),

          // Additional Info
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: Colors.blue, size: 20.sp),
                Gap(8.w),
                Expanded(
                  child: Text(
                    'مدرس منذ: يناير 2024 | معدل الحضور: 96%',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({required String title, required String value, required IconData icon}) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: AppColors.darkOlive.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 20.sp, color: AppColors.darkOlive),
        ),
        Gap(4.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 11.sp,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: EdgeInsets.all(16.r),
      child: Row(
        children: [
          // Block Button
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () => _showBlockConfirmationDialog(),
              icon: Icon(Icons.block, size: 20.sp),
              label: Text('حظر'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ),
          Gap(12.w),

          // Report Button
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () {
                // Navigate to report page or show dialog
                _showReportOptions();
              },
              icon: Icon(Icons.report, size: 20.sp),
              label: Text('بلاغ'),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.orange),
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSessionsHistory() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'سجل المحاضرات',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
          Gap(8.h),

          // Sessions List
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _sessions.length,
            separatorBuilder: (context, index) => Divider(height: 0),
            itemBuilder: (context, index) {
              return _buildSessionItem(_sessions[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSessionItem(Session session) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.grey[200]!),
      ),
      margin: EdgeInsets.only(bottom: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Date and Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 16.sp, color: Colors.grey[500]),
                  Gap(4.w),
                  Text(
                    session.date,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: _getStatusColor(session.status).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  session.status,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: _getStatusColor(session.status),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          Gap(8.h),

          // Session Profile
          Row(
            children: [
              // Session Type/Name
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      session.sessionName,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                      ),
                    ),
                    Gap(4.h),
                    Text(
                      session.type,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),

              // Duration and Time
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Icon(Icons.timer, size: 14.sp, color: Colors.grey[500]),
                      Gap(4.w),
                      Text(
                        session.duration,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                  Gap(4.h),
                  Text(
                    session.time,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Recording Info (if exists)
          if (session.recordingUrl != null) ...[
            Gap(8.h),
            Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Row(
                children: [
                  Icon(Icons.videocam, size: 16.sp, color: Colors.blue),
                  Gap(8.w),
                  Expanded(
                    child: Text(
                      'متاح تسجيل الجلسة',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Play recording
                    },
                    icon: Icon(Icons.play_arrow, size: 20.sp, color: Colors.blue),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'مكتملة':
        return Colors.green;
      case 'ملغاة':
        return Colors.red;
      case 'مجدولة':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  void _showBlockConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('تأكيد الحظر'),
        content: Text('هل أنت متأكد من حظر ${widget.personName}؟\n\nلن يتمكن من التواصل معك بعد الحظر.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _blockUser();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: Text('حظر'),
          ),
        ],
      ),
    );
  }

  void _blockUser() {
    // Implement block logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('تم حظر ${widget.personName} بنجاح'),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showReportOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(16.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'إرسال بلاغ عن ${widget.personName}',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
            ),
            Gap(16.h),
            ..._reportReasons.map((reason) {
              return ListTile(
                leading: Icon(Icons.report, color: Colors.orange),
                title: Text(reason),
                onTap: () {
                  Navigator.pop(context);
                  _submitReport(reason);
                },
              );
            }).toList(),
            Gap(8.h),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('إلغاء'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitReport(String reason) {
    // Implement report submission
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('تم إرسال البلاغ بنجاح'),
        backgroundColor: Colors.green,
      ),
    );
  }

  // Sample data
  final List<Session> _sessions = [
    Session(
      date: 'الثلاثاء، 15 مارس 2024',
      sessionName: 'محاضرة الرياضيات المتقدمة',
      type: 'جلسة فردية',
      duration: '60 دقيقة',
      time: '10:00 ص - 11:00 ص',
      status: 'مكتملة',
      recordingUrl: 'https://example.com/recording1',
    ),
    Session(
      date: 'الإثنين، 14 مارس 2024',
      sessionName: 'مراجعة الفيزياء',
      type: 'جلسة جماعية',
      duration: '90 دقيقة',
      time: '02:00 م - 03:30 م',
      status: 'مكتملة',
    ),
    Session(
      date: 'الأحد، 13 مارس 2024',
      sessionName: 'شرح الكيمياء العضوية',
      type: 'جلسة فردية',
      duration: '45 دقيقة',
      time: '04:00 م - 04:45 م',
      status: 'ملغاة',
    ),
    Session(
      date: 'السبت، 12 مارس 2024',
      sessionName: 'تدريب على المسائل',
      type: 'جلسة تدريبية',
      duration: '120 دقيقة',
      time: '11:00 ص - 01:00 م',
      status: 'مكتملة',
      recordingUrl: 'https://example.com/recording2',
    ),
  ];

  final List<String> _reportReasons = [
    'سلوك غير لائق',
    'محتوى غير مناسب',
    'عدم الالتزام بالوقت',
    'مشاكل تقنية متكررة',
    'أخرى',
  ];
}

class Session {
  final String date;
  final String sessionName;
  final String type;
  final String duration;
  final String time;
  final String status;
  final String? recordingUrl;

  Session({
    required this.date,
    required this.sessionName,
    required this.type,
    required this.duration,
    required this.time,
    required this.status,
    this.recordingUrl,
  });
}