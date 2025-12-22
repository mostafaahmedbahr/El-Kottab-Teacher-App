import '../../../../main_imports.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  SplashViewState createState() => SplashViewState();
}

class SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.bounceOut);

    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        final String? userToken = CacheTokenManger.userToken;
        // if ( userToken != null && userToken.isNotEmpty) {
        //   AppNav.customNavigator(
        //     context: context,
        //     screen: const LayoutView(),
        //   );
        // } else {
        //   AppNav.customNavigator(
        //     context: context,
        //     screen: const LoginView(),
        //   );
        // }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(CacheTokenManger.userToken);
    debugPrint("SplashView");
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.darkOlive, AppColors.white],
            stops: [0.0, 0.7],
          ),
        ),
        child: ScaleTransition(
          scale: _animation,
          child: Center(child: Image.asset(PngImages.logo)),
        ),
      ),
    );
  }
}
