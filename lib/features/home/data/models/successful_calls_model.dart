
class SuccessfulCallsModel {
  String? message;
  int? status;
  List<Data>? data;

  SuccessfulCallsModel({this.message, this.status, this.data});

  SuccessfulCallsModel.fromJson(Map<String, dynamic> json) {
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
  int? userId;
  int? teacherId;
  String? roomId;
  num? durationMinutes;
  String? status;
  String? startedAt;
  dynamic endedAt;
  String? createdAt;
  String? updatedAt;
  User? user;

  Data({this.id, this.userId, this.teacherId, this.roomId, this.durationMinutes, this.status, this.startedAt, this.endedAt, this.createdAt, this.updatedAt, this.user});

  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    userId = json["user_id"];
    teacherId = json["teacher_id"];
    roomId = json["room_id"];
    durationMinutes = json["duration_minutes"];
    status = json["status"];
    startedAt = json["started_at"];
    endedAt = json["ended_at"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    user = json["user"] == null ? null : User.fromJson(json["user"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["user_id"] = userId;
    _data["teacher_id"] = teacherId;
    _data["room_id"] = roomId;
    _data["duration_minutes"] = durationMinutes;
    _data["status"] = status;
    _data["started_at"] = startedAt;
    _data["ended_at"] = endedAt;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    if(user != null) {
      _data["user"] = user?.toJson();
    }
    return _data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? image;

  User({this.id, this.name, this.email, this.image});

  User.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    email = json["email"];
    image = json["image"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["email"] = email;
    _data["image"] = image;
    return _data;
  }
}