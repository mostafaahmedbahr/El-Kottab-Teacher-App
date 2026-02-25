
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data["message"] = message;
    data["status"] = status;
    data["data"] = data;
    return data;
  }
}