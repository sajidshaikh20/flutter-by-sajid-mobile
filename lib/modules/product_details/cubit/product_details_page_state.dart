import '../../../utils/exports.dart';

///
class ProductDetailsState extends BaseState {
  ///product detail
  final ProductDetailsResponse? detailsModel;

  ///review detail
  final GetReviewSummaryResponse? review;

  /// quantity of product
  final int quantity;

  ///select product image
  final int? selectedImage;

  ///is product add to wishlist
  final bool isAddedToWishlist;

  ///product item id
  final String? itemId;

  /// wishlist item id
  final String? wishListItemid;

  /// qty dropdown items
  final List<String> qtyDropdownItems;

  /// current selected tabbar
  final int selectedTabBar;

  ///product entity id
  final String entityId;

  ///status of add to cart
  final StatusOfCart statusForAddToCart;

  /// recently view product
  final List<ProductList>? recentlyViewProduct;

  /// status of review
  final BaseStateStatus statusForReview;

  ///status of product detail
  final BaseStateStatus statusForProductDetails;

  ///status of add to wishlist
  final BaseStateStatus statusForAddToWishList;

  /// show bottom sheet
  final bool isBottomVisible;

  ///is button enabled
  final bool isButtonEnabled;

  ///initial quantity
  final int initialquantity;

  ///selected unit index
  final int? selectedUnitIndex;

  ///is wishlist selected
  final bool? isWishlistSelected;

  ///cart count
  final int cartCount;

  ///available units for the product
  final List<ProductVariantDukkan> availableUnits;

  ///related products list
  final List<ProductListingResponse> relatedProducts;

  ///status of related products
  final BaseStateStatus statusForRelatedProducts;

  ///trending products
  final List<ProductListingResponse> trendingProducts;

  ///status of trending products
  final BaseStateStatus statusForTrendingProducts;

  ///status of cart operations for related and trending products
  final BaseStateStatus statusForCartOperations;

  ///
  ///[ProductDetailsState] is a class that holds the state of the product details page.
  ///
  ///[detailsModel] is the product details model.
  ///[review] is the product review.
  ///[quantity] is the quantity of the product.
  ///[selectedImage] is the selected product image.
  ///
  const ProductDetailsState(
      {this.detailsModel,
      this.review,
      super.status = BaseStateStatus.initial,
      super.msg = '',
      super.redirectRoute,
      required this.quantity,
      this.selectedImage,
      required this.isAddedToWishlist,
      this.itemId,
      this.wishListItemid,
      required this.qtyDropdownItems,
      required this.selectedTabBar,
      required this.entityId,
      required this.statusForAddToCart,
      this.recentlyViewProduct,
      required this.statusForReview,
      required this.statusForProductDetails,
      required this.statusForAddToWishList,
      this.isBottomVisible = true,
      this.isButtonEnabled = true,
      this.selectedUnitIndex = -1,
      this.isWishlistSelected = false,
      this.cartCount = 0,
      this.availableUnits = const <ProductVariantDukkan>[],
      this.relatedProducts = const <ProductListingResponse>[],
      this.statusForRelatedProducts = BaseStateStatus.initial,
      this.trendingProducts = const <ProductListingResponse>[],
      this.statusForTrendingProducts = BaseStateStatus.initial,
      this.statusForCartOperations = BaseStateStatus.initial,
      required this.initialquantity});

  /// initail state
  factory ProductDetailsState.initial() {
    return const ProductDetailsState(
        isAddedToWishlist: false,
        qtyDropdownItems: AppConstant.qtyDropdownItemsList,
        quantity: AppConstant.entityIdDefaultInt,
        selectedTabBar: AppConstant.mainIndex,
        entityId: '',
        statusForAddToCart: StatusOfCart.initial,
        statusForReview: BaseStateStatus.initial,
        statusForProductDetails: BaseStateStatus.initial,
        statusForAddToWishList: BaseStateStatus.initial,
        initialquantity: 1);
  }

