import '../../../utils/exports.dart';

/// Immutable state for the My Account screen.
class MyAccountState extends BaseState {
  /// Creates an instance of [MyAccountState].
  const MyAccountState({
    required super.status,
    super.msg,
    super.redirectRoute,
    required this.myAccountInfoModel,
    required this.cmsResponseModel,
    this.accountAddressList,
    this.accountContactUsList,
    this.countryList,
    this.accountOrderItemList,
    this.userWithoutLogin,
    required this.logoutStatus,
    this.isUserLogin = false,
    this.loyaltyPointsModel,
    this.apiCallForLoyaltyPoints = BaseStateStatus.initial,
    this.isNavigating = false,
  });

  /// Summary info such as counts and wallet amount.
  final MyAccountInfoModel myAccountInfoModel;

  /// CMS blocks to display in the account screen.
  final CmsResponseModel cmsResponseModel;

  /// Account address related menu items.
  final List<OrderModel>? accountAddressList;

  /// Contact us related menu items.
  final List<OrderModel>? accountContactUsList;

  /// Country selection related menu items.
  final List<OrderModel>? countryList;

  /// Orders related menu items.
  final List<OrderModel>? accountOrderItemList;

  /// Menu items when the user is not logged in.
  final List<OrderModel>? userWithoutLogin;

  /// Status of the logout action.
  final BaseStateStatus logoutStatus;

  /// Whether the user is currently logged in.
  final bool isUserLogin;

  /// The loyalty points model data.
  final BaseResponse<List<LoyaltyPointsResponseModel>>? loyaltyPointsModel;

  /// The status of the API call for the loyalty points data.
  final BaseStateStatus apiCallForLoyaltyPoints;

  /// Whether navigation is currently in progress to prevent multiple simultaneous navigations.
  final bool isNavigating;

  @override
  List<Object?> get props => <Object?>[
        myAccountInfoModel,
        cmsResponseModel,
        accountAddressList,
        accountContactUsList,
        countryList,
        accountOrderItemList,
        userWithoutLogin,
        logoutStatus,
        ...super.props,
        isUserLogin,
        loyaltyPointsModel,
        apiCallForLoyaltyPoints,
        isNavigating,
      ];

  /// Returns a copy with updated fields.
  MyAccountState copyWith({
    required BaseStateStatus? status,
    PageRouteInfo? redirectRoute,
    String? msg,
    MyAccountInfoModel? myAccountInfoModel,
    CmsResponseModel? cmsResponseModel,
    List<OrderModel>? accountAddressList,
    List<OrderModel>? accountContactUsList,
    List<OrderModel>? countryList,
    List<OrderModel>? accountOrderItemList,
    List<OrderModel>? userWithoutLogin,
    BaseStateStatus? logoutStatus,
    bool? isUserLogin,
    BaseResponse<List<LoyaltyPointsResponseModel>>? loyaltyPointsModel,
    BaseStateStatus? apiCallForLoyaltyPoints,
    bool? isNavigating,
  }) {
    return MyAccountState(
      status: status ?? this.status,
      msg: msg ?? this.msg,
      redirectRoute: redirectRoute,
      myAccountInfoModel: myAccountInfoModel ?? this.myAccountInfoModel,
      cmsResponseModel: cmsResponseModel ?? this.cmsResponseModel,
      accountAddressList: accountAddressList ?? this.accountAddressList,
      accountContactUsList: accountContactUsList ?? this.accountContactUsList,
      countryList: countryList ?? this.countryList,
      accountOrderItemList: accountOrderItemList ?? this.accountOrderItemList,
      userWithoutLogin: userWithoutLogin ?? this.userWithoutLogin,
      logoutStatus: logoutStatus ?? this.logoutStatus,
      isUserLogin: isUserLogin ?? this.isUserLogin,
      loyaltyPointsModel: loyaltyPointsModel ?? this.loyaltyPointsModel,
      apiCallForLoyaltyPoints: apiCallForLoyaltyPoints ?? this.apiCallForLoyaltyPoints,
      isNavigating: isNavigating ?? this.isNavigating,
    );
  }

  /// Creates an initial state instance.
  factory MyAccountState.init() {
    return MyAccountState(
        status: BaseStateStatus.initial,
        myAccountInfoModel:
            MyAccountInfoModel(orderTotal: 0, returnTotal: 0, walletAmount: 0),
        cmsResponseModel: CmsResponseModel(),
        logoutStatus: BaseStateStatus.initial);
  }
}
