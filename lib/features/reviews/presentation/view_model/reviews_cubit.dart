import '../../../../main_imports.dart';
import '../../data/repos/reviews_repo.dart';
import 'reviews_states.dart';

class ReviewsCubit extends Cubit<ReviewsStates> {
  ReviewsCubit(this.reviewsRepo) : super(ReviewsInitState());

  ReviewsRepo? reviewsRepo;
  static ReviewsCubit get(context) => BlocProvider.of(context);

  int selectedFilter = 0;
  changeSelectedFilter(int newIndex)
  {
    selectedFilter = newIndex;
    emit(ChangeSelectedFilterState());
  }





}