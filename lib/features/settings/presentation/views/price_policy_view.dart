import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../../main_imports.dart';
import '../view_model/settings_cubit.dart';
import '../view_model/settings_states.dart';

class PricePolicyView extends StatelessWidget {
  const PricePolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LangKeys.pricePolicy.tr())),
      body: BlocBuilder<SettingsCubit, SettingsStates>(
        builder: (context, state) {
          return Padding(
            padding:   EdgeInsets.all(20.0.r),
            child: ListView(
              children: [
                state is GetPrivacyPolicyLoadingState || context
                    .read<SettingsCubit>()
                    .privacyPolicyModel==null
                    ? Column(
                  children: [
                    Gap(200.h),
                    CustomLoading(),
                  ],
                )
                    : state is GetPrivacyPolicyErrorState
                    ? Text(state.error.toString())
                    : Html(
                  data: context
                      .read<SettingsCubit>()
                      .privacyPolicyModel!
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
