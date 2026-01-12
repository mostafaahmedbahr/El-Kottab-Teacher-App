
class NotificationsCountModel {
  String? message;
  int? status;
  Data? data;

  NotificationsCountModel({this.message, this.status, this.data});

  NotificationsCountModel.fromJson(Map<String, dynamic> json) {
    message = json["message"];
    status = json["status"];
    data = json["data"] == null ? null : Data.fromJson(json["data"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["message"] = message;
    _data["status"] = status;
    if(data != null) {
      _data["data"] = data?.toJson();
    }
    return _data;
  }
}

class Data {
  int? count;

  Data({this.count});

  Data.fromJson(Map<String, dynamic> json) {
    count = json["count"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["count"] = count;
    return _data;
  }
}