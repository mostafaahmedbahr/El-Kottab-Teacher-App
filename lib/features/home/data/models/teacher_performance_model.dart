class TeacherPerformanceModel {
  final String message;
  final int status;
  final PerformanceData data;

  TeacherPerformanceModel({
    required this.message,
    required this.status,
    required this.data,
  });

  factory TeacherPerformanceModel.fromJson(Map<String, dynamic> json) {
    return TeacherPerformanceModel(
      message: json['message'] ?? '',
      status: json['status'] ?? 0,
      data: PerformanceData.fromJson(json['data'] ?? {}),
    );
  }
}

class PerformanceData {
  final String successCall;
  final int overview;
  final int totalCall;

  PerformanceData({
    required this.successCall,
    required this.overview,
    required this.totalCall,
  });

  factory PerformanceData.fromJson(Map<String, dynamic> json) {
    return PerformanceData(
      successCall: json['success_call']?.toString() ?? '0',
      overview: json['overview'] ?? 0,
      totalCall: json['total_call'] ?? 0,
    );
  }
}
