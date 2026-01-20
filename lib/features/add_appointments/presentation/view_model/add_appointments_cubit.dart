import 'package:easy_localization/easy_localization.dart';
import 'package:el_kottab_teacher_app/features/add_appointments/data/models/add_appointment_model.dart';
import 'package:el_kottab_teacher_app/features/add_appointments/data/models/all_schedules_model.dart';
import 'package:el_kottab_teacher_app/features/add_appointments/data/models/delete_schedules_model.dart';
import '../../../../core/utils/enums.dart';
import '../../../../main_imports.dart';
import '../../data/models/appointment_model.dart';
import '../../data/models/update_schedule_model.dart';
import '../../data/repos/add_appointments_repo.dart';
import 'add_appointments_states.dart';

class AddAppointmentsCubit extends Cubit<AddAppointmentsStates> {
  AddAppointmentsCubit(this.addAppointmentsRepo)
    : super(AddAppointmentsInitState());
  AddAppointmentsRepo? addAppointmentsRepo;

  /// الأيام
  List<String> nameOfDays = [
    LangKeys.saturday.tr(),
    LangKeys.sunday.tr(),
    LangKeys.monday.tr(),
    LangKeys.tuesday.tr(),
    LangKeys.wednesday.tr(),
    LangKeys.thursday.tr(),
    LangKeys.friday.tr(),
  ];

  /// مواعيد كل يوم
  Map<String, List<AppointmentModel>> appointments = {};

  /// إضافة عنصر فاضي
  void addEmptyAppointment(String day) {
    appointments.putIfAbsent(day, () => []);
    appointments[day]!.add(AppointmentModel());
    emit(UpdateAppointmentsState());
  }

  /// حذف موعد
  void removeAppointment(String day, int index) {
    appointments[day]!.removeAt(index);
    emit(UpdateAppointmentsState());
  }

  /// تعيين وقت البداية
  AppointmentResult setStartTime(String day, int index, TimeOfDay start) {
    final current = appointments[day]![index];

    if (current.end != null && !_isEndAfterStart(start, current.end!)) {
      return AppointmentResult.endBeforeStart;
    }

    if (current.end != null && _hasConflict(day, start, current.end!, index)) {
      return AppointmentResult.conflict;
    }

    current.start = start;
    emit(UpdateAppointmentsState());
    return AppointmentResult.success;
  }

  /// تعيين وقت النهاية
  AppointmentResult setEndTime(String day, int index, TimeOfDay end) {
    final current = appointments[day]![index];

    if (current.start == null) {
      current.end = end;
      emit(UpdateAppointmentsState());
      return AppointmentResult.success;
    }

    if (!_isEndAfterStart(current.start!, end)) {
      return AppointmentResult.endBeforeStart;
    }

    if (_hasConflict(day, current.start!, end, index)) {
      return AppointmentResult.conflict;
    }

    current.end = end;
    emit(UpdateAppointmentsState());
    return AppointmentResult.success;
  }

  /// ================= Helpers =================

  int _toMinutes(TimeOfDay time) {
    return time.hour * 60 + time.minute;
  }

  bool _isEndAfterStart(TimeOfDay start, TimeOfDay end) {
    return _toMinutes(end) > _toMinutes(start);
  }

  bool _hasConflict(
    String day,
    TimeOfDay start,
    TimeOfDay end,
    int currentIndex,
  ) {
    final list = appointments[day] ?? [];

    for (int i = 0; i < list.length; i++) {
      if (i == currentIndex) continue;

      final other = list[i];
      if (other.start == null || other.end == null) continue;

      final s1 = _toMinutes(start);
      final e1 = _toMinutes(end);
      final s2 = _toMinutes(other.start!);
      final e2 = _toMinutes(other.end!);

      if (s1 < e2 && e1 > s2) {
        return true;
      }
    }
    return false;
  }

  AddAppointmentModel? addAppointmentModel;

  Future<void> addAppointment({
    required String day,
    required String from,
    required String to,
  }) async {
    emit(AddAppointmentsLoadingState());
    var result = await addAppointmentsRepo!.addAppointment(
      day: day,
      from: from,
      to: to,
    );
    return result.fold(
      (failure) {
        emit(AddAppointmentsErrorState(failure.errMessage));
      },
      (data) async {
        addAppointmentModel = data;
        emit(AddAppointmentsSuccessState(data));
      },
    );
  }

  DeleteScheduleModel? deleteScheduleModel;

  Future<void> deleteSchedule({required String scheduleId}) async {
    emit(DeleteScheduleLoadingState());
    var result = await addAppointmentsRepo!.deleteSchedule(
      scheduleId: scheduleId,
    );
    return result.fold(
      (failure) {
        emit(DeleteScheduleErrorState(failure.errMessage));
      },
      (data) async {
        deleteScheduleModel = data;
        emit(DeleteScheduleSuccessState(data));
      },
    );
  }

  AllSchedulesModel? allSchedulesModel;

  Future<void> getAllSchedules() async {
    emit(GetAllScheduleLoadingState());
    var result = await addAppointmentsRepo!.getAllSchedules();
    return result.fold(
      (failure) {
        emit(GetAllScheduleErrorState(failure.errMessage));
      },
      (data) async {
        allSchedulesModel = data;
        emit(GetAllScheduleSuccessState(data));
      },
    );
  }

  UpdateScheduleModel? updateScheduleModel;

  Future<void> updateSchedule({
    required String scheduleId,
    required String day,
    required String from,
    required String to,
  }) async {
    emit(UpdateScheduleLoadingState());
    var result = await addAppointmentsRepo!.updateSchedule(
      scheduleId: scheduleId,
      day: day,
      from: from,
      to: to,
    );
    return result.fold(
      (failure) {
        emit(UpdateScheduleErrorState(failure.errMessage));
      },
      (data) async {
        updateScheduleModel = data;
        emit(UpdateScheduleSuccessState(data));
      },
    );
  }
}
