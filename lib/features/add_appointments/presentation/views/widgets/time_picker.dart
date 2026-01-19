import 'package:el_kottab_teacher_app/main_imports.dart';

Future<TimeOfDay?> customTimePicker(
  BuildContext context,
  TimeOfDay initialTime,
) {
  return showTimePicker(
    context: context,
    initialTime: initialTime,
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.dark(
            primary: Color.fromARGB(255, 206, 218, 171),
            onPrimary: Colors.white,
            surface: AppColors.darkOlive,
            onSurface: Colors.white,
          ),
          timePickerTheme: TimePickerThemeData(
            backgroundColor: AppColors.darkOlive,
            hourMinuteTextColor: Colors.black,
            hourMinuteShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            dayPeriodTextColor: Colors.black,
            dayPeriodColor: MaterialStateColor.resolveWith(
              (states) => states.contains(MaterialState.selected)
                  ? Colors.white.withOpacity(.2)
                  : Colors.transparent,
            ),
            dialHandColor: Colors.black,
            dialBackgroundColor: Colors.white.withOpacity(.08),
            entryModeIconColor: Colors.white,
          ),
        ),
        child: child!,
      );
    },
  );
}
