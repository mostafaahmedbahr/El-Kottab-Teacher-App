import 'package:el_kottab_teacher_app/core/app_services/remote_services/service_locator.dart';
import 'package:el_kottab_teacher_app/core/errors/error_ui.dart';
import 'package:el_kottab_teacher_app/core/shared_widgets/empty_widget.dart';
import 'package:el_kottab_teacher_app/features/reviews/data/repos/reviews_repo_impl.dart';
import 'package:el_kottab_teacher_app/features/reviews/presentation/view_model/reviews_cubit.dart';
import 'package:el_kottab_teacher_app/features/reviews/presentation/view_model/reviews_states.dart';
import 'package:el_kottab_teacher_app/features/reviews/presentation/views/widgets/over_all_reviews.dart';
import 'package:el_kottab_teacher_app/features/reviews/presentation/views/widgets/reviews_filter_buttons.dart';
import 'package:el_kottab_teacher_app/features/reviews/presentation/views/widgets/students_reviews.dart';
import '../../../../main_imports.dart';

class ReviewsView extends StatelessWidget {
  const ReviewsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context)=>ReviewsCubit(getIt.get<ReviewsRepoImpl>())..getTeacherReviews(type: "teacher"),
        child: BlocBuilder<ReviewsCubit , ReviewsStates>(
          builder: (context,state){
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                child: Column(
                  children: [
                    ReviewsFilterButtons(),
                    Gap(12.h),
                    Expanded(
                      child:
                      state is GetTeacherReviewsLoadingState ? CustomLoading():
                          state is GetTeacherReviewsErrorState ? ErrorUi(errorState: state.error.toString(), onPressed: (){
                            context.read<ReviewsCubit>().getTeacherReviews(type: "teacher");
                          }):
                          context.read<ReviewsCubit>().teacherReviewsModel!.data!.isEmpty && state is GetTeacherReviewsSuccessState?
                        EmptyWidget(msg: LangKeys.noReviewsYet) :
                      context.read<ReviewsCubit>().selectedFilter==1?
                      OverallReviews()
                          :  StudentsReviews(),
                    ),

                  ],
                ),
              ),
            );
          },

        ),
      ),
    );
  }




}