
class HomeBannersModel {
  String? message;
  int? status;
  List<Data>? data;

  HomeBannersModel({this.message, this.status, this.data});

  HomeBannersModel.fromJson(Map<String, dynamic> json) {
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
  String? image;
  String? description;

  Data({this.image,this.description});

  Data.fromJson(Map<String, dynamic> json) {
    image = json["image"];
    description = json["description"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["image"] = image;
    _data["description"] = description;
    return _data;
  }
}