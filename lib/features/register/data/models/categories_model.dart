class CategoriesModel {
  String? message;
  int? status;
  List<CategoryData>? data;

  CategoriesModel({this.message, this.status, this.data});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    message = json["message"];
    status = json["status"];
    data = json["data"] == null
        ? null
        : (json["data"] as List).map((e) => CategoryData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["message"] = message;
    _data["status"] = status;
    if (data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class CategoryData {
  int? id;
  String? name;

  CategoryData({this.id, this.name});
  CategoryData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    return _data;
  }
}
