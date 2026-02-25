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
  int? conversationId;
  int? senderId;
  String? message;
  String? senderRole;
  String? isRead;
  String? createdAt;
  String? updatedAt;

  MessageData({
    this.id,
    this.conversationId,
    this.senderId,
    this.message,
    this.senderRole,
    this.isRead,
    this.createdAt,
    this.updatedAt,
  });

  MessageData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    conversationId = json["conversation_id"];
    senderId = json["sender_id"];
    message = json["message"];
    senderRole = json["sender_role"];
    isRead = json["is_read"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "conversation_id": conversationId,
      "sender_id": senderId,
      "message": message,
      "sender_role": senderRole,
      "is_read": isRead,
      "created_at": createdAt,
      "updated_at": updatedAt,
    };
  }
}
