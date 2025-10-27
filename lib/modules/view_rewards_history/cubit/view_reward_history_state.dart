import '../../../utils/exports.dart';

/// Immutable state representing the rewards history view.
class ViewRewardHistoryState extends BaseState {
  /// Creates a new instance of [ViewRewardHistoryState].
  const ViewRewardHistoryState({
    required super.status,
    super.msg,
    required this.count,
  });

  /// Customer's total reward points.
  final int count;

  @override
  List<Object?> get props => <Object?>[super.props];

  /// Returns a new state with selectively overridden fields.
  ViewRewardHistoryState copyWith({
    BaseStateStatus? status,
    int? count,
    String? errorMessage,
  }) {
    return ViewRewardHistoryState(
      status: status ?? this.status,
      msg: errorMessage ?? msg,
      count: count ?? this.count,
    );
  }
}
