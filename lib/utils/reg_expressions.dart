import 'exports.dart';


/// A singleton class that provides commonly used regular expressions
/// for validating input fields such as email, password, phone number, etc.
class RegExpressions {
  /// The singleton instance of [RegExpressions] provided by dependency injection.
  static RegExpressions instance = getIt<RegExpressions>();

  /// Validates a password that contains:
  /// - At least one lowercase letter
  /// - At least one uppercase letter
  /// - At least one digit
  /// - At least one special character
  /// - Minimum 6 characters
  final RegExp password = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z\d])[A-Za-z\d\W]{6,}$',
  );

  /// Validates an Indian Aadhaar number in the format: `XXXX XXXX XXXX`
  /// where the first digit is between 2–9.
  final RegExp aadharRegex = RegExp(
    r"^[2-9]{1}[0-9]{3}\s[0-9]{4}\s[0-9]{4}$",
  );

  /// Matches only digits (0–9).
  final RegExp onlyDigitsRegex = RegExp(r"[0-9]");

  /// Validates a standard email address format.
  final RegExp email = RegExp(
    r"^[a-zA-Z0-9]([a-zA-Z0-9._-]*[a-zA-Z0-9])?@[a-zA-Z0-9]([a-zA-Z0-9.-]*[a-zA-Z0-9])?\.[a-zA-Z]{2,}$",
  );

  /// Validates an 8-digit phone number.
  final RegExp phoneNumber = RegExp(r'^[0-9]{8}$');

  /// Matches any character that is not a digit or a decimal point.
  /// Useful for cleaning up currency strings.
  final RegExp checkCurrency = RegExp(r'[^\d.]');

  /// Validates alphanumeric characters and spaces,
  /// typically used for building or villa names.
  final RegExp buildingVillaRegex = RegExp(r"[a-zA-Z0-9 ]");

  /// Validates street names allowing letters, numbers,
  /// hyphens, underscores, apostrophes, and spaces.
  final RegExp streetNameRegex = RegExp(r"^[a-zA-Z0-9\-_'\s]+$");

  /// Checks if a string starts with a number.
  final RegExp startsWithNumber = RegExp(r'^[0-9]');

  /// Checks if a string starts with a letter.
  final RegExp startsWithLetter = RegExp(r'^[a-zA-Z]');

  /// Checks if a string contains any alphabetic or special characters.
  final RegExp containsChar = RegExp(r'[a-zA-Z\W]');

  /// Finds numeric digits within a string.
  final RegExp findInNumber = RegExp(r'[0-9]');

  /// A simple email validation pattern that matches the format:
  /// `example@domain.com`
  final RegExp simpleEmail = RegExp(r'^[a-zA-Z0-9]+@[a-zA-Z]+\.[a-zA-Z]+');

  /// Checks if a password contains at least one uppercase letter.
  final RegExp passwordUppercase = RegExp(r'(?=.*[A-Z])');

  /// Checks if a password contains at least one lowercase letter.
  final RegExp passwordLowercase = RegExp(r'(?=.*[a-z])');

  /// Checks if a password contains at least one numeric digit.
  final RegExp passwordDigit = RegExp(r'(?=.*\d)');

  /// Checks if a password contains at least one special character.
  final RegExp passwordSpecialChar = RegExp(r'(?=.*[@$!%*?&])');

  /// Validates that a string contains only numeric characters (0–9).
  final RegExp onlyNumbersPattern = RegExp(r'^[0-9]*$');
}
