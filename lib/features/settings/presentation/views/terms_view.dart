import 'package:easy_localization/easy_localization.dart';
import 'package:el_kottab_teacher_app/features/settings/presentation/view_model/settings_cubit.dart';
import 'package:el_kottab_teacher_app/features/settings/presentation/view_model/settings_states.dart';
import 'package:el_kottab_teacher_app/main_imports.dart';
import 'package:flutter_html/flutter_html.dart';

class TermsView extends StatelessWidget {
  const TermsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LangKeys.privacyAndTerms.tr())),
      body: BlocBuilder<SettingsCubit, SettingsStates>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(20.0.r),
            child: ListView(
              children: [
                state is GetTermsAndConditionsDataLoadingState ||
                        context.read<SettingsCubit>().termsAndConditionsModel ==
                            null
                    ? Column(children: [Gap(200.h), CustomLoading()])
                    : state is GetTermsAndConditionsDataErrorState
                    ? Text(state.error.toString())
                    : Html(
                        data: context
                            .read<SettingsCubit>()
                            .termsAndConditionsModel!
                            .data!
                            .value,
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
