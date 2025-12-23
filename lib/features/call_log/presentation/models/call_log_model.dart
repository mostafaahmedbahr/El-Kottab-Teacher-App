class CallLogModel {
  final String id;
  final String studentName;
  final String studentImage;
  final DateTime callTime;
  final Duration callDuration;
  final CallStatus status;
  final bool isOutgoing;

  CallLogModel({
    required this.id,
    required this.studentName,
    required this.studentImage,
    required this.callTime,
    required this.callDuration,
    required this.status,
    this.isOutgoing = true,
  });
}

enum CallStatus { completed, canceled, missed }
