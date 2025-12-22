import '../../../../../main_imports.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(PngImages.logo,height: 200.h,width: 200.w,fit: BoxFit.cover,);
  }
}