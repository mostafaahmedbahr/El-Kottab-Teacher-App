import 'package:el_kottab_teacher_app/features/contact_us/presentation/views/widgets/social_content.dart';
import 'package:el_kottab_teacher_app/features/contact_us/presentation/views/widgets/social_shimmer.dart';

import '../../../../../main_imports.dart';
import '../../view_model/contact_us_cubit.dart';
import '../../view_model/contact_us_states.dart';

class SocialMediaIcons extends StatelessWidget {
  const SocialMediaIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactUsCubit, ContactUsStates>(
      buildWhen: (previous, current) {
        return current is GetSettingsDataSuccessState ||
            current is GetSettingsDataErrorState ||
            current is GetSettingsDataLoadingState;
      },
      builder: (context, state) {
        var contactUsCubit = context.read<ContactUsCubit>();

        /// ✅ لو Loading أو لسه مفيش داتا
        if (state is GetSettingsDataLoadingState ||
            contactUsCubit.settingsModel == null) {
          return const SocialShimmer();
        }

        /// ✅ بعد ما الداتا تيجي
        return SocialContent(
          facebook: contactUsCubit.settingsModel!.data!.facebookUrl!,
          instagram: contactUsCubit.settingsModel!.data!.instagramUrl!,
          youtube: contactUsCubit.settingsModel!.data!.youtubeUrl!,
          whatsapp: contactUsCubit.settingsModel!.data!.footerPhone!,
        );
      },
    );
  }

}




