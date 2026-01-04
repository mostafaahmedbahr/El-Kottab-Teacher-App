
class WhoWeAreModel {
  String? message;
  int? status;
  Data? data;

  WhoWeAreModel({this.message, this.status, this.data});

  WhoWeAreModel.fromJson(Map<String, dynamic> json) {
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
  String? key;
  String? value;

  Data({this.key, this.value});

  Data.fromJson(Map<String, dynamic> json) {
    key = json["key"];
    value = json["value"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["key"] = key;
    _data["value"] = value;
    return _data;
  }
}