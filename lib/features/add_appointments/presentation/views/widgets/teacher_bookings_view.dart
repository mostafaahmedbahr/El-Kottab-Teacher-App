import 'package:el_kottab_teacher_app/features/add_appointments/data/models/booking_model.dart';
import 'package:el_kottab_teacher_app/features/add_appointments/presentation/views/widgets/booking_card.dart';
import 'package:el_kottab_teacher_app/main_imports.dart';

class TeacherBookingsView extends StatefulWidget {
  const TeacherBookingsView({super.key});

  @override
  State<TeacherBookingsView> createState() => _TeacherBookingsViewState();
}

class _TeacherBookingsViewState extends State<TeacherBookingsView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<BookingModel> bookings = [
    BookingModel(
      studentName: "أحمد محمد",
      studentImage: "https://i.pravatar.cc/150?img=3",
      dateTime: DateTime.now().add(const Duration(days: 1)),
    ),
    BookingModel(
      studentName: "سارة علي",
      studentImage: "https://i.pravatar.cc/150?img=5",
      dateTime: DateTime.now().subtract(const Duration(days: 2)),
    ),
  ];

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    final upcoming = bookings.where((b) => b.dateTime.isAfter(now)).toList();

    final finished = bookings.where((b) => b.dateTime.isBefore(now)).toList();

    return Scaffold(
      appBar: AppBar(title: const Text("الحجوزات"), centerTitle: true),
      body: Column(
        children: [
          SizedBox(height: 12.h),

          /// Tabs
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: AppColors.darkOlive,
                borderRadius: BorderRadius.circular(12.r),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black87,
              tabs: const [
                Tab(text: "القادمة"),
                Tab(text: "المنتهية"),
              ],
            ),
          ),

          SizedBox(height: 16.h),

          /// Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildBookingsList(upcoming, isFinished: false),
                _buildBookingsList(finished, isFinished: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingsList(
    List<BookingModel> list, {
    required bool isFinished,
  }) {
    if (list.isEmpty) {
      return const Center(child: Text("لا توجد حجوزات"));
    }

    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemBuilder: (context, index) {
        final booking = list[index];

        return BookingCard(booking: booking, isFinished: isFinished);
      },
      separatorBuilder: (_, __) => SizedBox(height: 12.h),
      itemCount: list.length,
    );
  }
}
