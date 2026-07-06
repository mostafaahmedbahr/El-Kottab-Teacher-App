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
      return RefreshIndicator(
        color: AppColors.darkOlive,
        backgroundColor: AppColors.white,
        onRefresh: () async {
          await context.read<CallLogsCubit>().getAllCalls(
            cubit.status,
            isRefresh: true,
          );
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: const Center(child: Text('لا توجد مكالمات')),
          ),
        ),
      );
    }

    return RefreshIndicator(
      color: AppColors.darkOlive,
      backgroundColor: AppColors.white,
      onRefresh: () async {
        await context.read<CallLogsCubit>().getAllCalls(
          cubit.status,
          isRefresh: true,
        );
      },
      child: ListView.builder(
        itemCount: calls.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: CallLogItem(callData: calls[index]),
          );
        },
      ),
    );
  }
}
