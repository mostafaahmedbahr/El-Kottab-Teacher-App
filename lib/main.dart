import 'package:easy_localization/easy_localization.dart';
import 'core/app_services/remote_services/service_locator.dart';
import 'core/utils/bloc_observer.dart';
import 'lang/codegen_loader.g.dart';
import 'main_imports.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String? token = await CacheTokenManger.getUserToken();
  debugPrint("Retrieved token: $token");
  await CacheHelper.init();
  await EasyLocalization.ensureInitialized();
  setup();
  Bloc.observer = MyBlocObserver();
  runApp(EasyLocalization(
    startLocale: const Locale('en',""),
    supportedLocales: const [
      Locale('ar',""),
      Locale('en',""),
    ],
    path: 'lib/lang',
    saveLocale: true,
    fallbackLocale: const Locale('en',""),
    useOnlyLangCode: true,
    assetLoader: const CodegenLoader(),
    child: MyApp(),
  ),);
}
//last