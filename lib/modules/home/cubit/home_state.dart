import '../../../utils/exports.dart';

/// Home state for UI-only home screen.
class HomeState extends BaseState {
  const HomeState({
    this.isBalanceVisible = true,
    this.isPostpaidVisible = false,
    this.selectedServiceTab = ServiceCategoryTab.bankingServices,
    super.status = BaseStateStatus.initial,
    super.msg = '',
    super.redirectRoute,
  });

  factory HomeState.initial() => const HomeState();

  /// Whether the available balance is visible (default: true).
  final bool isBalanceVisible;

  /// Whether the Postpaid wallet balance is visible (default: false).
  final bool isPostpaidVisible;

  /// Currently selected All Services tab.
  final ServiceCategoryTab selectedServiceTab;

  HomeState copyWith({
    BaseStateStatus? status,
    String? msg,
    PageRouteInfo? redirectRoute,
    bool? isBalanceVisible,
    bool? isPostpaidVisible,
    ServiceCategoryTab? selectedServiceTab,
  }) =>
      HomeState(
        status: status ?? this.status,
        msg: msg ?? this.msg,
        redirectRoute: redirectRoute ?? this.redirectRoute,
        isBalanceVisible: isBalanceVisible ?? this.isBalanceVisible,
        isPostpaidVisible: isPostpaidVisible ?? this.isPostpaidVisible,
        selectedServiceTab: selectedServiceTab ?? this.selectedServiceTab,
      );

  @override
  List<Object?> get props => <Object?>[
        status,
        msg,
        redirectRoute,
        isBalanceVisible,
        isPostpaidVisible,
        selectedServiceTab,
      ];
}
