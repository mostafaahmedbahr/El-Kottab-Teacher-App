
class StartCallModel {
  String? message;
  int? status;
  Data? data;

  StartCallModel({this.message, this.status, this.data});

  StartCallModel.fromJson(Map<String, dynamic> json) {
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
  int? userId;
  String? teacherId;
  String? roomId;
  String? status;
  String? startedAt;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data({this.userId, this.teacherId, this.roomId, this.status, this.startedAt, this.updatedAt, this.createdAt, this.id});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json["user_id"];
    teacherId = json["teacher_id"];
    roomId = json["room_id"];
    status = json["status"];
    startedAt = json["started_at"];
    updatedAt = json["updated_at"];
    createdAt = json["created_at"];
    id = json["id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["user_id"] = userId;
    _data["teacher_id"] = teacherId;
    _data["room_id"] = roomId;
    _data["status"] = status;
    _data["started_at"] = startedAt;
    _data["updated_at"] = updatedAt;
    _data["created_at"] = createdAt;
    _data["id"] = id;
    return _data;
  }
}