
class AddPaymentMethodModel {
  String? message;
  int? status;
  Data? data;

  AddPaymentMethodModel({this.message, this.status, this.data});

  AddPaymentMethodModel.fromJson(Map<String, dynamic> json) {
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
  int? userId;
  String? methodType;
  dynamic phoneNumber;
  dynamic bankName;
  dynamic accountNumber;
  dynamic receiverName;
  bool? isDefault;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data({this.userId, this.methodType, this.phoneNumber, this.bankName, this.accountNumber, this.receiverName, this.isDefault, this.updatedAt, this.createdAt, this.id});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json["user_id"];
    methodType = json["method_type"];
    phoneNumber = json["phone_number"];
    bankName = json["bank_name"];
    accountNumber = json["account_number"];
    receiverName = json["receiver_name"];
    isDefault = json["is_default"];
    updatedAt = json["updated_at"];
    createdAt = json["created_at"];
    id = json["id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["user_id"] = userId;
    _data["method_type"] = methodType;
    _data["phone_number"] = phoneNumber;
    _data["bank_name"] = bankName;
    _data["account_number"] = accountNumber;
    _data["receiver_name"] = receiverName;
    _data["is_default"] = isDefault;
    _data["updated_at"] = updatedAt;
    _data["created_at"] = createdAt;
    _data["id"] = id;
    return _data;
  }
}