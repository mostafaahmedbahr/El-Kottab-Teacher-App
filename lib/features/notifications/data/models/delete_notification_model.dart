
class DeleteNotificationModel {
  int? code;
  dynamic data;
  String? message;

  DeleteNotificationModel({this.code, this.data, this.message});

  DeleteNotificationModel.fromJson(Map<String, dynamic> json) {
    code = json["code"];
    data = json["data"];
    message = json["message"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["code"] = code;
    _data["data"] = data;
    _data["message"] = message;
    return _data;
  }
}