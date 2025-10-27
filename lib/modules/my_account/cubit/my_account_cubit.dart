import '../../../utils/exports.dart';

/// A Cubit that manages the state of the MyAccount screen.
/// It initializes by fetching the initial data via the repository.
class MyAccountCubit extends Cubit<MyAccountState> {
  /// Constructor to initialize MyAccountCubit with a repository and an initial
  /// state.
  /// It also triggers fetching initial data by calling the [getInitialData]
  /// method.
  MyAccountCubit(
    this._repository,
    MyAccountState initialState,
  ) : super(initialState) {
    /* Future<void>.microtask(
          () async => getInitialData(),
    );*/
    // Check login status when cubit is initialized
    _checkLoginStatus();

    /// Fetches and updates the loyalty points.
    //# TODO in first phase we don't give loyalty things but in future its required
    scheduleMicrotask(() async => callLoyaltyPointsApi());

    // Also refresh login status periodically to catch any changes
    unawaited(Future<void>.microtask(() async {
      await Future<void>.delayed(const Duration(milliseconds: 500));
      if (!isClosed) {
        _checkLoginStatus();
      }
    }));
  }

  /// Fetches initial data by calling the CMS API and account details.
  /// It performs two asynchronous operations: fetching CMS data and
  /// account details.
  Future<void> getInitialData() async {
    await _callCMSApi();
    await callAccountDetails();
  }

  final MyAccountRepositoryImpl _repository;

  /// Check the actual login status from SharedPreferences and update state
  void _checkLoginStatus() {
    bool isLoggedIn =
        SharedPref.instance.getBool(PrefsKey.isLoggedInKey, defValue: false);
    String userProfileData =
        SharedPref.instance.getString(PrefsKey.userProfileKey, '');

    // Update state based on actual login status
    emit(state.copyWith(
      status: BaseStateStatus.success,
      isUserLogin: isLoggedIn && userProfileData.isNotEmpty,

    ));

    DebugLog.instance.i(
        'MyAccountCubit: Login status checked - isLoggedIn: $isLoggedIn, hasUserData: ${userProfileData.isNotEmpty}');
  }

  /// Refresh login status from SharedPreferences
  Future<void> refreshLoginStatus() async {
    _checkLoginStatus();
  }

  ///list of social icons
  List<SocialIconModel> socialIconList = <SocialIconModel>[
    SocialIconModel(
      itemImage: Assets.svgs.icFacebook,
      url: AppConstant.facebookUrl,
    ),
    SocialIconModel(
      itemImage: Assets.svgs.icInstagram,
      url: AppConstant.instagramUrl,
    ),
    SocialIconModel(
      itemImage: Assets.svgs.icTwitterWithoutBorder,
      url: AppConstant.twitterUrl,
    ),
    SocialIconModel(
      itemImage: Assets.svgs.icLinkedinWithoutBorder,
      url: AppConstant.linkedInUrl,
    ),
    SocialIconModel(
      itemImage: Assets.svgs.icYoutube,
      url: AppConstant.youtubeUrl,
    ),
  ];

  ///api call for logout
  Future<void> callLogoutAPI() async {
    DebugLog.instance.i('MyAccountCubit: callLogoutAPI started');
    emit(
      state.copyWith(
        status: BaseStateStatus.loading,
        logoutStatus: BaseStateStatus.loading,
      ),
    );
    String socialLogin =
        SharedPref.instance.getString(PrefsKey.socialLoginTypeKey);
    if (socialLogin == SocialLoginType.facebook.name) {
      await getIt<SocialLoginServices>().handleFbSignOutClick();
    } else if (socialLogin == SocialLoginType.google.name) {
      await getIt<SocialLoginServices>().handleGoogleSignOut();
    } else if (socialLogin == SocialLoginType.apple.name) {
      await getIt<SocialLoginServices>().handleAppleSignOut();
    }
    //  Call the API only once
    final ResponseHandler<BaseResponse<dynamic>> response =
        await _repository.callLogoutApi();

    DebugLog.instance.i('MyAccountCubit: Logout API response received: ${response.isSuccess()}');
    //  Handle response in one place
    await  _handleLogoutAndDeleteResponse(response, isDelete: false);

  }

  ///api call for delete account
  Future<void> callDeleteAccountAPI() async {
    emit(
      state.copyWith(
        status: BaseStateStatus.loading,
        logoutStatus: BaseStateStatus.loading,
      ),
    );
    // Call the API only once
    final ResponseHandler<BaseResponse<dynamic>> response =
        await _repository.callDeleteAccountAPI();

    // Handle response in one place
    await  _handleLogoutAndDeleteResponse(response,isDelete: true);
  }

