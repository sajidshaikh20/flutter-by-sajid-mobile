import '../../../utils/exports.dart';

/// State class for managing the wallet screen's state in the application.
/// Inherits from [BaseState] and contains wallet-related properties.
class MyWalletState extends BaseState {
  /// Constructor to initialize the wallet state with required properties.
  const MyWalletState({
    required super.status,
    required this.walletAmount,
    required this.collection,
    required this.isVisible,
    super.msg,
    this.totalCount,
  });

  /// The wallet amount of the user.
  final String? walletAmount;

  /// The total count of items (e.g., transactions or items in the collection).
  final int? totalCount;

  /// The collection of items related to the wallet (could be transaction items or other related data).
  final List<String> collection;

  /// Boolean value indicating whether the wallet details are visible or hidden.
  final bool isVisible;

  /// Overrides the [props] getter from [BaseState] to include wallet-related properties.
  @override
  List<Object?> get props => <Object?>[
    walletAmount,
    totalCount,
    collection,
    isVisible,
    ...super.props
  ];

  /// Creates a copy of the current [MyWalletState] with optional modifications to some properties.
  ///
  /// Example: `state.copyWith(walletAmount: '1000')` creates a new state with the updated wallet amount.
  MyWalletState copyWith({
    BaseStateStatus? status,
    String? errorMessage,
    String? walletAmount,
    int? totalCount,
    List<String>? collection,
    bool? isVisible,
  }) =>
      MyWalletState(
        status: status ?? this.status,
        msg: errorMessage ?? msg,
        walletAmount: walletAmount ?? this.walletAmount,
        totalCount: totalCount ?? this.totalCount,
        collection: collection ?? this.collection,
        isVisible: isVisible ?? this.isVisible,
      );
}
