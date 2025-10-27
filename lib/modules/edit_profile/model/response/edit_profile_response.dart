import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_profile_response.freezed.dart';
part 'edit_profile_response.g.dart';

/// Response model for edit profile API.
@freezed
class EditProfileResponse with _$EditProfileResponse {

  ///EditProfileResponse
  const factory EditProfileResponse({
    /// The customer's phone number.
    String? phoneNumber,

    /// The customer's name.
    String? customerName,

    /// The customer's email address.
    String? customerEmail,

    /// The customer's unique ID.
    String? customerId,

    /// The customer's authentication token.
    String? customerToken,

    /// The referral code.
    String? referralCode,

    /// The number of items in the cart.
    int? cartCount,

    /// The current quote ID.
    dynamic quoteId,

    /// The total value of all orders.
    String? totalOrderValue,

    /// The date of the last order.
    String? lastOrderDate,

    /// The customer's wallet balance.
    String? walletBalance,

    /// The customer's loyalty points.
    String? loyaltyPoints,

    /// The total number of orders.
    int? totalOrder,

    /// User's gender.
    String? gender,

    /// User's birthday.
    String? birthday,

    /// User's nationality.
    String? nationality,

    /// Firebase Cloud Messaging token.
    String? fcmToken,

    /// Arabic Nationality.
    String? arabicNationality,

    /// Phone number prefix/country code.
    int? prefix,
  }) = _EditProfileResponse;
///From json
  factory EditProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$EditProfileResponseFromJson(json);
}