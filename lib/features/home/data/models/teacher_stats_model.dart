
class TeacherStatsModel {
  String? message;
  int? status;
  Data? data;

  TeacherStatsModel({this.message, this.status, this.data});

  TeacherStatsModel.fromJson(Map<String, dynamic> json) {
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
  int? totalRates;
  int? averageRate;
  int? walletMoney;
  int? walletMinutes;
  String? currency;

  Data({this.totalRates, this.averageRate, this.walletMoney, this.walletMinutes, this.currency});

  Data.fromJson(Map<String, dynamic> json) {
    totalRates = json["total_rates"];
    averageRate = json["average_rate"];
    walletMoney = json["wallet_money"];
    walletMinutes = json["wallet_minutes"];
    currency = json["currency"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["total_rates"] = totalRates;
    _data["average_rate"] = averageRate;
    _data["wallet_money"] = walletMoney;
    _data["wallet_minutes"] = walletMinutes;
    _data["currency"] = currency;
    return _data;
  }
}