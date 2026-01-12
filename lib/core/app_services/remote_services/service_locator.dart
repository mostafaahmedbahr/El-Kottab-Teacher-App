import 'package:dio/dio.dart';
import 'package:el_kottab_teacher_app/features/forget_password/data/repos/forget_password_repo.dart';
import 'package:el_kottab_teacher_app/features/login/data/repos/login_repo_imple.dart';
import 'package:el_kottab_teacher_app/features/profile/data/repos/profile_repo.dart';
import 'package:el_kottab_teacher_app/features/profile/data/repos/profile_repo_imple.dart';
import 'package:el_kottab_teacher_app/features/register/data/repos/register_repos.dart';
import 'package:el_kottab_teacher_app/features/register/data/repos/register_repos_imple.dart';
import 'package:el_kottab_teacher_app/features/settings/data/repos/settings_repo_impl.dart';
import 'package:get_it/get_it.dart';
import '../../../features/add_appointments/data/repos/add_appointments_repo_impl.dart';
import '../../../features/call_log/data/repos/call_logs_repo_impl.dart';
import '../../../features/change_password/data/repos/change_password_repo_imple.dart';
import '../../../features/chat/data/repos/chat_repo_imple.dart';
import '../../../features/contact_us/data/repos/contact_us_repo_impl.dart';
import '../../../features/forget_password/data/repos/forget_password_repo_impl.dart';
import '../../../features/home/data/repos/home_repo_impl.dart';

import '../../../features/notifications/data/repos/notifications_repo_imple.dart';
import '../../../features/otp/data/repos/otp_repo_imple.dart';
import '../../../features/reviews/data/repos/reviews_repo_impl.dart';
import '../../../features/student_profile/data/repos/student_repo_impl.dart';
import 'api_service.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<ApiService>(ApiService(Dio()));
  getIt.registerSingleton<AddAppointmentsRepoImpl>(
    AddAppointmentsRepoImpl(getIt.get<ApiService>()),
  );
  getIt.registerSingleton<NotificationsRepoImpl>(
    NotificationsRepoImpl(getIt.get<ApiService>()),
  );
  getIt.registerSingleton<LoginRepoImpl>(
    LoginRepoImpl(getIt.get<ApiService>()),
  );
  getIt.registerSingleton<OtpRepoImpl>(OtpRepoImpl(getIt.get<ApiService>()));
  getIt.registerSingleton<HomeRepoImpl>(HomeRepoImpl(getIt.get<ApiService>()));
  getIt.registerSingleton<StudentRepoImpl>(
    StudentRepoImpl(getIt.get<ApiService>()),
  );
  getIt.registerSingleton<ChangePasswordRepoImpl>(
    ChangePasswordRepoImpl(getIt.get<ApiService>()),
  );
  getIt.registerSingleton<ForgetPasswordRepoImpl>(
    ForgetPasswordRepoImpl(getIt.get<ApiService>()),
  );
  getIt.registerSingleton<CallLogsRepoImpl>(
    CallLogsRepoImpl(getIt.get<ApiService>()),
  );
  getIt.registerSingleton<ReviewsRepoImpl>(
    ReviewsRepoImpl(getIt.get<ApiService>()),
  );
  getIt.registerSingleton<ChatRepoImpl>(ChatRepoImpl(
    getIt.get<ApiService>(),
  ));
  getIt.registerSingleton<ContactUsRepoImpl>(ContactUsRepoImpl(
    getIt.get<ApiService>(),
  ));
  getIt.registerSingleton<ProfileRepoImpl>(
    ProfileRepoImpl(getIt.get<ApiService>()),
  );
  getIt.registerSingleton<SettingsRepoImpl>(
    SettingsRepoImpl(getIt.get<ApiService>()),
  );

  getIt.registerSingleton<RegisterRepoImpl>(
    RegisterRepoImpl(getIt.get<ApiService>()),
  );
}
