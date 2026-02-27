import 'package:el_kottab_teacher_app/features/settings/presentation/views/widgets/payment_card.dart';

import '../../../../../core/errors/error_ui.dart';
import '../../../../../main_imports.dart';
import '../../view_model/settings_cubit.dart';
import '../../view_model/settings_states.dart';

class PaymentMethodsViewBody extends StatelessWidget {
  const PaymentMethodsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit , SettingsStates>(
      buildWhen:  (previous, current){
        return current is GetPaymentMethodLoadingState ||
            current is GetPaymentMethodErrorState ||
            current is GetPaymentMethodSuccessState;
      },
      builder: (context,state){
        var settingsCubit = context.read<SettingsCubit>();
        return
          state is GetPaymentMethodLoadingState ? CustomLoading():
          state is GetPaymentMethodErrorState ? ErrorUi(errorState: state.error, onPressed: (){
            settingsCubit.getPaymentMethods();
          }):
          Padding(
            padding: const EdgeInsets.all(16),
            child: ListView.separated(
              itemBuilder: (context,index){
                var paymentMethod = settingsCubit.getPaymentMethodsModel!.data![index];
                return             PaymentCard(
                  title: paymentMethod.methodType.toString(),
                  subTitle:paymentMethod.methodType=="bank_account" ? paymentMethod.accountNumber.toString() : paymentMethod.phoneNumber.toString(),
                  icon:paymentMethod.methodType=="bank_account" ?  Icons.account_balance : Icons.phone_android,
                  isActive:paymentMethod.isDefault==true? true : false,
                  onTap: () {},
                );
              },
              separatorBuilder: (context,index){
                return Gap(12.h);
              },
              itemCount: settingsCubit.getPaymentMethodsModel!.data!.length,
            ),
            // child: Column(
            //   children: [
            //     PaymentCard(
            //       title: "InstaPay",
            //       icon: Icons.account_balance,
            //       isActive: false,
            //       onTap: () {},
            //     ),
            //     Gap(12.h),
            //     PaymentCard(
            //       title: "Vodafone Cash",
            //       icon: Icons.phone_android,
            //       isActive: true,
            //       onTap: () {},
            //     ),
            //     Gap(12.h),
            //     PaymentCard(
            //       title: "bank account",
            //       icon: Icons.credit_card,
            //       isActive: false,
            //       onTap: () {},
            //     ),
            //   ],
            // ),
          );
      },

    );
  }
}
