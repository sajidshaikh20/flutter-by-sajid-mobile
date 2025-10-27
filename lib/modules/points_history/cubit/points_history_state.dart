import '../../../utils/exports.dart';

/// Immutable state for the Points History screen.
class PointsHistoryState extends BaseState {
  /// Current cart count.
  final int cartCount;
  /// Selected segment index for filtering.
  final int selectedSegmentIndex;

  @override
  List<Object?> get props => <Object?>[cartCount,selectedSegmentIndex,status,msg];



  /// Creates a [PointsHistoryState].
  const PointsHistoryState(this.cartCount, this.selectedSegmentIndex, {required super.status});

  /// Initial default state.
  factory PointsHistoryState.initial() {
    return const PointsHistoryState(0,0, status: BaseStateStatus.initial);
  }

  /// Returns a copy with updated fields.
  PointsHistoryState copyWith({
    int? cartCount,
    BaseStateStatus? status,
    int? selectedSegmentIndex
  }) {
    return PointsHistoryState(
      cartCount ?? this.cartCount,
      selectedSegmentIndex ?? this.selectedSegmentIndex,
      status: status ?? this.status,
    );
  }
}