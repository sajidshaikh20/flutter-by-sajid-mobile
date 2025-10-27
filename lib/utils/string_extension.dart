import 'exports.dart';

/// Utility extensions for [String] and [String?] to simplify common checks,
/// validations, and conversions.
extension StringUtils on String? {
  /// Returns `true` if the string is `null` or empty.
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  /// Returns `true` if the string is not `null` and not empty.
  bool get isNotNullOrEmpty => !isNullOrEmpty;

  /// Returns `true` if the string is `null` or consists only of whitespace.
  bool get isBlank => this == null || this!.trim().isEmpty;
  /// Returns `true` if the string is not blank.
  bool get isNotBlank => !isBlank;

  /// Returns `true` if the string is `null` or blank.
  bool get isNullOrBlank => this == null || isBlank;

  /// Returns `true` if the string is not `null` or blank.
  bool get isNotNullOrBlank => !isNullOrBlank;

  /// Returns `true` if the string matches the password regex pattern.
  bool get isValidPassword =>
      RegExpressions.instance.password.hasMatch(this ?? '');

  /// Capitalizes the first character of the string.
  /// Returns an empty string if the value is `null`.
  String get toTitleCase =>
      this == null ? '' : '${this![0].toUpperCase()}${this!.substring(1)}';

  /// Encodes the string to Base64 format.
  String get toBase64 => base64Encode(utf8.encode(this ?? ''));

  /// Decodes the Base64-encoded string into a [Uint8List].
  Uint8List get fromBase64 => base64Decode(this ?? '');
}

/// Extension methods for lists of strings.
extension ListUtil on List<String> {
  /// Joins the list into a comma-separated string.
  String get joinToString => reduce((String curr, String next) => '$curr,$next');

  /// Joins the list into a single string without any delimiter.
  String get joinToWithOutComaString =>
      reduce((String curr, String next) => '$curr$next');
}

/// Extensions for validating text field inputs such as email, password, and mobile numbers.
extension TextFieldValidator on String {
  /// Validates a password string based on regex criteria.
  /// Returns an error message if invalid, otherwise an empty string.
  String? validatePassword({
    bool isNewPassword = false,
    String? customError,
    required String emptyPasswordMsg,
    required String invalidPasswordMsg,
  }) {
    if (isEmpty) {
      return isNewPassword
          ? (customError ?? emptyPasswordMsg)
          : emptyPasswordMsg;
    } else if (RegExp(r'\s').hasMatch(this)) {
      // Disallow any whitespace anywhere in password
      return invalidPasswordMsg;
    } else if (!RegExpressions.instance.password.hasMatch(this)) {
      return invalidPasswordMsg;
    }
    return "";
  }

  /// Validates password and returns a boolean result.
  bool? validatePasswordBool() {
    if (isEmpty) return false;
    if (RegExp(r'\s').hasMatch(this)) return false;
    return RegExpressions.instance.password.hasMatch(this);
  }

  /// Returns `true` if the string starts with a number.
  bool startsWithNumber() => RegExpressions.instance.startsWithNumber.hasMatch(this);

  /// Returns `true` if the string starts with a letter.
  bool startsWithLetter() => RegExpressions.instance.startsWithLetter.hasMatch(this);

  /// Returns `true` if the string contains at least one letter or non-word character.
  bool containsChar() => RegExpressions.instance.containsChar.hasMatch(this);

  /// Returns `true` if the string contains at least one numeric digit.
  bool findInNumber() => RegExpressions.instance.findInNumber.hasMatch(this);

  /// Checks if the string is in a valid email format.
  bool isValidEmail() => RegExpressions.instance.simpleEmail.hasMatch(trim());

  /// Validates password using multiple criteria such as length, uppercase, lowercase, number, and special character.
  String? validatePassword1({
    bool isNewPassword = false,
    String? customError,
    required String emptyPasswordMsg,
    required String invalidPasswordMsg,
  }) {
    if (isEmpty) {
      return isNewPassword
          ? (customError ?? emptyPasswordMsg)
          : emptyPasswordMsg;
    }

    // Check length criteria
    if (length < 6 || length > 15) {
      return invalidPasswordMsg;
    }

    // Disallow any whitespace anywhere in password
    if (RegExp(r'\s').hasMatch(this)) {
      return invalidPasswordMsg;
    }

    // Check all required password conditions
    if (!RegExpressions.instance.passwordUppercase.hasMatch(this) ||
        !RegExpressions.instance.passwordLowercase.hasMatch(this) ||
        !RegExpressions.instance.passwordDigit.hasMatch(this) ||
        !RegExpressions.instance.passwordSpecialChar.hasMatch(this)) {
      return invalidPasswordMsg;
    }

    return "";
  }


