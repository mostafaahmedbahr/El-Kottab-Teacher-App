  import '../../../../../main_imports.dart';
import '../../view_models/call_logs_cubit.dart';
import 'call_log_item.dart';

class CallList extends StatelessWidget {
  const CallList({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<CallLogsCubit>();
    final calls = cubit.callsModel?.data ?? [];

    if (calls.isEmpty) {
      return const Center(child: Text('لا توجد مكالمات'));
    }

    return ListView.builder(
      itemCount: calls.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: CallLogItem(
            // model: calls[index],
          ),
        );
      },
    );
  }
}

