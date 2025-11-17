import '../../../../utils/exports.dart';

/// A state class representing the home page data and status.
class HomeState extends BaseState {
  /// Constructs a HomeState with the provided values.
  const HomeState({

    this.bannersModel,

    this.categoriesModel,
    this.dealsModel,
    this.youMayAlsoLikeDealsModel,
    this.addWishlistModel,
    this.detailsNotFound = false,
    super.status = BaseStateStatus.initial,
    super.msg = '',
    super.redirectRoute,
    this.cartCount,
    /* this.isSnackBarDisplay = false,
    this.displayMessage,*/
    this.apiCallForHome = BaseStateStatus.initial,
    this.apiCallForNotice = BaseStateStatus.initial,
    this.apiCallForBanner = BaseStateStatus.initial,
    this.apiCallForHomeCategory = BaseStateStatus.initial,
    this.apiCallForHomeBanners = BaseStateStatus.initial,
    this.apiCallForHomeDeals = BaseStateStatus.initial,
    this.apiCallForYouMayAlsoLikeDeals = BaseStateStatus.initial,
    this.apiCallForAddress = BaseStateStatus.initial,
    this.brandsList = const <ListOfBrandsResponse>[],
    this.apiCallForBrands = BaseStateStatus.initial,
    this.loyaltyPointsModel,
    this.apiCallForLoyaltyPoints = BaseStateStatus.initial,
    this.selectedSegmentIndex = 0,
    this.deliveryType = 'delivery',
  });

  /// Factory method to create an initial HomeState.
  factory HomeState.initial() => HomeState(
    deliveryType: SharedPref.instance.getDeliveryType(),
  );



  /// The banners model data.
  final List<BannerResponseModel>? bannersModel;

  /// The category model data.
  final List<CategoryResponseModel>? categoriesModel;

  /// The deals model data.
  final List<DealsResponseModel>? dealsModel;

  /// The "You May Also Like" deals model data.
  final List<DealsResponseModel>? youMayAlsoLikeDealsModel;

  /// The wishlist model data.
  final AddWishlistModel? addWishlistModel;

  /// A flag indicating whether details were not found.
  final bool detailsNotFound;

  /// The cart count.
  final int? cartCount;


  /// The status of the address API call.
  final BaseStateStatus apiCallForAddress;


  /// The status of the API call for the home data.
  final BaseStateStatus apiCallForHome;

  /// The status of the API call for the notice data.
  final BaseStateStatus apiCallForNotice;

  /// The status of the API call for the banner data.
  final BaseStateStatus apiCallForBanner;

  /// The status of the API call for the home categories data.
  final BaseStateStatus apiCallForHomeCategory;

  /// The status of the API call for the home deals data.
  final BaseStateStatus apiCallForHomeDeals;

  /// The status of the API call for the "You May Also Like" deals data.
  final BaseStateStatus apiCallForYouMayAlsoLikeDeals;

  /// The status of the API call for the home banners data.
  final BaseStateStatus apiCallForHomeBanners;

  /// The brands listing data.
  final List<ListOfBrandsResponse> brandsList;

  /// The status of the API call for the brands listing data.
  final BaseStateStatus apiCallForBrands;

  /// The loyalty points model data.
  final BaseResponse<List<LoyaltyPointsResponseModel>>? loyaltyPointsModel;

  /// The status of the API call for the loyalty points data.
  final BaseStateStatus apiCallForLoyaltyPoints;

  /// The index of the currently selected segment.
  final int selectedSegmentIndex;

  /// The type of delivery selected by the user.
  final String deliveryType;

