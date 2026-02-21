import '../../../utils/exports.dart';

/// Wishlist state. No model types — dynamic only.
class WishListState extends BaseState {
  const WishListState({
    required super.status,
    this.wishlistModel,
    this.wishlistModelWithProducts,
    this.message = '',
    this.error = '',
    this.action = WishListAction.wishListInitial,
    this.cartCount = 0,
    this.cartOperationStatus = BaseStateStatus.initial,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.currentPage = 1,
    this.limit = AppConstant.limitProduct,
    this.totalCount = 0,
    this.isRefreshing = false,
    required this.scrollController,
  });

  final dynamic wishlistModel;
  final dynamic wishlistModelWithProducts;
  final String message;
  final String error;
  final WishListAction action;
  final int cartCount;
  final BaseStateStatus cartOperationStatus;
  final bool isLoadingMore;
  final bool hasMore;
  final int currentPage;
  final int limit;
  final int totalCount;
  final bool isRefreshing;
  final ScrollController scrollController;

  WishListState copyWith({
    BaseStateStatus? status,
    dynamic wishlistModel,
    dynamic wishlistModelWithProducts,
    String? message,
    String? error,
    WishListAction? action,
    int? cartCount,
    BaseStateStatus? cartOperationStatus,
    bool? isLoadingMore,
    bool? hasMore,
    int? currentPage,
    int? limit,
    int? totalCount,
    bool? isRefreshing,
    ScrollController? scrollController,
  }) =>
      WishListState(
        status: status ?? this.status,
        wishlistModel: wishlistModel ?? this.wishlistModel,
        wishlistModelWithProducts:
            wishlistModelWithProducts ?? this.wishlistModelWithProducts,
        message: message ?? this.message,
        error: error ?? this.error,
        action: action ?? this.action,
        cartCount: cartCount ?? this.cartCount,
        cartOperationStatus: cartOperationStatus ?? this.cartOperationStatus,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore,
        hasMore: hasMore ?? this.hasMore,
        currentPage: currentPage ?? this.currentPage,
        limit: limit ?? this.limit,
        totalCount: totalCount ?? this.totalCount,
        isRefreshing: isRefreshing ?? this.isRefreshing,
        scrollController: scrollController ?? this.scrollController,
      );

  @override
  List<Object?> get props => <Object?>[
        ...super.props,
        wishlistModel,
        wishlistModelWithProducts,
        message,
        error,
        action,
        cartCount,
        cartOperationStatus,
        isLoadingMore,
        hasMore,
        currentPage,
        limit,
        totalCount,
        isRefreshing,
        scrollController,
      ];
}
