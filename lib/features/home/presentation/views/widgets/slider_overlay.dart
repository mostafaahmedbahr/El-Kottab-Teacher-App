import 'dart:ui';
import '../../../../../main_imports.dart';

class SliderOverlay extends StatelessWidget {
  const SliderOverlay({super.key, required this.description});
  final String? description;
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
                  AppColors.darkOlive.withValues(alpha: 0.9),
                  AppColors.darkOlive.withValues(alpha: 0.3),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(description ??"", style: AppStyles.white12SemiBold),
                Gap(4.h),
                Text(
                  description ??"",
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
