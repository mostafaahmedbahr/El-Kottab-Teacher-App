
class NotificationsCountModel {
  int? code;
  int? data;
  String? message;

  NotificationsCountModel({this.code, this.data, this.message});

  NotificationsCountModel.fromJson(Map<String, dynamic> json) {
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