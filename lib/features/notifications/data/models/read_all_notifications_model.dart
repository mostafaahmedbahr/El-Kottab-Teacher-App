
class ReadAllNotificationsModel {
  String? message;
  int? status;
  Data? data;

  ReadAllNotificationsModel({this.message, this.status, this.data});

  ReadAllNotificationsModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? title;
  String? body;
  bool? isRead;
  String? createdAt;
  String? updatedAt;

  Data({this.id, this.title, this.body, this.isRead, this.createdAt, this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    body = json["body"];
    isRead = json["is_read"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["title"] = title;
    data["body"] = body;
    data["is_read"] = isRead;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    return data;
  }
}