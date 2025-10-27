/// Model class for payment detail information.
class PaymentDetailModel {
  /// The payment amount.
  final String amount;

  /// The payment date.
  final String date;

  /// The payment time.
  final String time;

  /// Additional transaction details as key-value pairs.
  final Map<String, String> transactionDetails;

  /// Creates an instance of [PaymentDetailModel].
  PaymentDetailModel({
    required this.amount,
    required this.date,
    required this.time,
    required this.transactionDetails,
  });
}
