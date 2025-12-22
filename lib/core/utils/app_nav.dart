

import '../../main_imports.dart';

class AppNav
{
  static customNavigator({
    @required context,
    @required screen,
    bool finish = false,
  })
  {
    finish?
    Navigator.pushAndRemoveUntil(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        child: screen,
      ),
          (Route<dynamic> route) => false,
    ): Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        child: screen,
      ),

    );
  }



}