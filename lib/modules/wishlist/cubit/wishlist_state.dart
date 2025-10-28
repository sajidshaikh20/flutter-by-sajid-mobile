import '../../../utils/exports.dart';

/// Represents the state of the user's wish list in the application.
class WishListState extends BaseState {
  /// Constructor for WishListState, initializes the state with status and data.
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

  /// The model representing the user's wish list data (legacy).
  final WishlistModel? wishlistModel;

  /// The model representing the user's wish list data with ProductListingResponse.
  final WishlistModelWithProducts? wishlistModelWithProducts;



  /// A message associated with the wish list state (e.g., success or info).
  final String message;

  /// An error message associated with the wish list state.
  final String error;

  /// The action currently being performed on the wish list.
  final WishListAction action;

  /// The current cart count for the wishlist items.
  final int cartCount;

  /// The status of cart operations (add/update/remove) - managed independently from main status.
  final BaseStateStatus cartOperationStatus;

  /// Whether more items are currently being loaded (pagination).
  final bool isLoadingMore;

  /// Whether there are more items to load.
  final bool hasMore;

  /// Current page number for pagination.
  final int currentPage;

  /// Number of items to load per page.
  final int limit;

  /// Total count of items available from API.
  final int totalCount;

  /// Whether the wishlist is currently being refreshed (pull-to-refresh).
  final bool isRefreshing;

  /// Scroll controller for managing scroll events and pagination.
  final ScrollController scrollController;

  /// Creates a copy of the WishListState with optional updates to its fields.
  WishListState copyWith({
    BaseStateStatus? status,
    WishlistModel? wishlistModel,
    WishlistModelWithProducts? wishlistModelWithProducts,

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
        wishlistModelWithProducts: wishlistModelWithProducts ?? this.wishlistModelWithProducts,

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
