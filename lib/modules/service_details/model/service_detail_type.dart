/// Enum for banking services that have a dedicated details flow.
/// Used to navigate to the correct service details screen.
enum ServiceDetailType {
  /// AEPS Aadhaar Pay flow.
  aepsAadhaarPay,

  /// DMT (Domestic Money Transfer) flow.
  dmt,
}

/// Extension to get display label for [ServiceDetailType].
extension ServiceDetailTypeExtension on ServiceDetailType {
  /// Display label for the service details screen app bar.
  String get displayLabel {
    switch (this) {
      case ServiceDetailType.aepsAadhaarPay:
        return 'AEPS';
      case ServiceDetailType.dmt:
        return 'DMT';
    }
  }
}
