
class ContactUsModel {
  String? message;
  int? status;
  Data? data;

  ContactUsModel({this.message, this.status, this.data});

  ContactUsModel.fromJson(Map<String, dynamic> json) {
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
  String? email;
  String? phone;
  String? title;
  String? message;
  String? country;
  String? createdAt;

  Data({this.id, this.email, this.phone, this.title, this.message, this.country, this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    email = json["email"];
    phone = json["phone"];
    title = json["title"];
    message = json["message"];
    country = json["country"];
    createdAt = json["created_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["email"] = email;
    _data["phone"] = phone;
    _data["title"] = title;
    _data["message"] = message;
    _data["country"] = country;
    _data["created_at"] = createdAt;
    return _data;
  }
}