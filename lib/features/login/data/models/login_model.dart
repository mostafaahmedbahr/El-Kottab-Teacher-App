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
    if (data != null) {
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
  dynamic description;
  String? type;
  dynamic avaliable;
  String? role;
  bool? isVerified;
  dynamic token;
  String? categoryId;
  dynamic attachments;
  String? country;

  Data({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.gender,
    this.image,
    this.description,
    this.type,
    this.avaliable,
    this.role,
    this.isVerified,
    this.token,
    this.categoryId,
    this.attachments,
    this.country,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    gender: json["gender"],
    image: json["image"],
    description: json["description"],
    type: json["type"],
    avaliable: json["avaliable"],
    role: json["role"],
    isVerified: json["is_verified"],
    token: json["token"],
    categoryId: json["category_id"],
    attachments: json["attachments"],
    country: json["country"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "gender": gender,
    "image": image,
    "description": description,
    "type": type,
    "avaliable": avaliable,
    "role": role,
    "is_verified": isVerified,
    "token": token,
    "category_id": categoryId,
    "attachments": attachments,
    "country": country,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Data && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
