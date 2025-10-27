import '../../../utils/exports.dart';

/// Immutable state representing the review listing screen.
class ReviewListingState extends BaseState {
  /// Creates a new instance of [ReviewListingState].
  const ReviewListingState({
    super.redirectRoute,
    super.msg,
    required super.status,
  });

  /// Creates a copy of this [ReviewListingState] with optional new values.
  ReviewListingState copyWith({
    BaseStateStatus? status,
    String? msg,
    PageRouteInfo? redirectRoute,
  }) {
    return ReviewListingState(
      status: status ?? this.status,
      msg: msg ?? this.msg,
      redirectRoute: redirectRoute ?? this.redirectRoute,
    );
  }

  @override
  List<Object?> get props => <Object?>[...super.props, ]; // Include review here
}
