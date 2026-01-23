import 'package:flutter/material.dart';

class AppointmentModel {
  TimeOfDay? start;
  TimeOfDay? end;
  String? scheduleId;

  AppointmentModel({this.start, this.end ,this.scheduleId});
}
