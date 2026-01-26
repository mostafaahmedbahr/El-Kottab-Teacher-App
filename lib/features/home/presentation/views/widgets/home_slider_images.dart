import 'package:carousel_slider/carousel_slider.dart';
import 'package:el_kottab_teacher_app/features/home/presentation/views/widgets/slider_overlay.dart';
import '../../../../../main_imports.dart';
import '../../view_model/home_cubit.dart';
import '../../view_model/home_states.dart';
import 'home_slider_images_loading.dart';

class HomeSliderImages extends StatelessWidget {
  final bool isFullHeight;
  const HomeSliderImages({super.key, this.isFullHeight = false});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      buildWhen: (previous, current) {
        return current is ChangeHomeSliderImageState ||
            current is GetHomeSliderSuccessState ||
            current is GetHomeSliderLoadingState ||
            current is GetHomeSliderErrorState;
      },
      builder: (context, state) {
        var homeCubit = context.read<HomeCubit>();
        return state is GetHomeSliderLoadingState ||
                homeCubit.homeBannersModel == null ||
                homeCubit.homeBannersModel!.data == null ||
                homeCubit.homeBannersModel!.data!.isEmpty
            ? const HomeSliderImagesLoading()
            : CarouselSlider(
                items: homeCubit.homeBannersModel!.data!.map((slider) {
                  return Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(28),
                            bottomRight: Radius.circular(28),
                          ),
                          child: Stack(
                            children: [
                              CustomNetWorkImage(
                                height: isFullHeight ? double.infinity : 170.h,
                                width: MediaQuery.of(context).size.width,
                                imageUrl: slider.image ?? slider.toString(),
                                raduis: 0,
                                fit: BoxFit.cover,
                              ),
                              const SliderOverlay(),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10.0,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: homeCubit.homeBannersModel!.data!
                              .asMap()
                              .entries
                              .map((entry) {
                                return Container(
                                  width: 8.0,
                                  height: 8.0,
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 4.0,
                                  ),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:
                                        homeCubit.currentSliderIndex ==
                                            entry.key
                                        ? Colors.white
                                        : Colors.white.withValues(alpha: 0.5),
                                  ),
                                );
                              })
                              .toList(),
                        ),
                      ),
                    ],
                  );
                }).toList(),
                options: CarouselOptions(
                  autoPlay: true,
                  height: isFullHeight ? null : 170,
                  aspectRatio: isFullHeight
                      ? MediaQuery.of(context).size.width /
                            MediaQuery.of(context).size.height *
                            0.6
                      : MediaQuery.of(context).size.width / 250,
                  viewportFraction: isFullHeight ? 1.0 : 0.8,
                  enlargeCenterPage: !isFullHeight,
                  onPageChanged: (index, reason) {
                    homeCubit.changeHomeSliderImages(index);
                  },
                ),
              );
      },
    );
  }
}
