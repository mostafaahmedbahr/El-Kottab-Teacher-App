
class ProfileModel {
  String? message;
  int? status;
  Data? data;

  ProfileModel({this.message, this.status, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
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
  dynamic image;
  dynamic description;
  String? type;
  dynamic avaliable;
  String? role;
  String? categoryId;
  dynamic attachments;
  dynamic language;
  String? country;
  Plan? plan;
  int? currentMinutes;
  String? planExpiredAt;
  int? daysLeft;

  Data({this.id, this.name, this.email, this.phone, this.gender, this.image, this.description, this.type, this.avaliable, this.role, this.categoryId, this.attachments, this.language, this.country, this.plan, this.currentMinutes, this.planExpiredAt, this.daysLeft});

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
    language = json["language"];
    country = json["country"];
    plan = json["plan"] == null ? null : Plan.fromJson(json["plan"]);
    currentMinutes = json["current_minutes"];
    planExpiredAt = json["plan_expired_at"];
    daysLeft = json["days_left"];
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
    _data["language"] = language;
    _data["country"] = country;
    if(plan != null) {
      _data["plan"] = plan?.toJson();
    }
    _data["current_minutes"] = currentMinutes;
    _data["plan_expired_at"] = planExpiredAt;
    _data["days_left"] = daysLeft;
    return _data;
  }
}

class Plan {
  int? id;
  String? name;
  int? minutes;
  int? validDays;
  int? priceInDolar;
  int? priceInEgp;
  bool? hasDiscount;
  int? discount;
  double? discountPriceDolar;
  int? discountPriceEgp;
  List<Categories>? categories;
  bool? isSubscribed;
  String? createdAt;
  String? updatedAt;

  Plan({this.id, this.name, this.minutes, this.validDays, this.priceInDolar, this.priceInEgp, this.hasDiscount, this.discount, this.discountPriceDolar, this.discountPriceEgp, this.categories, this.isSubscribed, this.createdAt, this.updatedAt});

  Plan.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    minutes = json["minutes"];
    validDays = json["valid_days"];
    priceInDolar = json["price_in_dolar"];
    priceInEgp = json["price_in_egp"];
    hasDiscount = json["has_discount"];
    discount = json["discount"];
    discountPriceDolar = json["discount_price_dolar"];
    discountPriceEgp = json["discount_price_egp"];
    categories = json["categories"] == null ? null : (json["categories"] as List).map((e) => Categories.fromJson(e)).toList();
    isSubscribed = json["is_subscribed"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["minutes"] = minutes;
    _data["valid_days"] = validDays;
    _data["price_in_dolar"] = priceInDolar;
    _data["price_in_egp"] = priceInEgp;
    _data["has_discount"] = hasDiscount;
    _data["discount"] = discount;
    _data["discount_price_dolar"] = discountPriceDolar;
    _data["discount_price_egp"] = discountPriceEgp;
    if(categories != null) {
      _data["categories"] = categories?.map((e) => e.toJson()).toList();
    }
    _data["is_subscribed"] = isSubscribed;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    return _data;
  }
}class Categories {
  int? id;
  String? nameAr;
  String? nameEn;

  Categories({this.id, this.nameAr, this.nameEn});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    nameAr = json["name_ar"];
    nameEn = json["name_en"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name_ar"] = nameAr;
    _data["name_en"] = nameEn;
    return _data;
  }
}