// import '../../../../../main_importants.dart';
// import 'notification_item.dart';
//
// class NotificationsLoadingShimmer extends StatelessWidget {
//   const NotificationsLoadingShimmer({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.separated(
//       padding: EdgeInsets.all(16),
//       itemCount: 10,
//       separatorBuilder: (context, index) => verticalSpace(12),
//       itemBuilder: (context, index) {
//         return Shimmer.fromColors(
//           baseColor: Colors.grey[300]!,
//           highlightColor: Colors.grey[100]!,
//           child:  NotificationItem(
//             id: "1",
//             title: "title",
//             message: "message",
//             time: "time",
//             icon: Icons.rice_bowl,
//             onTap: () {
//
//             },
//           ),
//         );
//       },
//     );
//   }
// }