  ///api call to get account details
  Future<void> callAccountDetails({bool isUpdate = false}) async {
    emit(state.copyWith(status: BaseStateStatus.loading));
    await _repository
        .callAccountDetails()
        .then((ResponseHandler<MyAccountInfoModel> value) async {
      if (value.isSuccess()) {
        if (value.getSuccessInstance()?.response.success ?? false) {
          MyAccountInfoModel? myAccountDetails =
              value.getSuccessInstance()?.response;
          for (final OrderModel element
              in state.accountOrderItemList ?? <OrderModel>[]) {
            if (element.type == MyAccountItemType.myOrders) {
              element.subTitle = myAccountDetails?.orderTotal.toString();
            }
            if (element.type == MyAccountItemType.myReturns) {
              element.subTitle = myAccountDetails?.returnTotal.toString();
            }
            if (element.type == MyAccountItemType.myWallet) {
              element.subTitle = '${myAccountDetails?.walletAmount}';
            }
          }

          await getIt<UserProfileService>().updateUserProfile(
            customerName: myAccountDetails?.firstName,
            lastName: myAccountDetails?.lastName,
            phoneNumber: myAccountDetails?.mobilenumber,
            customerEmail: myAccountDetails?.email,
            prefix: int.tryParse(myAccountDetails!.mobileNumberPrefix.toString()),
          );

          emit(
            state.copyWith(
              status: BaseStateStatus.success,
              myAccountInfoModel: myAccountDetails,
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: BaseStateStatus.failure,
              msg: value.getSuccessInstance()?.response.message ?? '',
            ),
          );
        }
      } else if (value.isFailure()) {
        emit(
          state.copyWith(
            status: BaseStateStatus.failure,
            msg: value.getSuccessInstance()?.response.message ?? '',
          ),
        );
      }
    });
  }

  ///api call to get the cms pages
  Future<void> _callCMSApi() async {
    CmsRequestModel cmsRequestModel = CmsRequestModel(
      // store: getIt<LanguageService>().storeId,
      website: getIt<CountryService>().countryId,
    );
    await _repository.callCMSApi(cmsRequestModel: cmsRequestModel).then(
      (ResponseHandler<CmsResponseModel> value) {
        if (value.isSuccess()) {
          CmsResponseModel? response = value.getSuccessInstance()?.response;
          CmsResponseModel cmsResponseModel = response ?? CmsResponseModel();
          emit(
            state.copyWith(
              cmsResponseModel: cmsResponseModel,
              status: BaseStateStatus.success,
            ),
          );
        } else {
          ErrorResult? errorResponse = value.getFailureInstance()?.error;
          emit(
            state.copyWith(
              msg: errorResponse?.errorMessage ?? '',
              status: BaseStateStatus.failure,
            ),
          );
        }
      },
    );
  }

  /// Initializes the cubit state with the provided order list and fetches other
  /// necessary account-related data such as address, contact, and
  /// country lists.
  void init(
    List<OrderModel> accountOrderItemList,
  ) {
    emit(state.copyWith(status: BaseStateStatus.loading));

    emit(
      state.copyWith(
        status: BaseStateStatus.success,
        accountAddressList: _getAccountAddressList(),
        accountContactUsList: _getAccountContactUsList(),
        countryList: _getCountryList(),
        accountOrderItemList: accountOrderItemList,
        userWithoutLogin: _getUserWithoutLogin(),
      ),
    );
  }

  /// Attempts to launch the provided [url] in an external browser.
  /// If the URL cannot be launched, it throws an exception.
  Future<void> launchInBrowser(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
    return;
  }

  /// Updates the state based on the presence of a valid customer token.
  /// If the customer token is empty, it emits a success status with an empty
  /// [MyAccountInfoModel].
  void updateState() {
    if (getIt<UserProfileService>().customerToken.isEmpty) {
      emit(
        state.copyWith(
          status: BaseStateStatus.success,
          myAccountInfoModel: MyAccountInfoModel(),
        ),
      );
    }
  }


  /// Handle when user returns from login page - refresh status and fetch data
  Future<void> handleReturnFromLogin() async {
    // Check current login status
    bool isLoggedIn =
        SharedPref.instance.getBool(PrefsKey.isLoggedInKey, defValue: false);
    String userProfileData =
        SharedPref.instance.getString(PrefsKey.userProfileKey, '');

    if (isLoggedIn && userProfileData.isNotEmpty) {
      // User is logged in, update state and fetch account details
      emit(state.copyWith(
        status: BaseStateStatus.loading,
        isUserLogin: true,
      ));

      // Fetch user account details
      await callAccountDetails();
    } else {
      // User is not logged in, update state
      emit(state.copyWith(
        status: BaseStateStatus.success,
        isUserLogin: false,
      ));
    }

    DebugLog.instance.i(
        'MyAccountCubit: Return from login handled - isLoggedIn: $isLoggedIn, hasUserData: ${userProfileData.isNotEmpty}');
  }

