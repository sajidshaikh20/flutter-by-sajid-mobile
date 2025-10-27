/// Model class for wallet transaction data.
class WalletTransaction {
  /// The unique identifier for the transaction.
  final String transactionId;

  /// The description of the transaction.
  final String description;

  /// The number of points involved in the transaction.
  final String points;

  /// The title/label for points.
  final String pointsTitle;

  /// The date and time of the transaction.
  final String dateTime;

  /// The location where the transaction occurred.
  final String location;

  /// The type of transaction (gained or burned).
  final TransactionType transactionType;

  /// Creates an instance of [WalletTransaction].
  WalletTransaction({
    required this.transactionId,
    required this.description,
    required this.points,
    required this.dateTime,
    required this.location,
    this.pointsTitle = "points",
    this.transactionType = TransactionType.gained,
  });
}

/// Enum representing the type of wallet transaction.
enum TransactionType {
  /// Points were gained/earned.
  gained,

  /// Points were burned/spent.
  burned
}
