
class ForgotPasswordByEmailModel {
  String? message;
  int? status;
  dynamic data;

  ForgotPasswordByEmailModel({this.message, this.status, this.data});

  ForgotPasswordByEmailModel.fromJson(Map<String, dynamic> json) {
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