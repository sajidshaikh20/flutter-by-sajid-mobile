import '../../../utils/exports.dart';

/// My Account state. No model types — dynamic only.
class MyAccountState extends BaseState {
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

  final dynamic myAccountInfoModel;
  final dynamic cmsResponseModel;
  final List<dynamic>? accountAddressList;
  final List<dynamic>? accountContactUsList;
  final List<dynamic>? countryList;
  final List<dynamic>? accountOrderItemList;
  final List<dynamic>? userWithoutLogin;
  final BaseStateStatus logoutStatus;
  final bool isUserLogin;
  final dynamic loyaltyPointsModel;
  final BaseStateStatus apiCallForLoyaltyPoints;
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

  MyAccountState copyWith({
    BaseStateStatus? status,
    PageRouteInfo? redirectRoute,
    String? msg,
    dynamic myAccountInfoModel,
    dynamic cmsResponseModel,
    List<dynamic>? accountAddressList,
    List<dynamic>? accountContactUsList,
    List<dynamic>? countryList,
    List<dynamic>? accountOrderItemList,
    List<dynamic>? userWithoutLogin,
    BaseStateStatus? logoutStatus,
    bool? isUserLogin,
    dynamic loyaltyPointsModel,
    BaseStateStatus? apiCallForLoyaltyPoints,
    bool? isNavigating,
  }) {
    return MyAccountState(
      status: status ?? this.status,
      msg: msg ?? this.msg,
      redirectRoute: redirectRoute ?? this.redirectRoute,
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
      apiCallForLoyaltyPoints:
          apiCallForLoyaltyPoints ?? this.apiCallForLoyaltyPoints,
      isNavigating: isNavigating ?? this.isNavigating,
    );
  }

  factory MyAccountState.init() {
    return MyAccountState(
      status: BaseStateStatus.initial,
      myAccountInfoModel: <String, dynamic>{
        'orderTotal': 0,
        'returnTotal': 0,
        'walletAmount': 0,
      },
      cmsResponseModel: <String, dynamic>{},
      logoutStatus: BaseStateStatus.initial,
    );
  }
}
