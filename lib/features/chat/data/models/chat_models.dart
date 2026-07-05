class AllMessagesModel {
  String? message;
  int? status;
  List<MessageData>? data;

  AllMessagesModel({this.message, this.status, this.data});

  AllMessagesModel.fromJson(Map<String, dynamic> json) {
    message = json["message"];
    status = json["status"];
    data = json["data"] == null
        ? []
        : (json["data"] as List).map((e) => MessageData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      "message": message,
      "status": status,
      "data": data?.map((e) => e.toJson()).toList(),
    };
  }
}

class SendMessageModel {
  String? message;
  int? status;
  MessageData? data;

  SendMessageModel({this.message, this.status, this.data});

  SendMessageModel.fromJson(Map<String, dynamic> json) {
    message = json["message"];
    status = json["status"];
    data = json["data"] == null ? null : MessageData.fromJson(json["data"]);
  }

  Map<String, dynamic> toJson() {
    return {"message": message, "status": status, "data": data?.toJson()};
  }
}

class MessageData {
  int? id;
  String? message;
  String? senderId;
  String? senderRole;
  String? isRead;
  String? createdAt;

  MessageData({
    this.id,
    this.senderId,
    this.message,
    this.senderRole,
    this.isRead,
    this.createdAt,
  });

  // Fix: API returns sender_id, sender_role, is_read as int, but model expects String → used .toString()
  MessageData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    senderId = json["sender_id"]?.toString();
    message = json["message"];
    senderRole = json["sender_role"]?.toString();
    isRead = json["is_read"]?.toString();
    createdAt = json["created_at"];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "sender_id": senderId,
      "message": message,
      "sender_role": senderRole,
      "is_read": isRead,
      "created_at": createdAt,
    };
  }
}
