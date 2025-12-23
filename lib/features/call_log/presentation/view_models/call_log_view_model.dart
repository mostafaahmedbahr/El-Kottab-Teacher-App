import 'package:flutter/material.dart';

import '../models/call_log_model.dart';

class CallLogViewModel extends ChangeNotifier {
  List<CallLogModel> _callLogs = [];
  bool _isLoading = false;
  String? _error;

  // Getters
  List<CallLogModel> get callLogs => _callLogs;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Get calls by status
  List<CallLogModel> getCompletedCalls() {
    return _callLogs
        .where((call) => call.status == CallStatus.completed)
        .toList();
  }

  List<CallLogModel> getCanceledCalls() {
    return _callLogs
        .where((call) => call.status == CallStatus.canceled)
        .toList();
  }

  List<CallLogModel> getMissedCalls() {
    return _callLogs.where((call) => call.status == CallStatus.missed).toList();
  }

  // Load call logs (simulated data)
  Future<void> loadCallLogs() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 500));

      // Mock data
      _callLogs = [
        CallLogModel(
          id: '1',
          studentName: 'Ahmed Mohamed',
          studentImage: 'https://via.placeholder.com/150',
          callTime: DateTime.now().subtract(const Duration(hours: 2)),
          callDuration: const Duration(minutes: 12, seconds: 34),
          status: CallStatus.completed,
          isOutgoing: true,
        ),
        CallLogModel(
          id: '2',
          studentName: 'Sara Ali',
          studentImage: 'https://via.placeholder.com/150',
          callTime: DateTime.now().subtract(const Duration(days: 1)),
          callDuration: Duration.zero,
          status: CallStatus.canceled,
          isOutgoing: false,
        ),
        CallLogModel(
          id: '3',
          studentName: 'Mohamed Hassan',
          studentImage: 'https://via.placeholder.com/150',
          callTime: DateTime.now().subtract(const Duration(hours: 5)),
          callDuration: Duration.zero,
          status: CallStatus.missed,
          isOutgoing: false,
        ),
        // Add more mock data as needed
      ];
    } catch (e) {
      _error = 'Failed to load call logs: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Format duration for display
  String formatDuration(Duration duration) {
    if (duration.inSeconds == 0) return '--:--';

    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    return '${twoDigits(minutes)}:${twoDigits(seconds)}';
  }

  // Format date for display
  String formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today, ${_formatTime(date)}';
    } else if (difference.inDays == 1) {
      return 'Yesterday, ${_formatTime(date)}';
    } else if (difference.inDays < 7) {
      return '${_getWeekday(date.weekday)}, ${_formatTime(date)}';
    } else {
      return '${date.day}/${date.month}/${date.year}, ${_formatTime(date)}';
    }
  }

  String _formatTime(DateTime date) {
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  String _getWeekday(int weekday) {
    switch (weekday) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return '';
    }
  }
}
