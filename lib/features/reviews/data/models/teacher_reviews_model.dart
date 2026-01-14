
class TeacherReviewsModel {
  String? message;
  int? status;
  List<Data>? data;
  int? avgRate;
  int? totalCount;
  bool? hasMorePages;

  TeacherReviewsModel({this.message, this.status, this.data, this.avgRate, this.totalCount, this.hasMorePages});

  TeacherReviewsModel.fromJson(Map<String, dynamic> json) {
    message = json["message"];
    status = json["status"];
    data = json["data"] == null ? null : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
    avgRate = json["avgRate"];
    totalCount = json["totalCount"];
    hasMorePages = json["hasMorePages"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["message"] = message;
    _data["status"] = status;
    if(data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    _data["avgRate"] = avgRate;
    _data["totalCount"] = totalCount;
    _data["hasMorePages"] = hasMorePages;
    return _data;
  }
}

class Data {
  int? rate;
  String? comment;
  User? user;

  Data({this.rate, this.comment, this.user});

  Data.fromJson(Map<String, dynamic> json) {
    rate = json["rate"];
    comment = json["comment"];
    user = json["user"] == null ? null : User.fromJson(json["user"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["rate"] = rate;
    _data["comment"] = comment;
    if(user != null) {
      _data["user"] = user?.toJson();
    }
    return _data;
  }
}

class User {
  String? name;
  String? image;

  User({this.name, this.image});

  User.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    image = json["image"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["name"] = name;
    _data["image"] = image;
    return _data;
  }
}