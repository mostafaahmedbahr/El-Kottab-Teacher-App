import 'package:easy_localization/easy_localization.dart';
import 'package:el_kottab_teacher_app/core/app_services/remote_services/service_locator.dart';
import 'package:el_kottab_teacher_app/core/shared_cubits/auth_cubit/auth_cubit.dart';
import 'package:el_kottab_teacher_app/features/add_appointments/presentation/view_model/add_appointments_cubit.dart';

import 'package:el_kottab_teacher_app/features/forget_password/presentation/view_model/forget_password_cubit.dart';
import 'package:el_kottab_teacher_app/features/layout/presentation/view_model/layout_cubit.dart';
import 'package:el_kottab_teacher_app/features/profile/data/repos/profile_repo_imple.dart';
import 'package:el_kottab_teacher_app/features/register/presentation/view_model/register_cubit.dart';
import 'package:el_kottab_teacher_app/features/settings/data/repos/settings_repo_impl.dart';
import 'package:el_kottab_teacher_app/features/settings/presentation/view_model/settings_cubit.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'core/shared_cubits/lang_cubit/lang_cubit.dart';
import 'features/add_appointments/data/repos/add_appointments_repo_impl.dart';
import 'features/forget_password/data/repos/forget_password_repo_impl.dart';
import 'features/notifications/data/repos/notifications_repo_imple.dart';
import 'features/notifications/presentation/view_model/notifications_cubit.dart';
import 'features/profile/presentation/view_model/profile_cubit.dart';
import 'features/register/data/repos/register_repos_imple.dart';
import 'features/splash/presentation/views/splash_view.dart';
import 'main_imports.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
        ),
        child: Builder(
          builder: (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => AuthCubit()),
                BlocProvider(create: (context) => LanguageCubit()),
                BlocProvider(create: (context) => LayoutCubit()),
                BlocProvider(
                  create: (context) =>
                      ForgetPasswordCubit(getIt<ForgetPasswordRepoImpl>()),
                ),
                BlocProvider(
                  create: (context) => SettingsCubit(getIt<SettingsRepoImpl>())
                    ..getWhoWeAre()
                    ..getTermsAndConditions(),
                ),
                BlocProvider(
                  create: (context) =>
                      RegisterCubit(getIt<RegisterRepoImpl>())
                        ..getAllCategories(),
                ),
                BlocProvider(
                  create: (context) => ProfileCubit(getIt<ProfileRepoImpl>()),
                ),
                BlocProvider(
                  create: (context) =>
                      NotificationsCubit(getIt.get<NotificationsRepoImpl>()),
                ),
                BlocProvider(
                  create: (context) =>
                      AddAppointmentsCubit(getIt.get<AddAppointmentsRepoImpl>())
                        ..getAllSchedules(),
                ),
              ],
              child: BlocBuilder<LanguageCubit, Locale>(
                builder: (context, locale) {
                  context.setLocale(locale);
                  return MaterialApp(
                    navigatorKey: navigatorKey,
                    localizationsDelegates: context.localizationDelegates,
                    supportedLocales: context.supportedLocales,
                    locale: context.locale,
                    debugShowCheckedModeBanner: false,
                    title: "El Kottab",
                    theme: ThemeData(
                      fontFamily: locale.languageCode == 'ar'
                          ? "Cairo"
                          : "RobotoCondensed",
                      scaffoldBackgroundColor: AppColors.white,
                      appBarTheme: const AppBarTheme(
                        scrolledUnderElevation: 0,
                        backgroundColor: AppColors.white,
                      ),
                      primarySwatch: Colors.blue,
                      bottomNavigationBarTheme:
                          const BottomNavigationBarThemeData(
                            backgroundColor: AppColors.white,
                          ),
                    ),
                    home: const SplashView(),
                    builder: (context, child) {
                      SystemChrome.setSystemUIOverlayStyle(
                        const SystemUiOverlayStyle(
                          systemNavigationBarColor: AppColors.white,
                          systemNavigationBarIconBrightness: Brightness.dark,
                        ),
                      );
                      return ResponsiveBreakpoints.builder(
                        child: child!,
                        breakpoints: const [
                          Breakpoint(start: 0, end: 450, name: MOBILE),
                          Breakpoint(start: 451, end: 800, name: TABLET),
                          Breakpoint(start: 801, end: 1920, name: DESKTOP),
                          Breakpoint(
                            start: 1921,
                            end: double.infinity,
                            name: '4K',
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
