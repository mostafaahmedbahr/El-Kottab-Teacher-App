
class GetPaymentMethodsModel {
  String? message;
  int? status;
  List<Data>? data;

  GetPaymentMethodsModel({this.message, this.status, this.data});

  GetPaymentMethodsModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  dynamic userId;
  String? methodType;
  dynamic phoneNumber;
  dynamic bankName;
  dynamic accountNumber;
  dynamic receiverName;
  bool? isDefault;
  String? createdAt;
  String? updatedAt;

  Data({this.id, this.userId, this.methodType, this.phoneNumber, this.bankName, this.accountNumber, this.receiverName, this.isDefault, this.createdAt, this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    userId = json["user_id"];
    methodType = json["method_type"];
    phoneNumber = json["phone_number"];
    bankName = json["bank_name"];
    accountNumber = json["account_number"];
    receiverName = json["receiver_name"];
    isDefault = json["is_default"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["user_id"] = userId;
    _data["method_type"] = methodType;
    _data["phone_number"] = phoneNumber;
    _data["bank_name"] = bankName;
    _data["account_number"] = accountNumber;
    _data["receiver_name"] = receiverName;
    _data["is_default"] = isDefault;
    _data["created_at"] = createdAt;
    _data["updated_at"] = updatedAt;
    return _data;
  }
}