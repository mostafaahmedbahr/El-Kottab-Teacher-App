import 'package:carousel_slider/carousel_slider.dart';
import 'package:el_kottab_teacher_app/features/home/presentation/views/widgets/slider_overlay.dart';

import '../../../../../main_imports.dart';
import '../../view_model/home_cubit.dart';
import '../../view_model/home_states.dart';

class HomeSliderImages extends StatelessWidget {
  final bool isFullHeight;
  const HomeSliderImages({super.key, this.isFullHeight = false});
  // const HomeSliderImages({super.key});

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
        return
        // state is GetHomeSliderLoadingState || homeCubit.homeBannersModel==null? HomeSliderImagesLoading():
        CarouselSlider(
          //   items: homeCubit.homeBannersModel!.data!.map((slider) {
          items: homeCubit.sliderImagesList.map((slider) {
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
                          imageUrl: slider.toString(),
                          raduis: 0,
                          fit: BoxFit.cover,
                        ),

                        const SliderOverlay(),
                      ],
                    ),
                  ),

                  //last

                  //   child: CustomNetWorkImage(
                  //     height: 140.h,
                  //     width: MediaQuery.of(context).size.width,
                  // //    imageUrl: slider.image.toString(),
                  //     imageUrl: slider.toString(),
                  //     raduis: 16,
                  //     fit: BoxFit.cover,
                  //   ),
                ),
                Positioned(
                  bottom: 10.0,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // children: homeCubit.homeBannersModel!.data!
                    children: homeCubit.sliderImagesList.asMap().entries.map((
                      entry,
                    ) {
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: homeCubit.currentSliderIndex == entry.key
                              ? Colors.white
                              : Colors.white.withValues(alpha: 0.5),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            );
          }).toList(),
          options: CarouselOptions(
            autoPlay: true,
            height: 170,
            aspectRatio: MediaQuery.of(context).size.width / 250,
            viewportFraction: 0.8,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              homeCubit.changeHomeSliderImages(index);
            },
          ),
        );
      },
    );
  }
}
