import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'save_review.freezed.dart';
part 'save_review.g.dart';


/// Represents the response for saving a review.
///
/// Contains information about whether the operation was successful
/// and an accompanying message.
@freezed
class SaveReview with _$SaveReview {
  /// Creates a [SaveReview] instance.
  ///
  /// Both [success] and [message] are required.
  const factory SaveReview({
    /// Indicates whether the review save operation was successful.
    required bool success,

    /// Message describing the result of the operation.
    required String message,
  }) = _SaveReview;

  /// Creates a [SaveReview] object from a JSON map.
  factory SaveReview.fromJson(Map<String, dynamic> json) =>
      _$SaveReviewFromJson(json);
}

/// Converts a JSON string to a [SaveReview] object.
SaveReview saveReviewFromJson(String str) =>
    SaveReview.fromJson(json.decode(str) as Map<String, dynamic>);

/// Converts a [SaveReview] object to a JSON string.
String saveReviewToJson(SaveReview data) => json.encode(data.toJson());
