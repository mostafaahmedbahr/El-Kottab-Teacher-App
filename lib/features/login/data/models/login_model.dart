
class LoginModel {
  String? message;
  int? status;
  Data? data;

  LoginModel({this.message, this.status, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
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
  Image? image;
  dynamic description;
  String? type;
  dynamic avaliable;
  String? role;
  String? token;
  String? categoryId;
  dynamic attachments;

  Data({this.id, this.name, this.email, this.phone, this.gender, this.image, this.description, this.type, this.avaliable, this.role, this.token, this.categoryId, this.attachments});

  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    email = json["email"];
    phone = json["phone"];
    gender = json["gender"];
    image = json["image"] == null ? null : Image.fromJson(json["image"]);
    description = json["description"];
    type = json["type"];
    avaliable = json["avaliable"];
    role = json["role"];
    token = json["token"];
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
    if(image != null) {
      _data["image"] = image?.toJson();
    }
    _data["description"] = description;
    _data["type"] = type;
    _data["avaliable"] = avaliable;
    _data["role"] = role;
    _data["token"] = token;
    _data["category_id"] = categoryId;
    _data["attachments"] = attachments;
    return _data;
  }
}

class Image {
  Image();

  Image.fromJson(Map<String, dynamic> json) {

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};

    return _data;
  }
}