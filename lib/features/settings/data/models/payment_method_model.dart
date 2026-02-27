import '../../../../core/utils/enums.dart';

class PaymentMethodModel {
  final PaymentType type;
  bool isActive;
  Map<String, String>? data;

  PaymentMethodModel({
    required this.type,
    this.isActive = false,
    this.data,
  });
}