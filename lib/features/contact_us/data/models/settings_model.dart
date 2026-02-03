
class SettingsModel {
  String? message;
  int? status;
  Data? data;

  SettingsModel({this.message, this.status, this.data});

  SettingsModel.fromJson(Map<String, dynamic> json) {
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
  String? termsAndConditions;
  String? whoWeAre;
  String? facebookUrl;
  String? instagramUrl;
  String? twitterUrl;
  String? youtubeUrl;
  String? footerPhone;
  String? footerEmail;
  String? footerAddress;
  String? googlePlayUrl;
  String? appStoreUrl;
  String? refundPolicy;
  String? privacyPolicy;

  Data({this.termsAndConditions, this.whoWeAre, this.facebookUrl, this.instagramUrl, this.twitterUrl, this.youtubeUrl, this.footerPhone, this.footerEmail, this.footerAddress, this.googlePlayUrl, this.appStoreUrl, this.refundPolicy, this.privacyPolicy});

  Data.fromJson(Map<String, dynamic> json) {
    termsAndConditions = json["terms_and_conditions"];
    whoWeAre = json["who_we_are"];
    facebookUrl = json["facebook_url"];
    instagramUrl = json["instagram_url"];
    twitterUrl = json["twitter_url"];
    youtubeUrl = json["youtube_url"];
    footerPhone = json["footer_phone"];
    footerEmail = json["footer_email"];
    footerAddress = json["footer_address"];
    googlePlayUrl = json["google_play_url"];
    appStoreUrl = json["app_store_url"];
    refundPolicy = json["refund_policy"];
    privacyPolicy = json["privacy_policy"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["terms_and_conditions"] = termsAndConditions;
    _data["who_we_are"] = whoWeAre;
    _data["facebook_url"] = facebookUrl;
    _data["instagram_url"] = instagramUrl;
    _data["twitter_url"] = twitterUrl;
    _data["youtube_url"] = youtubeUrl;
    _data["footer_phone"] = footerPhone;
    _data["footer_email"] = footerEmail;
    _data["footer_address"] = footerAddress;
    _data["google_play_url"] = googlePlayUrl;
    _data["app_store_url"] = appStoreUrl;
    _data["refund_policy"] = refundPolicy;
    _data["privacy_policy"] = privacyPolicy;
    return _data;
  }
}