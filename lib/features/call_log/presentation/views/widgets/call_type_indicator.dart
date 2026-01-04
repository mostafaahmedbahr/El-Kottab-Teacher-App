import '../../../../../main_imports.dart';

class CallTypeIndicator extends StatelessWidget {
  const CallTypeIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: const Color.fromARGB(82, 168, 177, 151),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        'وارد',
        style: TextStyle(
          fontSize: 12.sp,
          color: Color.fromARGB(255, 117, 138, 117),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
