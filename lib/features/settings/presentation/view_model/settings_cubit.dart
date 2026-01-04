import 'package:el_kottab_teacher_app/features/settings/data/models/delete_account_model.dart';
import 'package:el_kottab_teacher_app/features/settings/data/models/terms_and_conditions_model.dart';
import 'package:el_kottab_teacher_app/features/settings/data/models/who_we_are_model.dart';
import 'package:el_kottab_teacher_app/features/settings/presentation/view_model/settings_states.dart';

import '../../../../main_imports.dart';
import '../../data/repos/settings_repo.dart';

class SettingsCubit extends Cubit<SettingsStates> {
  SettingsCubit(this.settingsRepo) : super(SettingsInitState());

  SettingsRepo? settingsRepo;
  static SettingsCubit get(context) => BlocProvider.of(context);

  TermsAndConditionsModel? termsAndConditionsModel;
  Future<void> getTermsAndConditions() async {
    emit(GetTermsAndConditionsDataLoadingState());
    var result = await settingsRepo!.getTermsAndConditions();
    return result.fold(
      (failure) {
        emit(GetTermsAndConditionsDataErrorState(failure.errMessage));
      },
      (data) async {
        termsAndConditionsModel = data;
        emit(GetTermsAndConditionsDataSuccessState(data));
      },
    );
  }

  WhoWeAreModel? whoWeAreModel;
  Future<void> getWhoWeAre() async {
    emit(GetWhoWeAreDataLoadingState());
    var result = await settingsRepo!.getWhoWeAre();
    return result.fold(
      (failure) {
        emit(GetWhoWeAreDataErrorState(failure.errMessage));
      },
      (data) async {
        whoWeAreModel = data;
        emit(GetWhoWeAreDataSuccessState(data));
      },
    );
  }

  DeleteAccountModel? deleteAccountModel;
  Future<void> deleteAccount() async {
    emit(DeleteAccountLoadingState());
    var result = await settingsRepo!.deleteAccount();
    return result.fold(
      (failure) {
        emit(DeleteAccountErrorState(failure.errMessage));
      },
      (data) async {
        deleteAccountModel = data;
        emit(DeleteAccountSuccessState(data));
      },
    );
  }
}
