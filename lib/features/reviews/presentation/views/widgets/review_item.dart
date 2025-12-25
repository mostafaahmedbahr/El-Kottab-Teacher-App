import '../../../../../main_imports.dart';

class ReviewItem extends StatelessWidget {
  const ReviewItem({
    super.key,
    required this.name,
    required this.rating,
    required this.description,
    required this.date,
    required this.minutes,
    required this.lectureType,
  });

  final String name;
  final double rating;
  final String description;
  final String date;
  final int minutes;
  final String lectureType;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with avatar, name and rating
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.darkOlive,
                  child: Text(
                    name.isNotEmpty ? name[0].toUpperCase() : 'U',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                Gap(12.h),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: AppStyles.black16SemiBold,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Gap(4.h),
                      Row(
                        children: [
                          // Star rating
                          ...List.generate(5, (index) {
                            return Icon(
                              index < rating.floor()
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Colors.amber,
                              size: 16,
                            );
                          }),
                          Gap(4.h),
                          Text(
                            rating.toStringAsFixed(1),
                            style: AppStyles.black14Medium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Gap(12.h),

            // Description
            Text(
              description,
              style: AppStyles.black14Medium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            Gap(12.h),

            // Footer with date, minutes and lecture type
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Date
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 14.sp,
                      color: AppColors.gray,
                    ),
                    Gap(4.h),
                    Text(
                      date,
                      style: AppStyles.gray14Medium,
                    ),
                  ],
                ),

                // Minutes
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 14.sp,
                      color: AppColors.gray,
                    ),
                    Gap(4.h),
                    Text(
                      '$minutes دقيقة',
                      style: AppStyles.gray14Medium,
                    ),
                  ],
                ),

                // Lecture Type
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    lectureType,
                    style: AppStyles.primary14Medium,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}