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
    if (data != null) {
      _data["data"] = data?.toJson();
    }
    return _data;
  }
}

class Data {
  dynamic totalRates;
  dynamic averageRate;
  dynamic walletMoney;
  dynamic walletMinutes;
  String? currency;

  Data({
    this.totalRates,
    this.averageRate,
    this.walletMoney,
    this.walletMinutes,
    this.currency,
  });

  Data.fromJson(Map<String, dynamic> json) {
    totalRates = json["total_rates"];

    averageRate = json["average_rate"];
    walletMoney = json["wallet_money"];

    walletMinutes = json["wallet_minutes"];
    currency = json["currency"]?.toString();
  }

  Map<String, dynamic> toJson() {
    return {
      "total_rates": totalRates,
      "average_rate": averageRate,
      "wallet_money": walletMoney,
      "wallet_minutes": walletMinutes,
      "currency": currency,
    };
  }
}
