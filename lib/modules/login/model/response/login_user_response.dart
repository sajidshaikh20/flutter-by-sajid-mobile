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
    /// Nested user data returned from the backend.
    UserResponseData? user,

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

    /// Access token returned from the login endpoint.
    String? accessToken,

    /// Refresh token returned from the login endpoint.
    String? refreshToken,

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

/// Detailed user profile data inside LoginUserResponse.
@freezed
abstract class UserResponseData with _$UserResponseData {
  /// Factory constructor for UserResponseData.
  const factory UserResponseData({
    String? publicId,
    String? name,
    String? email,
    String? username,
    String? countryCode,
    String? phone,
    UserRoleData? role,
    UserSubscriptionData? activeSubscription,
    String? profilePictureUrl,
    double? amountBalance,
    double? riskPercentage,
    bool? firstTimeLogin,
  }) = _UserResponseData;

  /// Creates a [UserResponseData] instance from a JSON map.
  factory UserResponseData.fromJson(Map<String, dynamic> json) =>
      _$UserResponseDataFromJson(json);
}

/// Role information for the user.
@freezed
abstract class UserRoleData with _$UserRoleData {
  /// Factory constructor for UserRoleData.
  const factory UserRoleData({
    int? id,
    String? name,
  }) = _UserRoleData;

  /// Creates a [UserRoleData] instance from a JSON map.
  factory UserRoleData.fromJson(Map<String, dynamic> json) =>
      _$UserRoleDataFromJson(json);
}

/// Subscription details for the user.
@freezed
abstract class UserSubscriptionData with _$UserSubscriptionData {
  /// Factory constructor for UserSubscriptionData.
  const factory UserSubscriptionData({
    String? subscriptionPublicId,
    String? planName,
    String? planCode,
    String? category,
    String? billingCycle,
    dynamic amount,
    String? currencyCode,
    String? paymentStatus,
    String? subscriptionStatus,
    String? startDate,
    String? endDate,
    bool? isActive,
    int? durationDays,
  }) = _UserSubscriptionData;

  /// Creates a [UserSubscriptionData] instance from a JSON map.
  factory UserSubscriptionData.fromJson(Map<String, dynamic> json) =>
      _$UserSubscriptionDataFromJson(json);
}
