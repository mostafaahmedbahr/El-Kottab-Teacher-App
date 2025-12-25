import '../../../../../main_imports.dart';
import 'call_log_item.dart';

class CallList extends StatelessWidget {
  const CallList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding:   EdgeInsets.only(bottom: 12.h),
          child: CallLogItem(),
        );
      },
    );
  }
}
