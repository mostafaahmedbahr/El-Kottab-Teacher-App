
class AllMessagesModel {
  String? message;
  int? status;
  List<Data>? data;

  AllMessagesModel({this.message, this.status, this.data});

  AllMessagesModel.fromJson(Map<String, dynamic> json) {
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
  String? message;
  String? senderRole;
  String? isRead;
  String? createdAt;

  Data({this.id, this.message, this.senderRole, this.isRead, this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    message = json["message"];
    senderRole = json["sender_role"];
    isRead = json["is_read"];
    createdAt = json["created_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["message"] = message;
    _data["sender_role"] = senderRole;
    _data["is_read"] = isRead;
    _data["created_at"] = createdAt;
    return _data;
  }
}