  @override
  List<Object?> get props => <Object?>[
        detailsModel,
        review,
        quantity,
        selectedImage,
        isAddedToWishlist,
        itemId,
        wishListItemid,
        qtyDropdownItems,
        selectedTabBar,
        entityId,
        statusForAddToCart,
        statusForReview,
        statusForProductDetails,
        recentlyViewProduct,
        statusForAddToWishList,
        isBottomVisible,
        isButtonEnabled,
        initialquantity,
        selectedUnitIndex,
        isWishlistSelected,
        cartCount,
        availableUnits,
        relatedProducts,
        statusForRelatedProducts,
        trendingProducts,
        statusForTrendingProducts,
        statusForCartOperations,
        super.props
      ];

  /// copy with
  ProductDetailsState copyWith({
    ProductDetailsResponse? detailsModel,
    GetReviewSummaryResponse? review,
    int? quantity,
    int? selectedImage,
    bool? isAddedToWishlist,
    String? itemId,
    String? wishListItemid,
    List<String>? qtyDropdownItems,
    BaseStateStatus? status,
    String? msg,
    int? selectedTabBar,
    String? entityId,
    StatusOfCart? statusForAddToCart,
    List<ProductList>? recentlyViewProduct,
    BaseStateStatus? statusForReview,
    BaseStateStatus? statusForProductDetails,
    BaseStateStatus? statusForAddToWishList,
    bool? isBottomVisible,
    bool? isButtonEnabled,
    int? initialquantity,
    int? selectedUnitIndex,
    bool? isWishlistSelected,
    int? cartCount,
    List<ProductVariantDukkan>? availableUnits,
    List<ProductListingResponse>? relatedProducts,
    BaseStateStatus? statusForRelatedProducts,
    List<ProductListingResponse>? trendingProducts,
    BaseStateStatus? statusForTrendingProducts,
    BaseStateStatus? statusForCartOperations,
  }) {
    return ProductDetailsState(
      statusForAddToWishList:
          statusForAddToWishList ?? this.statusForAddToWishList,
      detailsModel: detailsModel ?? this.detailsModel,
      review: review ?? this.review,
      quantity: quantity ?? this.quantity,
      selectedImage: selectedImage ?? this.selectedImage,
      isAddedToWishlist: isAddedToWishlist ?? this.isAddedToWishlist,
      itemId: itemId ?? this.itemId,
      wishListItemid: wishListItemid ?? this.wishListItemid,
      qtyDropdownItems: qtyDropdownItems ?? this.qtyDropdownItems,
      status: status ?? this.status,
      msg: msg,
      selectedTabBar: selectedTabBar ?? this.selectedTabBar,
      entityId: entityId ?? this.entityId,
      statusForAddToCart: statusForAddToCart ?? this.statusForAddToCart,
      recentlyViewProduct: recentlyViewProduct ?? this.recentlyViewProduct,
      statusForReview: statusForReview ?? this.statusForReview,
      statusForProductDetails:
          statusForProductDetails ?? this.statusForProductDetails,
      isBottomVisible: isBottomVisible ?? this.isBottomVisible,
      isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
      initialquantity: initialquantity ?? this.initialquantity,
      selectedUnitIndex: selectedUnitIndex ?? this.selectedUnitIndex,
      isWishlistSelected: isWishlistSelected ?? this.isWishlistSelected,
      cartCount: cartCount ?? this.cartCount,
      availableUnits: availableUnits ?? this.availableUnits,
      relatedProducts: relatedProducts ?? this.relatedProducts,
      statusForRelatedProducts: statusForRelatedProducts ?? this.statusForRelatedProducts,
      trendingProducts: trendingProducts ?? this.trendingProducts,
      statusForTrendingProducts: statusForTrendingProducts ?? this.statusForTrendingProducts,
      statusForCartOperations: statusForCartOperations ?? this.statusForCartOperations,
    );
  }
}
