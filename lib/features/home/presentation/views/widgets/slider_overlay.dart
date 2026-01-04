import 'dart:ui';
import '../../../../../main_imports.dart';

class SliderOverlay extends StatelessWidget {
  const SliderOverlay();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  AppColors.darkOlive.withOpacity(0.9),
                  AppColors.darkOlive.withOpacity(0.3),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Read the Quran', style: AppStyles.white12SemiBold),
                const SizedBox(height: 4),
                Text(
                  'تابع تلاوة القرآن الكريم',
                  style: AppStyles.white12SemiBold,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
