import 'package:el_kottab_teacher_app/features/home/data/models/teacher_stats_model.dart';
import 'package:el_kottab_teacher_app/features/home/data/models/update_availability_model.dart';

import '../../../../main_imports.dart';
import '../../data/models/home_banners_model.dart';
import '../../data/models/successful_calls_model.dart';
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



  bool status = true;
  changeStatus(newStatus)
  {
    status = newStatus;
    emit(ChangeStatusState());
    updateAvailability(status: status ? "active": "inactive");
  }

  HomeBannersModel? homeBannersModel;
  Future<void> getHomeBanners()
  async {
    emit(GetHomeSliderLoadingState());
    var result = await homeRepo!.getHomeBanners();
    return result.fold((failure) {
      emit(GetHomeSliderErrorState(failure.errMessage));
    }, (data) async {
      homeBannersModel = data;
      emit(GetHomeSliderSuccessState(data));
    });
  }

  TeacherStatsModel? teacherStatsModel;
  Future<void> getTeacherStats({required int teacherId})
  async {
    emit(GetTeacherStatsLoadingState());
    var result = await homeRepo!.getTeacherStats(teacherId: teacherId);
    return result.fold((failure) {
      emit(GetTeacherStatsErrorState(failure.errMessage));
    }, (data) async {
      teacherStatsModel = data;
      emit(GetTeacherStatsSuccessState(data));
    });
  }


  UpdateAvailabilityModel? updateAvailabilityModel;
  Future<void> updateAvailability({required String status})
  async {
    emit(ChangeStatusLoadingState());
    var result = await homeRepo!.updateAvailability(status: status);
    return result.fold((failure) {
      emit(ChangeStatusErrorState(failure.errMessage));
    }, (data) async {
      updateAvailabilityModel = data;
      emit(ChangeStatusSuccessState(data));
    });
  }


  SuccessfulCallsModel? successfulCallsModel;

  Future<void> getSuccessfulCalls(    {  int? limit}) async {
    emit(GetSuccessfulCallsLoadingState());
    var result = await homeRepo!.getSuccessfulCalls(limit: limit);
    result.fold(
          (failure) {
        emit(GetSuccessfulCallsErrorState(failure.errMessage));
      },
          (data) {
            successfulCallsModel = data;
        emit(GetSuccessfulCallsSuccessState(data));
      },
    );
  }

}