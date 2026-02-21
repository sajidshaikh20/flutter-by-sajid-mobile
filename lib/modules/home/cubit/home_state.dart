import '../../../utils/exports.dart';

/// Home state. No model types — dynamic only for UI-only.
class HomeState extends BaseState {
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
    this.apiCallForHome = BaseStateStatus.initial,
    this.apiCallForNotice = BaseStateStatus.initial,
    this.apiCallForBanner = BaseStateStatus.initial,
    this.apiCallForHomeCategory = BaseStateStatus.initial,
    this.apiCallForHomeBanners = BaseStateStatus.initial,
    this.apiCallForHomeDeals = BaseStateStatus.initial,
    this.apiCallForYouMayAlsoLikeDeals = BaseStateStatus.initial,
    this.apiCallForAddress = BaseStateStatus.initial,
    this.brandsList = const <dynamic>[],
    this.apiCallForBrands = BaseStateStatus.initial,
    this.loyaltyPointsModel,
    this.apiCallForLoyaltyPoints = BaseStateStatus.initial,
    this.selectedSegmentIndex = 0,
    this.deliveryType = 'delivery',
  });

  factory HomeState.initial() => HomeState(
        deliveryType: SharedPref.instance.getDeliveryType(),
      );

  final List<dynamic>? bannersModel;
  final List<dynamic>? categoriesModel;
  final List<dynamic>? dealsModel;
  final List<dynamic>? youMayAlsoLikeDealsModel;
  final dynamic addWishlistModel;
  final bool detailsNotFound;
  final int? cartCount;
  final BaseStateStatus apiCallForAddress;
  final BaseStateStatus apiCallForHome;
  final BaseStateStatus apiCallForNotice;
  final BaseStateStatus apiCallForBanner;
  final BaseStateStatus apiCallForHomeCategory;
  final BaseStateStatus apiCallForHomeDeals;
  final BaseStateStatus apiCallForYouMayAlsoLikeDeals;
  final BaseStateStatus apiCallForHomeBanners;
  final List<dynamic> brandsList;
  final BaseStateStatus apiCallForBrands;
  final dynamic loyaltyPointsModel;
  final BaseStateStatus apiCallForLoyaltyPoints;
  final int selectedSegmentIndex;
  final String deliveryType;

  HomeState copyWith({
    BaseStateStatus? status,
    List<dynamic>? categoriesModel,
    List<dynamic>? dealsModel,
    List<dynamic>? youMayAlsoLikeDealsModel,
    List<dynamic>? bannersModel,
    dynamic addWishlistModel,
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
    List<dynamic>? brandsList,
    BaseStateStatus? apiCallForBrands,
    dynamic loyaltyPointsModel,
    BaseStateStatus? apiCallForLoyaltyPoints,
    int? selectedSegmentIndex,
    String? deliveryType,
  }) =>
      HomeState(
        bannersModel: bannersModel ?? this.bannersModel,
        categoriesModel: categoriesModel ?? this.categoriesModel,
        dealsModel: dealsModel ?? this.dealsModel,
        youMayAlsoLikeDealsModel:
            youMayAlsoLikeDealsModel ?? this.youMayAlsoLikeDealsModel,
        addWishlistModel: addWishlistModel ?? this.addWishlistModel,
        detailsNotFound: detailsNotFound ?? this.detailsNotFound,
        status: status ?? this.status,
        msg: msg ?? this.msg,
        redirectRoute: redirectRoute ?? this.redirectRoute,
        cartCount: cartCount ?? this.cartCount,
        apiCallForHome: apiCallForHome ?? this.apiCallForHome,
        apiCallForNotice: apiCallForNotice ?? this.apiCallForNotice,
        apiCallForBanner: apiCallForBanner ?? this.apiCallForBanner,
        apiCallForHomeCategory:
            apiCallForHomeCategory ?? this.apiCallForHomeCategory,
        apiCallForHomeBanners: apiCallForHomeBanners ?? this.apiCallForHomeBanners,
        apiCallForHomeDeals: apiCallForHomeDeals ?? this.apiCallForHomeDeals,
        apiCallForYouMayAlsoLikeDeals:
            apiCallForYouMayAlsoLikeDeals ?? this.apiCallForYouMayAlsoLikeDeals,
        apiCallForAddress: apiCallForAddress ?? this.apiCallForAddress,
        brandsList: brandsList ?? this.brandsList,
        apiCallForBrands: apiCallForBrands ?? this.apiCallForBrands,
        loyaltyPointsModel: loyaltyPointsModel ?? this.loyaltyPointsModel,
        apiCallForLoyaltyPoints:
            apiCallForLoyaltyPoints ?? this.apiCallForLoyaltyPoints,
        selectedSegmentIndex: selectedSegmentIndex ?? this.selectedSegmentIndex,
        deliveryType: deliveryType ?? this.deliveryType,
      );

  @override
  List<Object?> get props => <Object?>[
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
