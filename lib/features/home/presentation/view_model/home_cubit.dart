import '../../../../main_imports.dart';
import '../../data/repos/home_repo.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit(this.homeRepo) : super(HomeInitState());

  HomeRepo? homeRepo;
  static HomeCubit get(context) => BlocProvider.of(context);


  int currentSliderIndex = 0;
  changeHomeSliderImages(index)
  {
    currentSliderIndex = index;
    emit(ChangeHomeSliderImageState());
  }

   List<String> sliderImagesList = ["https://play-lh.googleusercontent.com/dwD9R3_pf-agihdKTYS95-YKV58l5L_Kor_QsMMpTmY6MrQQgi_Mc5qKAtIP1Ajycg" , "https://play-lh.googleusercontent.com/8s6h3OW1xSEghokWabjAvT4zuYjsJG5vi30SGhZLpgLfqsvIqXzPSy-5lECyfcUOi58"];








}