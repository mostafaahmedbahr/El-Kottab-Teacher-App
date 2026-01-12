
class NotificationsModel {
  String? message;
  int? status;
  List<Data>? data;

  NotificationsModel({this.message, this.status, this.data});

  NotificationsModel.fromJson(Map<String, dynamic> json) {
    message = json["message"];
    status = json["status"];
    data = json["data"] == null ? null : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["message"] = message;
    _data["status"] = status;
    if(data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Data {
  int? id;
  String? title;
  String? body;
  bool? isRead;
  dynamic createdAt;

  Data({this.id, this.title, this.body, this.isRead, this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    body = json["body"];
    isRead = json["is_read"];
    createdAt = json["created_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["title"] = title;
    _data["body"] = body;
    _data["is_read"] = isRead;
    _data["created_at"] = createdAt;
    return _data;
  }
}