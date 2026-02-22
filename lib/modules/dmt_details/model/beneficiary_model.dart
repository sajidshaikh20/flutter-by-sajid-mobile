/// Model for a beneficiary account in DMT flow.
class BeneficiaryModel {
  const BeneficiaryModel({
    required this.name,
    required this.bank,
    required this.ifsc,
    required this.accountNumber,
    this.isActive = true,
    this.id,
  });

  /// Unique id (optional, for list keys / API).
  final String? id;

  /// Beneficiary or account holder name.
  final String name;

  /// Bank name.
  final String bank;

  /// IFSC code.
  final String ifsc;

  /// Account number.
  final String accountNumber;

  /// Whether the beneficiary is active (green pill) or inactive (red pill).
  final bool isActive;

  BeneficiaryModel copyWith({
    String? id,
    String? name,
    String? bank,
    String? ifsc,
    String? accountNumber,
    bool? isActive,
  }) =>
      BeneficiaryModel(
        id: id ?? this.id,
        name: name ?? this.name,
        bank: bank ?? this.bank,
        ifsc: ifsc ?? this.ifsc,
        accountNumber: accountNumber ?? this.accountNumber,
        isActive: isActive ?? this.isActive,
      );
}
