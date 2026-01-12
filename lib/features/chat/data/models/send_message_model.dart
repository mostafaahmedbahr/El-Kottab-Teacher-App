
class SendMessageModel {
  String? message;
  int? status;
  Data? data;

  SendMessageModel({this.message, this.status, this.data});

  SendMessageModel.fromJson(Map<String, dynamic> json) {
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
  int? conversationId;
  int? senderId;
  String? message;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data({this.conversationId, this.senderId, this.message, this.updatedAt, this.createdAt, this.id});

  Data.fromJson(Map<String, dynamic> json) {
    conversationId = json["conversation_id"];
    senderId = json["sender_id"];
    message = json["message"];
    updatedAt = json["updated_at"];
    createdAt = json["created_at"];
    id = json["id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["conversation_id"] = conversationId;
    _data["sender_id"] = senderId;
    _data["message"] = message;
    _data["updated_at"] = updatedAt;
    _data["created_at"] = createdAt;
    _data["id"] = id;
    return _data;
  }
}