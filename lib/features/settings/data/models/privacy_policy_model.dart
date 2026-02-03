
class PrivacyPolicyModel {
  String? message;
  int? status;
  Data? data;

  PrivacyPolicyModel({this.message, this.status, this.data});

  PrivacyPolicyModel.fromJson(Map<String, dynamic> json) {
    message = json["message"];
    status = (json["status"] as num).toInt();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data["key"] = key;
    data["value"] = value;
    return data;
  }
}