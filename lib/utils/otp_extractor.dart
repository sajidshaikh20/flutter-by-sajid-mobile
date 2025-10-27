/// Utility class to extract OTP from various message formats
class OtpExtractor {
  /// Extracts OTP from a message string
  /// Supports various formats like:
  /// - "Your OTP is 1234"
  /// - "OTP: 1234"
  /// - "1234"
  /// - "OTP sent: 1234"
  ///
  OtpExtractor._();
  /// Extracts OTP from a message string
  /// Supports various formats like:
  /// - "Your OTP is 1234"
  /// - "OTP: 1234"
  /// - "1234"
  /// - "OTP
  static String? extractOtpFromMessage(String message) {
    if (message.isEmpty) return null;
    
    // Look for 4-digit sequences (word boundaries)
    final RegExp otpRegex = RegExp(r'\b\d{4}\b');
    final Match? match = otpRegex.firstMatch(message);
    
    if (match != null) {
      final String otp = match.group(0)!;
      return otp;
    }
    
    // If no match found, try to find any sequence of exactly 4 digits
    final RegExp anyDigitRegex = RegExp(r'\d{4}');
    final Match? anyMatch = anyDigitRegex.firstMatch(message);
    
    if (anyMatch != null) {
      final String otp = anyMatch.group(0)!;
      return otp;
    }
    return null;
  }
  
  /// Checks if a message contains an OTP
  static bool containsOtp(String message) {
    return extractOtpFromMessage(message) != null;
  }
}