  /// Validates password with strict criteria and returns a boolean.
  bool? validatePassBool() {
    if (isEmpty ||
        length < 6 ||
        length > 15 ||
        RegExp(r'\s').hasMatch(this) ||
        !RegExpressions.instance.passwordUppercase.hasMatch(this) ||
        !RegExpressions.instance.passwordLowercase.hasMatch(this) ||
        !RegExpressions.instance.passwordDigit.hasMatch(this) ||
        !RegExpressions.instance.passwordSpecialChar.hasMatch(this)) {
      return false;
    }
    return true;
  }

  /// Validates an email address and returns an error message or empty string if valid.
  /// Comprehensive validation covering all invalid email patterns.
  String? validateEmail({
    bool isOnlyEmail = false,
    required String enterMobileOrNumberMsg,
    required String enterEmailMsg,
    required String validEmailMsg,
  }) {
    if (isEmpty) {
      return !isOnlyEmail ? enterMobileOrNumberMsg : enterEmailMsg;
    }

    final String trimmedEmail = trim();
    
    // Check if email starts with dot - this should be caught first
    if (trimmedEmail.startsWith('.')) {
      return validEmailMsg; // Email starts with dot
    }
    
    // Check for basic email structure (must contain @ and .)
    if (!trimmedEmail.contains('@') || !trimmedEmail.contains('.')) {
      return validEmailMsg;
    }

    // Split email into local part and domain
    final List<String> parts = trimmedEmail.split('@');
    if (parts.length != 2) {
      return validEmailMsg;
    }

    final String localPart = parts[0];
    final String domain = parts[1];

    // Validate local part (before @)
    if (localPart.isEmpty) {
      return validEmailMsg; // Missing local part
    }

    // Check for spaces in local part
    if (localPart.contains(' ')) {
      return validEmailMsg; // Space in email
    }

    // Check if local part starts or ends with dot
    if (localPart.startsWith('.') || localPart.endsWith('.')) {
      return validEmailMsg; // Local part starts/ends with dot
    }

    // Check for consecutive dots in local part
    if (localPart.contains('..')) {
      return validEmailMsg; // Consecutive dots in local part
    }

    // Validate domain part (after @)
    if (domain.isEmpty) {
      return validEmailMsg; // Missing domain
    }

    // Check if domain starts with dot or hyphen
    if (domain.startsWith('.') || domain.startsWith('-')) {
      return validEmailMsg; // Domain starts with dot or hyphen
    }

    // Check if domain ends with dot
    if (domain.endsWith('.')) {
      return validEmailMsg; // Domain ends with dot
    }

    // Check for consecutive dots in domain
    if (domain.contains('..')) {
      return validEmailMsg; // Consecutive dots in domain
    }

    // Check for invalid characters in domain (comma, #, etc.)
    if (domain.contains(',') || domain.contains('#') || domain.contains(' ')) {
      return validEmailMsg; // Invalid characters in domain
    }

    // Split domain into name and TLD
    final List<String> domainParts = domain.split('.');
    if (domainParts.length < 2) {
      return validEmailMsg; // Missing TLD
    }

    final String domainName = domainParts[0];
    final String tld = domainParts.last;

    // Validate domain name
    if (domainName.isEmpty) {
      return validEmailMsg; // Domain name missing
    }

    // Validate TLD (Top Level Domain)
    if (tld.isEmpty) {
      return validEmailMsg; // TLD missing
    }

    if (tld.length < 2) {
      return validEmailMsg; // TLD too short (must be at least 2 characters)
    }

    if (tld.length > 63) {
      return validEmailMsg; // TLD too long (max 63 characters)
    }

    // Check for invalid characters in TLD
    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(tld)) {
      return validEmailMsg; // TLD contains invalid characters
    }

    // Final regex validation
    if (!RegExpressions.instance.email.hasMatch(trimmedEmail)) {
      return validEmailMsg;
    }

