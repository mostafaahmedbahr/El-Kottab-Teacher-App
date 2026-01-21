import 'package:el_kottab_teacher_app/core/errors/error_ui.dart';
import 'package:el_kottab_teacher_app/features/call_log/presentation/view_models/call_logs_states.dart';
import '../../../../../main_imports.dart';
import '../../view_models/call_logs_cubit.dart';
import 'call_log_item.dart';

class CallList extends StatelessWidget {
  const CallList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CallLogsCubit , CallLogsStates>(
      builder: (context,state){
        var callLogsCubit = context.read<CallLogsCubit>();
        return
          state is GetCallsLoadingState ? CustomLoading():
              state is GetCallsErrorState ? ErrorUi(errorState: state.error,
                  onPressed: (){
                    callLogsCubit.getAllCalls(null);
                  }):
          ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
              padding:   EdgeInsets.only(bottom: 12.h),
              child: CallLogItem(),
            );
          },
        );
      },

    );
  }
}
