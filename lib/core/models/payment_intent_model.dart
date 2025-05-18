class PaymentIntentModel {
  String clientSecret;
  String ephermKey;
  String customerId;
  PaymentIntentModel({
    required this.clientSecret,
    required this.ephermKey,
    required this.customerId,
  });
}