    return "";
  }


  /// Validates an email address and returns a boolean result.
  /// Uses the same comprehensive validation as validateEmail.
  bool? validateEmailBool() {
    if (isEmpty) return false;
    
    final String trimmedEmail = trim();
    
    // Check if email starts with dot - this should be caught first
    if (trimmedEmail.startsWith('.')) {
      return false; // Email starts with dot
    }
    
    // Check for basic email structure (must contain @ and .)
    if (!trimmedEmail.contains('@') || !trimmedEmail.contains('.')) {
      return false;
    }

    // Split email into local part and domain
    final List<String> parts = trimmedEmail.split('@');
    if (parts.length != 2) {
      return false;
    }

    final String localPart = parts[0];
    final String domain = parts[1];

    // Validate local part (before @)
    if (localPart.isEmpty) {
      return false; // Missing local part
    }

    // Check for spaces in local part
    if (localPart.contains(' ')) {
      return false; // Space in email
    }

    // Check if local part starts or ends with dot
    if (localPart.startsWith('.') || localPart.endsWith('.')) {
      return false; // Local part starts/ends with dot
    }

    // Check for consecutive dots in local part
    if (localPart.contains('..')) {
      return false; // Consecutive dots in local part
    }

    // Validate domain part (after @)
    if (domain.isEmpty) {
      return false; // Missing domain
    }

    // Check if domain starts with dot or hyphen
    if (domain.startsWith('.') || domain.startsWith('-')) {
      return false; // Domain starts with dot or hyphen
    }

    // Check if domain ends with dot
    if (domain.endsWith('.')) {
      return false; // Domain ends with dot
    }

    // Check for consecutive dots in domain
    if (domain.contains('..')) {
      return false; // Consecutive dots in domain
    }

    // Check for invalid characters in domain (comma, #, etc.)
    if (domain.contains(',') || domain.contains('#') || domain.contains(' ')) {
      return false; // Invalid characters in domain
    }

    // Split domain into name and TLD
    final List<String> domainParts = domain.split('.');
    if (domainParts.length < 2) {
      return false; // Missing TLD
    }

    final String domainName = domainParts[0];
    final String tld = domainParts.last;

    // Validate domain name
    if (domainName.isEmpty) {
      return false; // Domain name missing
    }

    // Validate TLD (Top Level Domain)
    if (tld.isEmpty) {
      return false; // TLD missing
    }

    if (tld.length < 2) {
      return false; // TLD too short (must be at least 2 characters)
    }

    if (tld.length > 63) {
      return false; // TLD too long (max 63 characters)
    }

    // Check for invalid characters in TLD
    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(tld)) {
      return false; // TLD contains invalid characters
    }

    // Final regex validation
    return RegExpressions.instance.email.hasMatch(trimmedEmail);
  }

  /// Validates OTP code format and returns an error message if invalid.
  String? validateOtpCode({
    required String emptyOrInvalidOtpMsg,
  }) {
    if (isEmpty || length != AppConstant.otpTextLength) {
      return emptyOrInvalidOtpMsg;
    }
    return null;
  }


  /// Validates if a string is empty and returns a custom message.
  String? validateTextIsEmpty(String message) {
    if (isEmpty) return message;
    return "";
  }

  /// Validates rating comments for minimum length.
  String? validateRating({
    required String emptyRatingMsg,
    required String shortReviewMsg,
  }) {
    if (isEmpty) {
      return emptyRatingMsg;
    } else if (length < 10) {
      return shortReviewMsg;
    }
    return null;
  }


  /// Validates a mobile number format and returns an error message if invalid.
  String? validMobileNo({
    bool isRequired = true,
    required String emptyMobileMsg,
    required String onlyNumbersAllowedMsg,
    required String invalidMobileMsg,
  }) {
    if (isRequired) {
      if (isEmpty) {
        return emptyMobileMsg;
      } else if (!RegExpressions.instance.onlyNumbersPattern.hasMatch(this)) {
        return onlyNumbersAllowedMsg;
      } else if (!contains(RegExpressions.instance.phoneNumber)) {
        return invalidMobileMsg;
      }
      return "";
    } else {
      if (isNotEmpty) {
        if (!RegExpressions.instance.onlyNumbersPattern.hasMatch(this)) {
          return onlyNumbersAllowedMsg;
        } else if (!contains(RegExpressions.instance.phoneNumber)) {
          return invalidMobileMsg;
        }
      }
      return "";
    }
  }

  /// Validates a mobile number and returns a boolean result.
  bool validMobileBool({bool? isRequired}) {
    if (isRequired ?? true) {
      if (isEmpty || !contains(RegExpressions.instance.phoneNumber)) {
        return false;
      }
      return true;
    } else {
      if (isNotEmpty && !contains(RegExpressions.instance.phoneNumber)) {
        return false;
      }
      return true;
    }
  }

  /// Validates that the field is not empty, returning a custom error message if empty.
  String? validateEmptyField({String? errorMessage}) {
    if (trim().isEmpty) return errorMessage;
    return null;
  }

  /// Validates first and last name fields for non-empty values.
  dynamic validateFirstLastNameField(
      {String? errorMessage, String? lengthErrorMessage}) {
    if (trim().isEmpty) return errorMessage;
    return true;
  }

  /// Validates mobile number field with optional custom error messages.
  String? validateMobileField(
      {String? emptyErrorMessage, String? lengthErrorMessage}) {
    if (trim().isEmpty) {
      return emptyErrorMessage;
    }
    if (length < AppConstant.minLengthMobileNumber ||
        length > AppConstant.maxLengthMobileNumber) {
      return lengthErrorMessage;
    }
    return null;
  }

  /// Converts the string into title case for each word.
  String get toTitleCaseConvert {
    if (isEmpty) return this;
    return split(' ')
        .map((String word) =>
    word.isEmpty ? word : word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');
  }
}
