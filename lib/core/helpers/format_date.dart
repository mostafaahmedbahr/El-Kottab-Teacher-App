import 'package:flutter/material.dart';

String formatDate(DateTime date) {
  return '${date.day}/${date.month}/${date.year}';
}
String formatTimeTo24H(TimeOfDay time) {
  final hours = time.hour.toString().padLeft(2, '0');
  final minutes = time.minute.toString().padLeft(2, '0');
  return '$hours:$minutes';
}
