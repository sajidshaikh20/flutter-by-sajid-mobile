import '../../../utils/exports.dart';

/// Home state for UI-only home screen.
class HomeState extends BaseState {
  const HomeState({
    this.isBalanceVisible = true,
    super.status = BaseStateStatus.initial,
    super.msg = '',
    super.redirectRoute,
  });

  factory HomeState.initial() => const HomeState();

  /// Whether the available balance is visible (default: true).
  final bool isBalanceVisible;

  HomeState copyWith({
    BaseStateStatus? status,
    String? msg,
    PageRouteInfo? redirectRoute,
    bool? isBalanceVisible,
  }) =>
      HomeState(
        status: status ?? this.status,
        msg: msg ?? this.msg,
        redirectRoute: redirectRoute ?? this.redirectRoute,
        isBalanceVisible: isBalanceVisible ?? this.isBalanceVisible,
      );

  @override
  List<Object?> get props => <Object?>[
        status,
        msg,
        redirectRoute,
        isBalanceVisible,
      ];
}