  /// Creates a copy of the current HomeState with the option to update values.
  HomeState copyWith({
    BaseStateStatus? status,
    List<CategoryResponseModel>? categoriesModel,
    List<DealsResponseModel>? dealsModel,
    List<DealsResponseModel>? youMayAlsoLikeDealsModel,
    List<BannerResponseModel>? bannersModel,
    AddWishlistModel? addWishlistModel,
    String? msg,
    bool? detailsNotFound,
    PageRouteInfo? redirectRoute,
    int? cartCount,

    BaseStateStatus? apiCallForHome,
    BaseStateStatus? apiCallForNotice,
    BaseStateStatus? apiCallForBanner,
    BaseStateStatus? apiCallForHomeCategory,
    BaseStateStatus? apiCallForHomeDeals,
    BaseStateStatus? apiCallForHomeBanners,
    BaseStateStatus? apiCallForYouMayAlsoLikeDeals,
    BaseStateStatus? apiCallForAddress,
    List<ListOfBrandsResponse>? brandsList,
    BaseStateStatus? apiCallForBrands,
    BaseResponse<List<LoyaltyPointsResponseModel>>? loyaltyPointsModel,
    BaseStateStatus? apiCallForLoyaltyPoints,
    int? selectedSegmentIndex,
    String? deliveryType,
  }) =>
      HomeState(

        bannersModel: bannersModel ?? this.bannersModel,

        categoriesModel: categoriesModel ?? this.categoriesModel,
        dealsModel: dealsModel ?? this.dealsModel,
        youMayAlsoLikeDealsModel: youMayAlsoLikeDealsModel ??
            this.youMayAlsoLikeDealsModel,
        addWishlistModel: addWishlistModel ?? this.addWishlistModel,
        detailsNotFound: detailsNotFound ?? this.detailsNotFound,
        status: status ?? this.status,
        // don't change below logic
        msg: msg,
        redirectRoute: redirectRoute ?? this.redirectRoute,
        cartCount: cartCount ?? this.cartCount,

        /*  isSnackBarDisplay: isSnackBarDisplay ?? this.isSnackBarDisplay,
        displayMessage: displayMessage ?? this.displayMessage,*/
        apiCallForHome: apiCallForHome ?? this.apiCallForHome,
        apiCallForNotice: apiCallForNotice ?? this.apiCallForNotice,
        apiCallForBanner: apiCallForBanner ?? this.apiCallForBanner,
        apiCallForHomeCategory:
        apiCallForHomeCategory ?? this.apiCallForHomeCategory,
        apiCallForHomeBanners: apiCallForHomeBanners ?? this.apiCallForHomeBanners,
        apiCallForHomeDeals: apiCallForHomeDeals ?? this.apiCallForHomeDeals,
        apiCallForYouMayAlsoLikeDeals: apiCallForYouMayAlsoLikeDeals ??
            this.apiCallForYouMayAlsoLikeDeals,
        apiCallForAddress: apiCallForAddress ?? this.apiCallForAddress,
        brandsList: brandsList ?? this.brandsList,
        apiCallForBrands: apiCallForBrands ?? this.apiCallForBrands,
        loyaltyPointsModel: loyaltyPointsModel ?? this.loyaltyPointsModel,
        apiCallForLoyaltyPoints: apiCallForLoyaltyPoints ?? this.apiCallForLoyaltyPoints,
        selectedSegmentIndex: selectedSegmentIndex ?? this.selectedSegmentIndex,
        deliveryType: deliveryType ?? this.deliveryType,
      );

  @override
  List<Object?> get props =>
      <Object?>[
        bannersModel,
        categoriesModel,
        dealsModel,
        youMayAlsoLikeDealsModel,
        addWishlistModel,
        detailsNotFound,
        redirectRoute,
        cartCount,
        apiCallForHome,
        apiCallForNotice,
        apiCallForBanner,
        apiCallForHomeCategory,
        apiCallForHomeDeals,
        apiCallForYouMayAlsoLikeDeals,
        apiCallForHomeBanners,
        apiCallForAddress,
        brandsList,
        apiCallForBrands,
        loyaltyPointsModel,
        apiCallForLoyaltyPoints,
        selectedSegmentIndex,
        deliveryType,
      ];
}