  List<OrderModel> _getAccountAddressList() => <OrderModel>[
        OrderModel(
          title:
              MainConfig.dynamicString(JsonServiceString.keyProfileMyAddresses),
          type: MyAccountItemType.myAddress,
        ),
        OrderModel(
          title:
              MainConfig.dynamicString(JsonServiceString.keyProfileMyWishlist),
          type: MyAccountItemType.myWishList,
        ),
        OrderModel(
          title: MainConfig.dynamicString(
            JsonServiceString.keyProfileMyReviewRatting,
          ),
          type: MyAccountItemType.myReviewAndRating,
        ),
        OrderModel(
          title: MainConfig.dynamicString(JsonServiceString.keyReferAndEarn),
          type: MyAccountItemType.referAndEarn,
        ),
      ];

  List<OrderModel> _getAccountContactUsList() => <OrderModel>[
        OrderModel(
          title: MainConfig.dynamicString(
            JsonServiceString.keyProfileAboutAlokozay,
          ),
          type: MyAccountItemType.aboutUs,
        ),
        OrderModel(
          title:
              MainConfig.dynamicString(JsonServiceString.keyProfileContactUs),
          type: MyAccountItemType.contactUs,
        ),
        OrderModel(
          title: MainConfig.dynamicString(JsonServiceString.keyProfileHelp),
          type: MyAccountItemType.help,
        ),
      ];

  List<OrderModel> _getCountryList() => <OrderModel>[
        OrderModel(
          title: MainConfig.dynamicString(JsonServiceString.keyProfileCountry),
          isCountryImageAvailable: true,
          countryImage: getIt<CountryService>().countryFlag,
          type: MyAccountItemType.country,
        ),
        OrderModel(
          title: MainConfig.dynamicString(JsonServiceString.keyProfileLanguage),
          isLanguageOrCurrencyAvailable: true,
          subTitle: getIt<LanguageService>().languageName,
          type: MyAccountItemType.language,
        ),
        OrderModel(
          title: MainConfig.dynamicString(JsonServiceString.keyProfileCurrency),
          isLanguageOrCurrencyAvailable: true,
          subTitle: getIt<LanguageService>().defaultCurrency,
          type: MyAccountItemType.currency,
        ),
      ];

  List<OrderModel> _getUserWithoutLogin() => <OrderModel>[
        OrderModel(
          itemImage: Assets.svgs.icSignInIcon,
          title: MainConfig.dynamicString(JsonServiceString.keyRegisterLogIn),
          subTitle: '',
          type: MyAccountItemType.signIn,
        ),
        OrderModel(
          itemImage: Assets.svgs.icSignUpIcon,
          title: MainConfig.dynamicString(JsonServiceString.keySignUp),
          subTitle: '',
          type: MyAccountItemType.signUp,
        ),
      ];

  ///function to redirect to profile screen
  Future<void> redirectToProfileScreen(BuildContext context) async {
    MyAccountCubit myAccountCubit = context.instance<MyAccountCubit>();

    await context.router
        .push(
      EditProfileRoute(
        editProfile: myAccountCubit.state.myAccountInfoModel,
      ),
    )
        .then(
      (Object? value) {
        if (value != null) {
          ///refresh data if route is available
          if (context.mounted) {
            Map<String, dynamic> returnedData = value as Map<String, dynamic>;
            if (returnedData[APIConstant.editApiCalled]) {
              Future<void>.delayed(
                const Duration(seconds: Dimens.duration2),
                () async {
                  await myAccountCubit.callAccountDetails(isUpdate: true);
                },
              );
            }
          }
        }
      },
    );
  }


  Future<void> _handleLogoutAndDeleteResponse(
      ResponseHandler<BaseResponse<dynamic>> value, {
        required bool isDelete,
      }) async {
    if (value.isSuccess()) {
      final bool isSuccess =
          value.getSuccessInstance()?.response.success ?? false;

      if (isSuccess) {
        // Clear global wishlist and cart data when logging out (not when deleting account)
          getIt<GlobalWishlistManager>().clearWishlist();
          getIt<CartCountCubit>().updateCount(0);
        emit(
          state.copyWith(
            status: BaseStateStatus.success,
            logoutStatus: BaseStateStatus.success,
            myAccountInfoModel: MyAccountInfoModel(),
            redirectRoute:isDelete ? const LanguageSelectionRoute() : const SocialLoginRoute() , // Always redirect here
            msg: value.getSuccessInstance()?.response.message,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: BaseStateStatus.failure,
            logoutStatus: BaseStateStatus.failure,
            msg: value.getSuccessInstance()?.response.message ?? '',
          ),
        );
      }
    } else if (value.isFailure()) {
      emit(
        state.copyWith(
          status: BaseStateStatus.failure,
          logoutStatus: BaseStateStatus.failure,
          msg: value.getFailureInstance()?.error?.errorMessage ?? '',
        ),
      );
    }
  }

