import '../../../../main_imports.dart';
import '../../data/models/teacher_reviews_model.dart';
import '../../data/repos/reviews_repo.dart';
import 'reviews_states.dart';

class ReviewsCubit extends Cubit<ReviewsStates> {
  ReviewsCubit(this.reviewsRepo) : super(ReviewsInitState());

  ReviewsRepo? reviewsRepo;
  static ReviewsCubit get(context) => BlocProvider.of(context);

  int selectedFilter = 1;
  changeSelectedFilter(int newIndex)
  {
    selectedFilter = newIndex;
    emit(ChangeSelectedFilterState());
    getTeacherReviews(type: selectedFilter==1 ? "teacher" : "student");
  }


  TeacherReviewsModel? teacherReviewsModel;
  Future<void> getTeacherReviews({required String type})
  async {
    emit(GetTeacherReviewsLoadingState());
    var result = await reviewsRepo!.getTeacherReviews(type: type);
    return result.fold((failure) {
      emit(GetTeacherReviewsErrorState(failure.errMessage));
    }, (data) async {
      teacherReviewsModel = data;
      emit(GetTeacherReviewsSuccessState(data));
    });
  }



}