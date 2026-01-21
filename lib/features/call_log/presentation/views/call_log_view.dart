import 'package:el_kottab_teacher_app/features/call_log/presentation/views/widgets/call_list.dart';
import 'package:el_kottab_teacher_app/features/call_log/presentation/views/widgets/filter_buttons.dart';
import 'package:el_kottab_teacher_app/features/call_log/presentation/views/widgets/status_summary.dart';
import 'package:el_kottab_teacher_app/main_imports.dart';

import '../../../../core/app_services/remote_services/service_locator.dart';
import '../../data/repos/call_logs_repo_impl.dart';
import '../view_models/call_logs_cubit.dart';

class CallLogView extends StatelessWidget {
  const CallLogView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => CallLogsCubit(getIt.get<CallLogsRepoImpl>())..getAllCalls(null),
        child: SafeArea(
          child:
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            child: Column(
              children: [
                FilterButtons(),
                Gap(16.h),
                StatusSummary(),
                Gap(16.h),
                Expanded(child: CallList()),
              ],
            ),
          ),
        ),
      ),
      // body: _buildBody(),
    );
  }
}