  /// Resets the logout and delete account status to initial state.
  void resetLogoutAndDeleteStatus() {
    emit(
      state.copyWith(
        logoutStatus: BaseStateStatus.initial,
        status: BaseStateStatus.initial,
        msg: '',
      ),
    );
  }

  /// API call for getting loyalty points
  //# TODO in first phase we don't give loyalty things but in future its required
  Future<void> callLoyaltyPointsApi() async {
    emit(state.copyWith(
        status: BaseStateStatus.loading,
        apiCallForLoyaltyPoints: BaseStateStatus.loading
    ));

    final UserProfileService userProfileService = getIt<UserProfileService>();
    final MainConfig mainConfig = getIt<MainConfig>();

    // Create loyalty points request model
    final LoyaltyPointsRequestModel loyaltyPointsRequest = LoyaltyPointsRequestModel(
      customerToken: userProfileService.customerToken,
      platform: getPlatformName(),
      version: mainConfig.packageInfo.version,
      languageId: int.tryParse(getIt<LanguageService>().languageId) ?? 1,
    );

    // Call the repository to get loyalty points
    final ResponseHandler<BaseResponse<List<LoyaltyPointsResponseModel>>> response =
    await _repository.getLoyaltyPoints(loyaltyPointsRequest);

    if (response.isSuccess()) {
      final OnSuccessResponse<BaseResponse<List<LoyaltyPointsResponseModel>>>?
      successInstance = response.getSuccessInstance();

      if (successInstance != null) {
        final BaseResponse<List<LoyaltyPointsResponseModel>> loyaltyPointsResponse =
            successInstance.response;

        // Check if the API call was successful
        if (loyaltyPointsResponse.success) {
          emit(state.copyWith(
            status: BaseStateStatus.success,
            apiCallForLoyaltyPoints: BaseStateStatus.success,
            loyaltyPointsModel: loyaltyPointsResponse,
          ));
        } else {
          emit(state.copyWith(
            status: BaseStateStatus.failure,
            apiCallForLoyaltyPoints: BaseStateStatus.failure,
            msg: loyaltyPointsResponse.message,
          ));
        }
      } else {
        emit(state.copyWith(
          status: BaseStateStatus.failure,
          apiCallForLoyaltyPoints: BaseStateStatus.failure,
          msg: 'Something went wrong',
        ));
      }
    } else if (response.isFailure()) {
      final OnFailureResponse<BaseResponse<List<LoyaltyPointsResponseModel>>>?
      failureInstance = response.getFailureInstance();
      final String errorMessage = failureInstance?.error?.errorMessage ?? 'Something went wrong';

      emit(state.copyWith(
        status: BaseStateStatus.failure,
        apiCallForLoyaltyPoints: BaseStateStatus.failure,
        msg: errorMessage,
      ));
    }
  }

  /// Set navigation state to prevent multiple simultaneous navigations
  void setNavigating({required bool isNavigating}) {
    emit(state.copyWith(status: state.status, isNavigating: isNavigating));
  }

  /// Navigate to a route with debouncing to prevent multiple simultaneous navigations
  Future<Object?> navigateToRoute(BuildContext context, PageRouteInfo route) async {
    // Check if already navigating
    if (state.isNavigating) {
      DebugLog.instance.i('MyAccountCubit: Navigation already in progress, ignoring request');
      return null;
    }

    // Set navigating state
    setNavigating(isNavigating: true);
    DebugLog.instance.i('MyAccountCubit: Starting navigation to ${route.runtimeType}');

    try {
      // Navigate to the route
      final Object? result = await context.router.push(route);

      // Check if we're returning from NotificationSettingRoute and refresh loyalty points
      if (result != null && result is bool && result == true) {
        DebugLog.instance.i('MyAccountCubit: Returning from NotificationSettingRoute, refreshing loyalty points');
        if (context.mounted) {
          await callLoyaltyPointsApi();
        }
      }

      return result;
    } finally {
      // Always reset navigating state
      if (context.mounted) {
        setNavigating(isNavigating: false);
        DebugLog.instance.i('MyAccountCubit: Navigation completed, resetting state');
      }
    }
  }
}
