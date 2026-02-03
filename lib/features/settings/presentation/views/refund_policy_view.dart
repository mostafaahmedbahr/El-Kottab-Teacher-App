import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../../main_imports.dart';
import '../view_model/settings_cubit.dart';
import '../view_model/settings_states.dart';

class RefundPolicyView extends StatelessWidget {
  const RefundPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LangKeys.refundPolicy.tr())),
      body: BlocBuilder<SettingsCubit, SettingsStates>(
        builder: (context, state) {
          return Padding(
            padding:   EdgeInsets.all(20.0.r),
            child: ListView(
              children: [
                state is GetRefundPolicyLoadingState || context
                    .read<SettingsCubit>()
                    .refundPolicyModel==null
                    ? Column(
                  children: [
                    Gap(200.h),
                    CustomLoading(),
                  ],
                )
                    : state is GetRefundPolicyErrorState
                    ? Text(state.error.toString())
                    : Html(
                  data: context
                      .read<SettingsCubit>()
                      .refundPolicyModel!
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
