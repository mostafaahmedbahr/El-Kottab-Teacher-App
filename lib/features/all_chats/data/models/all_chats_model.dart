
class AllChatsModel {
  String? message;
  int? status;
  List<Data>? data;

  AllChatsModel({this.message, this.status, this.data});

  AllChatsModel.fromJson(Map<String, dynamic> json) {
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
  OtherUser? otherUser;
  LastMessage? lastMessage;
  String? createdAt;

  Data({this.id, this.otherUser, this.lastMessage, this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    otherUser = json["other_user"] == null ? null : OtherUser.fromJson(json["other_user"]);
    lastMessage = json["last_message"] == null ? null : LastMessage.fromJson(json["last_message"]);
    createdAt = json["created_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    if(otherUser != null) {
      _data["other_user"] = otherUser?.toJson();
    }
    if(lastMessage != null) {
      _data["last_message"] = lastMessage?.toJson();
    }
    _data["created_at"] = createdAt;
    return _data;
  }
}

class LastMessage {
  int? id;
  String? message;
  String? senderRole;
  String? isRead;
  String? createdAt;

  LastMessage({this.id, this.message, this.senderRole, this.isRead, this.createdAt});

  LastMessage.fromJson(Map<String, dynamic> json) {
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

class OtherUser {
  int? id;
  String? name;
  String? image;
  List<String>? languages;
  String? category;
  String? phone;
  int? rate;
  bool? isFav;

  OtherUser({this.id, this.name, this.image, this.languages, this.category, this.phone, this.rate, this.isFav});

  OtherUser.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    image = json["image"];
    languages = json["languages"] == null ? null : List<String>.from(json["languages"]);
    category = json["category"];
    phone = json["phone"];
    rate = json["rate"];
    isFav = json["is_fav"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["image"] = image;
    if(languages != null) {
      _data["languages"] = languages;
    }
    _data["category"] = category;
    _data["phone"] = phone;
    _data["rate"] = rate;
    _data["is_fav"] = isFav;
    return _data;
  }
}