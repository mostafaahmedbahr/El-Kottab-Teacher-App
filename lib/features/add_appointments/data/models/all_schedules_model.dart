
class AllSchedulesModel {
  String? message;
  int? status;
  List<Data>? data;

  AllSchedulesModel({this.message, this.status, this.data});

  AllSchedulesModel.fromJson(Map<String, dynamic> json) {
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