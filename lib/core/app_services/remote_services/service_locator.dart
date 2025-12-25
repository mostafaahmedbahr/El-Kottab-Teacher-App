import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../../features/add_appointments/data/repos/add_appointments_repo_impl.dart';
import '../../../features/call_log/data/repos/call_logs_repo_impl.dart';
import '../../../features/change_password/data/repos/change_password_repo_imple.dart';
import '../../../features/forget_password/data/repos/forget_password_repo_impl.dart';
import '../../../features/home/data/repos/home_repo_impl.dart';
import '../../../features/login/data/repos/login_repo_impl.dart';
import '../../../features/notifications/data/repos/notifications_repo_imple.dart';
 import '../../../features/otp/data/repos/otp_repo_imple.dart';
import '../../../features/reviews/data/repos/reviews_repo_impl.dart';
import '../../../features/student_profile/data/repos/student_repo_impl.dart';
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
  getIt.registerSingleton<LoginRepoImpl>(LoginRepoImpl(
    getIt.get<ApiService>(),
  ));
  getIt.registerSingleton<OtpRepoImpl>(OtpRepoImpl(
    getIt.get<ApiService>(),
  ));
  getIt.registerSingleton<HomeRepoImpl>(HomeRepoImpl(
    getIt.get<ApiService>(),
  ));
  getIt.registerSingleton<StudentRepoImpl>(StudentRepoImpl(
    getIt.get<ApiService>(),
  ));
  getIt.registerSingleton<ChangePasswordRepoImpl>(ChangePasswordRepoImpl(
    getIt.get<ApiService>(),
  ));
  getIt.registerSingleton<ForgetPasswordRepoImpl>(ForgetPasswordRepoImpl(
    getIt.get<ApiService>(),
  ));
  getIt.registerSingleton<CallLogsRepoImpl>(CallLogsRepoImpl(
    getIt.get<ApiService>(),
  ));
  getIt.registerSingleton<ReviewsRepoImpl>(ReviewsRepoImpl(
    getIt.get<ApiService>(),
  ));
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