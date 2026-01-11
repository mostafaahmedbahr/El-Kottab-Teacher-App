import '../../../../../main_imports.dart';

class ProfileImage extends StatelessWidget {
  final String imageUrl;

  const ProfileImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          padding: EdgeInsets.all(2.r),
          width: 80.w,
          height: 80.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.darkOlive,
          ),
          child: Container(
            height: 80.h,
            width: 80.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2.w),
            ),
            child: ClipOval(
              child: CustomNetWorkImage(
                imageUrl: imageUrl.isNotEmpty
                    ? imageUrl
                    : "https://wallpapers.com/images/featured-full/cool-profile-picture-87h46gcobjl5e4xu.jpg",
                height: 80.h,
                width: 80.w,
                fit: BoxFit.cover,
                raduis: 0,
              ),
            ),
          ),
        ),
        Container(
          height: 27.h,
          width: 27.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color.fromARGB(255, 144, 156, 107),
          ),
          child: Center(child: SvgPicture.asset(SvgImages.edit, height: 18.h)),
        ),
      ],
    );
  }
}
