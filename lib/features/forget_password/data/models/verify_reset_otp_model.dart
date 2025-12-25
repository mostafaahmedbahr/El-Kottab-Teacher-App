
class VerifyResetOtpModel {
  String? message;
  int? status;
  dynamic data;

  VerifyResetOtpModel({this.message, this.status, this.data});

  VerifyResetOtpModel.fromJson(Map<String, dynamic> json) {
    message = json["message"];
    status = json["status"];
    data = json["data"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["message"] = message;
    _data["status"] = status;
    _data["data"] = data;
    return _data;
  }
}