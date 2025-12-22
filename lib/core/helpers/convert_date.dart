import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class DateFormatterClass {
  // Format: "2025-10-12 00:00:00.000" to various styles

  /// Convert to timeago format (e.g., "in about a year")
  static String toTimeAgo(String? dateTimeString) {
    if (dateTimeString == null || dateTimeString.isEmpty) {
      return 'Just now';
    }
    try {
      DateTime parsedDate = DateTime.parse(dateTimeString);
      return timeago.format(parsedDate, locale: 'en');
    } catch (e) {
      return 'Just now';
    }
  }

  /// Convert to date only: "2025-10-12"
  static String toDateOnly(String? dateTimeString) {
    if (dateTimeString == null || dateTimeString.isEmpty) return '';
    try {
      DateTime parsedDate = DateTime.parse(dateTimeString);
      return DateFormat('yyyy-MM-dd').format(parsedDate);
    } catch (e) {
      return '';
    }
  }

  /// Convert to readable date: "October 12, 2025"
  static String toReadableDate(String? dateTimeString) {
    if (dateTimeString == null || dateTimeString.isEmpty) return '';
    try {
      DateTime parsedDate = DateTime.parse(dateTimeString);
      return DateFormat('MMMM dd, yyyy').format(parsedDate);
    } catch (e) {
      return '';
    }
  }

  /// Convert to short date: "Oct 12, 2025"
  static String toShortDate(String? dateTimeString) {
    if (dateTimeString == null || dateTimeString.isEmpty) return '';
    try {
      DateTime parsedDate = DateTime.parse(dateTimeString);
      return DateFormat('MMM dd, yyyy').format(parsedDate);
    } catch (e) {
      return '';
    }

  }
  /// Convert to time only: "12:00 AM"
  static String toTimeOnly(String? dateTimeString) {
    if (dateTimeString == null || dateTimeString.isEmpty) return '';
    try {
      DateTime parsedDate = DateTime.parse(dateTimeString);
      return DateFormat('hh:mm a').format(parsedDate);
    } catch (e) {
      return '';
    }
  }

  /// Convert to 24-hour time: "00:00"
  static String to24HourTime(String? dateTimeString) {
    if (dateTimeString == null || dateTimeString.isEmpty) return '';
    try {
      DateTime parsedDate = DateTime.parse(dateTimeString);
      return DateFormat('HH:mm').format(parsedDate);
    } catch (e) {
      return '';
    }
  }

  /// Convert to date and time: "October 12, 2025 at 12:00 AM"
  static String toDateTime(String? dateTimeString) {
    if (dateTimeString == null || dateTimeString.isEmpty) return '';
    try {
      DateTime parsedDate = DateTime.parse(dateTimeString);
      return DateFormat('MMMM dd, yyyy \'at\' hh:mm a').format(parsedDate);
    } catch (e) {
      return '';
    }
  }

  /// Convert to compact datetime: "10/12/2025, 12:00 AM"
  static String toCompactDateTime(String? dateTimeString) {
    if (dateTimeString == null || dateTimeString.isEmpty) return '';
    try {
      DateTime parsedDate = DateTime.parse(dateTimeString);
      return DateFormat('MM/dd/yyyy, hh:mm a').format(parsedDate);
    } catch (e) {
      return '';
    }
  }

  /// Convert to ISO format: "2025-10-12T00:00:00.000"
  static String toIsoFormat(String? dateTimeString) {
    if (dateTimeString == null || dateTimeString.isEmpty) return '';
    try {
      DateTime parsedDate = DateTime.parse(dateTimeString);
      return parsedDate.toIso8601String();
    } catch (e) {
      return '';
    }
  }

  /// Convert to relative day: "Today", "Tomorrow", "Yesterday", or date
  static String toRelativeDay(String? dateTimeString) {
    if (dateTimeString == null || dateTimeString.isEmpty) return '';
    try {
      DateTime parsedDate = DateTime.parse(dateTimeString);
      DateTime now = DateTime.now();
      DateTime today = DateTime(now.year, now.month, now.day);
      DateTime inputDate = DateTime(parsedDate.year, parsedDate.month, parsedDate.day);

      if (inputDate == today) {
        return 'Today';
      } else if (inputDate == today.add(Duration(days: 1))) {
        return 'Tomorrow';
      } else if (inputDate == today.subtract(Duration(days: 1))) {
        return 'Yesterday';
      } else {
        return DateFormat('MMM dd, yyyy').format(parsedDate);
      }
    } catch (e) {
      return '';
    }
  }

  /// Convert to day of week: "Sunday", "Monday", etc.
  static String toDayOfWeek(String? dateTimeString) {
    if (dateTimeString == null || dateTimeString.isEmpty) return '';
    try {
      DateTime parsedDate = DateTime.parse(dateTimeString);
      return DateFormat('EEEE').format(parsedDate);
    } catch (e) {
      return '';
    }
  }

  /// Convert to short day of week: "Sun", "Mon", etc.
  static String toShortDayOfWeek(String? dateTimeString) {
    if (dateTimeString == null || dateTimeString.isEmpty) return '';
    try {
      DateTime parsedDate = DateTime.parse(dateTimeString);
      return DateFormat('EEE').format(parsedDate);
    } catch (e) {
      return '';
    }
  }

  /// Convert to month and year: "October 2025"
  static String toMonthYear(String? dateTimeString) {
    if (dateTimeString == null || dateTimeString.isEmpty) return '';
    try {
      DateTime parsedDate = DateTime.parse(dateTimeString);
      return DateFormat('MMMM yyyy').format(parsedDate);
    } catch (e) {
      return '';
    }
  }

  /// Convert to timestamp (milliseconds since epoch)
  static int toTimestamp(String? dateTimeString) {
    if (dateTimeString == null || dateTimeString.isEmpty) return 0;
    try {
      DateTime parsedDate = DateTime.parse(dateTimeString);
      return parsedDate.millisecondsSinceEpoch;
    } catch (e) {
      return 0;
    }
  }

  /// Check if date is today
  static bool isToday(String? dateTimeString) {
    if (dateTimeString == null || dateTimeString.isEmpty) return false;
    try {
      DateTime parsedDate = DateTime.parse(dateTimeString);
      DateTime now = DateTime.now();
      return parsedDate.year == now.year &&
          parsedDate.month == now.month &&
          parsedDate.day == now.day;
    } catch (e) {
      return false;
    }
  }

  /// Check if date is in the future
  static bool isFuture(String? dateTimeString) {
    if (dateTimeString == null || dateTimeString.isEmpty) return false;
    try {
      DateTime parsedDate = DateTime.parse(dateTimeString);
      return parsedDate.isAfter(DateTime.now());
    } catch (e) {
      return false;
    }
  }

  /// Get difference in days from now
  static int daysFromNow(String? dateTimeString) {
    if (dateTimeString == null || dateTimeString.isEmpty) return 0;
    try {
      DateTime parsedDate = DateTime.parse(dateTimeString);
      return DateTime.now().difference(parsedDate).inDays;
    } catch (e) {
      return 0;
    }
  }
}