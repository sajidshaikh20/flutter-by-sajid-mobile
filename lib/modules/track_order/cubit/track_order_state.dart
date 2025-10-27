import '../../../utils/exports.dart';

/// Immutable state for the Track Order flow.
class TrackOrderState extends BaseState {
  /// Creates a new [TrackOrderState].
  const TrackOrderState({
    required super.status,
    super.redirectRoute,
  });

  /// Returns a new instance with the provided overrides.
  TrackOrderState copyWith({
    BaseStateStatus? status,
    PageRouteInfo? redirectRoute,
  }) =>
      TrackOrderState(
        status: status ?? this.status,
        redirectRoute: redirectRoute ?? this.redirectRoute,
      );

  @override
  List<Object?> get props => <Object?>[...super.props];
}
