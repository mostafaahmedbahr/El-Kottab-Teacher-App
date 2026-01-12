import '../../../../../main_imports.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key,    this.image});
  final String? image;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.r),
      width: 75.w,
      height: 75.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.darkOlive,
      ),
      child:   Container(
        height: 70.h,
        width: 70.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: 2.w,
          ),
        ),
        child: ClipOval(
          child: CustomNetWorkImage(
            imageUrl: image??"" ,
            height: 70.h,
            width: 70.w,
            fit: BoxFit.cover,
            raduis: 0,
          ),
        ),
      ),
    );
  }
}
