import 'package:easy_localization/easy_localization.dart';
import 'package:el_kottab_teacher_app/features/contact_us/data/repos/contact_us_repo_impl.dart';
import 'package:el_kottab_teacher_app/features/contact_us/presentation/view_model/contact_us_cubit.dart';
import 'package:el_kottab_teacher_app/features/contact_us/presentation/view_model/contact_us_states.dart';
import 'package:el_kottab_teacher_app/features/contact_us/presentation/views/widgets/contact_us_button.dart';
import 'package:el_kottab_teacher_app/features/contact_us/presentation/views/widgets/contact_us_form.dart';
import 'package:el_kottab_teacher_app/features/contact_us/presentation/views/widgets/social_media_icons.dart';
import 'package:el_kottab_teacher_app/main_imports.dart';
import '../../../../core/app_services/remote_services/service_locator.dart';

class ContactUsView extends StatelessWidget {
  const ContactUsView({super.key});

  @override
  Widget build(BuildContext context) {
    final contactUsKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context)=>ContactUsCubit(getIt.get<ContactUsRepoImpl>())..getSettingsData(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(LangKeys.contactUs.tr()),
        ),
        body: BlocBuilder<ContactUsCubit , ContactUsStates>(
          buildWhen: (previous, current) {
            return current is ContactUsSuccessState ||
                current is ContactUsErrorState ||
                current is ContactUsLoadingState;
          },
          builder: (context,state){
            var contactUsCubit = context.read<ContactUsCubit>();
            return  Padding(
              padding:   EdgeInsets.all(20.0.r),
              child: Form(
                key: contactUsKey,
                child: ListView(
                  children: [
                    ContactUsForm(contactUsCubit: contactUsCubit,),
                    ContactUsButton(formKey: contactUsKey,),
                  ],
                ),
              ),
            );
          },

        ),
        bottomNavigationBar:SizedBox(
            height: 130.h,
            child: SocialMediaIcons()) ,
      ),
    );
  }
}
