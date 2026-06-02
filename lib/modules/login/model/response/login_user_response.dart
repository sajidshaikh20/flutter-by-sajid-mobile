import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_user_response.freezed.dart';
part 'login_user_response.g.dart';

/// Response model for user login containing user information and account details.
///
/// This model represents the response from a successful login operation,
/// containing user profile information, authentication tokens, and account
/// statistics like cart count, order history, and loyalty points.
///
/// Supports deserialization via [].
///
/// Example usage:
/// ```dart
/// final userResponse = LoginUserResponse.fromJson(jsonData);
/// print('Welcome ${userResponse.customerName}');
/// print('Cart items: ${userResponse.cartCount}');
/// print('Loyalty points: ${userResponse.loyaltyPoints}');
/// ```
@freezed
abstract class LoginUserResponse with _$LoginUserResponse {
  /// Creates a new [LoginUserResponse] instance.
  const factory LoginUserResponse({
    /// Unique user identifier.
    int? id,

    /// User's display name.
    String? name,

    /// User's login identifier (email/username).
    String? login,

    /// User's phone number.
    String? phoneNumber,

    /// Customer's full name.
    String? customerName,

    /// Customer's email address.
    String? customerEmail,

    /// Customer's unique identifier.
    String? customerId,

    /// Authentication token for the customer.
    String? customerToken,

    /// Number of items in the user's cart.
    int? cartCount,

    /// Quote identifier for the current session.
    dynamic quoteId,

    /// Total value of all orders placed by the user.
    String? totalOrderValue,

    /// Date of the user's last order.
    String? lastOrderDate,

    /// Current wallet balance.
    String? walletBalance,

    /// Current loyalty points balance.
    String? loyaltyPoints,

    /// Total number of orders placed by the user.
    int? totalOrder,

    /// User's referral code.
    String? referralCode,

    /// User's gender.
    String? gender,

    /// User's birthday.
    String? birthday,

    /// User's nationality.
    String? nationality,

    /// User's arabicNationality.
    String? arabicNationality,

    /// Phone number prefix/country code.
    dynamic prefix,
  }) = _LoginUserResponse;

  /// Creates a [LoginUserResponse] instance from a JSON map.
  factory LoginUserResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginUserResponseFromJson(json);
}
