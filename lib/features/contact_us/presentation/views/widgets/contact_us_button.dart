import 'package:easy_localization/easy_localization.dart';

import '../../../../../main_imports.dart';
import '../../view_model/contact_us_cubit.dart';
import '../../view_model/contact_us_states.dart';

class ContactUsButton extends StatelessWidget {
  const ContactUsButton({super.key, required this.formKey});
  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContactUsCubit , ContactUsStates>(
      listener: (context,state){
        if(state is ContactUsSuccessState){
          Toast.showSuccessToast(msg: state.contactUsModel.message.toString(),
              context: context);
          Navigator.pop(context);
        }else if (state is ContactUsErrorState){
          Toast.showErrorToast(msg: state.error.toString(), context: context);
        }
      },
      builder: (context,state){
        var contactUsCubit = context.read<ContactUsCubit>();
        return ConditionalBuilder(
          condition: state is ! ContactUsLoadingState,
          fallback: (context)=>CustomLoading(),
          builder: (context){
            return  CustomButton(
                btnText: LangKeys.send.tr(),
                onPressed: (){
                  if(formKey.currentState!.validate()){
                    contactUsCubit.contactUs();
                  }

                });
          },

        );
      },

    );
  }
}
