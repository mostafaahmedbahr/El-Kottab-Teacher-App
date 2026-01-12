
class EditProfileInfoModel {
  String? message;
  int? status;
  Data? data;

  EditProfileInfoModel({this.message, this.status, this.data});

  EditProfileInfoModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? email;
  String? phone;
  String? gender;
  String? image;
  String? description;
  String? type;
  dynamic avaliable;
  String? role;
  String? categoryId;
  dynamic attachments;

  Data({this.id, this.name, this.email, this.phone, this.gender, this.image, this.description, this.type, this.avaliable, this.role, this.categoryId, this.attachments});

  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    email = json["email"];
    phone = json["phone"];
    gender = json["gender"];
    image = json["image"];
    description = json["description"];
    type = json["type"];
    avaliable = json["avaliable"];
    role = json["role"];
    categoryId = json["category_id"];
    attachments = json["attachments"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["email"] = email;
    _data["phone"] = phone;
    _data["gender"] = gender;
    _data["image"] = image;
    _data["description"] = description;
    _data["type"] = type;
    _data["avaliable"] = avaliable;
    _data["role"] = role;
    _data["category_id"] = categoryId;
    _data["attachments"] = attachments;
    return _data;
  }
}