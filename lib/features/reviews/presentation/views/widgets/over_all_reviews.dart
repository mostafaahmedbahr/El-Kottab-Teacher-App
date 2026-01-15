import 'package:el_kottab_teacher_app/features/reviews/presentation/view_model/reviews_cubit.dart';
import 'package:el_kottab_teacher_app/features/reviews/presentation/view_model/reviews_states.dart';
import 'package:el_kottab_teacher_app/features/reviews/presentation/views/widgets/review_item.dart';
import 'package:el_kottab_teacher_app/main_imports.dart';

class OverallReviews extends StatelessWidget {
  const OverallReviews({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewsCubit , ReviewsStates>(
      builder: (context,state){
        var reviewsCubit = context.read<ReviewsCubit>();
        return ListView.separated(
          padding: EdgeInsets.all(16.r),
          itemBuilder: (context, index) {
            final review = reviewsCubit.teacherReviewsModel!.data![index];
            return ReviewItem(
              name: review.user?.name?? "" ,
              rating: review.rate?? 0  ,
              description: review.comment??""
            );
          },
          separatorBuilder: (context, index) {
            return Gap(12.h);
          },
          itemCount: reviewsCubit.teacherReviewsModel!.data!.length,
        );
      },

    );
  }
}