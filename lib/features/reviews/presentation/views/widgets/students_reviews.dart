import 'package:el_kottab_teacher_app/features/reviews/presentation/views/widgets/review_item.dart';
import 'package:el_kottab_teacher_app/main_imports.dart';

class StudentsReviews extends StatelessWidget {
  const StudentsReviews({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> reviews = [
      {
        'name': 'أحمد محمد',
        'rating': 4.5,
        'description': 'مادة ممتازة والشرح واضح جداً، أنصح جميع الطلاب بحضور هذه المحاضرة',
        'date': '15 يناير 2024',
        'minutes': 45,
        'lectureType': 'محاضرة نظرية',
      },
      {
        'name': 'سارة خالد',
        'rating': 5.0,
        'description': 'أفضل مدرس واجهته في مسيرتي الدراسية، شرحه مبسط وسهل الفهم',
        'date': '14 يناير 2024',
        'minutes': 60,
        'lectureType': 'محاضرة عملية',
      },
      {
        'name': 'محمد علي',
        'rating': 4.0,
        'description': 'المحتوى غني ومفيد، لكن التوقيت كان متأخراً قليلاً',
        'date': '13 يناير 2024',
        'minutes': 50,
        'lectureType': 'ورشة عمل',
      },
      {
        'name': 'فاطمة حسن',
        'rating': 3.5,
        'description': 'جيدة ولكن تحتاج لبعض التحسينات في طريقة العرض',
        'date': '12 يناير 2024',
        'minutes': 40,
        'lectureType': 'ندوة',
      },
      {
        'name': 'عمر سعيد',
        'rating': 4.8,
        'description': 'رائع جداً، المعلومات دقيقة والشرح مفصّل',
        'date': '11 يناير 2024',
        'minutes': 55,
        'lectureType': 'محاضرة نظرية',
      },
      {
        'name': 'نورة عبدالله',
        'rating': 4.2,
        'description': 'مفيدة جداً، خاصة الأمثلة التطبيقية',
        'date': '10 يناير 2024',
        'minutes': 48,
        'lectureType': 'تمارين',
      },
      {
        'name': 'خالد فوزي',
        'rating': 4.7,
        'description': 'المدرس متميز في إيصال المعلومة',
        'date': '9 يناير 2024',
        'minutes': 52,
        'lectureType': 'محاضرة عملية',
      },
      {
        'name': 'ريم أحمد',
        'rating': 3.8,
        'description': 'جيدة ولكن الوقت كان قصيراً للموضوع',
        'date': '8 يناير 2024',
        'minutes': 35,
        'lectureType': 'محاضرة نظرية',
      },
      {
        'name': 'ياسر كمال',
        'rating': 4.9,
        'description': 'ممتازة بكل المقاييس، أنتظر المزيد من هذه المحاضرات',
        'date': '7 يناير 2024',
        'minutes': 65,
        'lectureType': 'ندوة',
      },
      {
        'name': 'لينا محمود',
        'rating': 4.3,
        'description': 'شرح واضح ومنظم، استفدت كثيراً',
        'date': '6 يناير 2024',
        'minutes': 42,
        'lectureType': 'ورشة عمل',
      },
    ];

    return ListView.separated(
      padding: EdgeInsets.all(16.r),
      itemBuilder: (context, index) {
        final review = reviews[index];
        return ReviewItem(
          name: review['name'] as String,
          rating: review['rating'] as double,
          description: review['description'] as String,
          date: review['date'] as String,
          minutes: review['minutes'] as int,
          lectureType: review['lectureType'] as String,
        );
      },
      separatorBuilder: (context, index) {
        return Gap(12.h);
      },
      itemCount: reviews.length,
    );
  }
}