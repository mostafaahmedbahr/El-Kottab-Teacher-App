
class UpdateScheduleModel {
  String? message;
  int? status;
  Data? data;

  UpdateScheduleModel({this.message, this.status, this.data});

  UpdateScheduleModel.fromJson(Map<String, dynamic> json) {
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
  String? day;
  String? from;
  String? to;

  Data({this.id, this.day, this.from, this.to});

  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    day = json["day"];
    from = json["from"];
    to = json["to"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["day"] = day;
    _data["from"] = from;
    _data["to"] = to;
    return _data;
  }
}