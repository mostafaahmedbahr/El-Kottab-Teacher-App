import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../../features/add_appointments/data/repos/add_appointments_repo_impl.dart';
import '../../../features/notifications/data/repos/notifications_repo_imple.dart';
import 'api_service.dart';


final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<ApiService>(ApiService(Dio()));
  getIt.registerSingleton<AddAppointmentsRepoImpl>(AddAppointmentsRepoImpl(
    getIt.get<ApiService>(),
  ));
  getIt.registerSingleton<NotificationsRepoImpl>(NotificationsRepoImpl(
    getIt.get<ApiService>(),
  ));
  // getIt.registerSingleton<OtpRepoImpl>(OtpRepoImpl(
  //   getIt.get<ApiService>(),
  // ));
  // getIt.registerSingleton<NotificationsRepoImpl>(NotificationsRepoImpl(
  //   getIt.get<ApiService>(),
  // ));
  // getIt.registerSingleton<HomeRepoImpl>(HomeRepoImpl(
  //   getIt.get<ApiService>(),
  // ));
  // getIt.registerSingleton<TeachersRepoImpl>(TeachersRepoImpl(
  //   getIt.get<ApiService>(),
  // ));
  // getIt.registerSingleton<TeacherDetailsRepoImpl>(TeacherDetailsRepoImpl(
  //   getIt.get<ApiService>(),
  // ));
  // getIt.registerSingleton<SessionsRepoImpl>(SessionsRepoImpl(
  //   getIt.get<ApiService>(),
  // ));
  // getIt.registerSingleton<ProfileRepoImpl>(ProfileRepoImpl(
  //   getIt.get<ApiService>(),
  // ));
  // getIt.registerSingleton<BalanceRepoImpl>(BalanceRepoImpl(
  //   getIt.get<ApiService>(),
  // ));
  // getIt.registerSingleton<FreeLearningRepoImpl>(FreeLearningRepoImpl(
  //   getIt.get<ApiService>(),
  // ));
  // getIt.registerSingleton<PackagesRepoImpl>(PackagesRepoImpl(
  //   getIt.get<ApiService>(),
  // ));
  // getIt.registerSingleton<ChatRepoImpl>(ChatRepoImpl(
  //   getIt.get<ApiService>(),
  // ));

}