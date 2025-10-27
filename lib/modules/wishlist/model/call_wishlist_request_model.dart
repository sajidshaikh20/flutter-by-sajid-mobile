import 'package:freezed_annotation/freezed_annotation.dart';

part 'call_wishlist_request_model.freezed.dart';
part 'call_wishlist_request_model.g.dart';

@freezed
/// Model class for wishlist request parameters.
class CallWishlistRequestModel with _$CallWishlistRequestModel {
  /// Creates a new instance of [CallWishlistRequestModel].
  ///
  /// All parameters are optional and can be null.
  const factory CallWishlistRequestModel({
    String? customerToken,
    String? platform,
    String? version,
    int? languageId,
    int? storeId,
    int? limit,
    int? offset,
    int? quoteId,
  }) = _CallWishlistRequestModel;
///From Json method
  factory CallWishlistRequestModel.fromJson(Map<String, dynamic> json) =>
      _$CallWishlistRequestModelFromJson(json);
}
