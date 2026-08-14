import '../../utils/exports.dart';

/// A service responsible for managing user profile data.
///
/// This service provides functionality to load, update, and store user
/// profile information, such as the customer's name, email, phone numbers,
/// order information, and more.
class UserProfileService extends ChangeNotifier {
  /// The model that holds the user profile data.
  UserProfileModel? _dataModel;

  /// The local profile picture path.
  String? _localProfilePicturePath;

  /// Singleton instance of `UserProfileService`.
  static UserProfileService instance() => getIt<UserProfileService>();

  /// Loads the user profile data from shared preferences.
  ///
  /// If the data is available, it decodes the JSON string and populates the
  /// `_dataModel` with the decoded data. If the data is unavailable, it
  /// initializes the `_dataModel` with default values.
  Future<void> loadUserData() async {
    dynamic jsonString = await SharedPref.instance.getValue(PrefsKey.userProfileKey);
    _localProfilePicturePath = SharedPref.instance.getString(PrefsKey.localProfilePicturePathKey, '');
    DebugLog.instance.i('UserProfileService.loadUserData: Raw data from SharedPref: "$jsonString" (type: ${jsonString.runtimeType})');

    if (jsonString is String && jsonString != 'null' && jsonString.isNotEmpty) {
      try {
        dynamic jsonMap = jsonDecode(jsonString);
        _dataModel = UserProfileModel.fromJson(jsonMap);
        DebugLog.instance.i('UserProfileService.loadUserData: SUCCESS - Data loaded: customerName="${_dataModel?.customerName}", token="${_dataModel?.customerToken}" (length: ${_dataModel?.customerToken.length ?? 0})');
      } on Exception catch (e) {
        DebugLog.instance.e('UserProfileService.loadUserData: ERROR parsing JSON: $e');
        _dataModel = null;
      }
    } else {
      DebugLog.instance.w('UserProfileService.loadUserData: No valid data found - jsonString: "$jsonString"');
      _dataModel = UserProfileModel(
        phoneNumber: '',
        prefix: 0,
        customerName: '',
        customerEmail: '',
        customerId: '',
        customerToken: '',
      );
      DebugLog.instance.w('UserProfileService.loadUserData: Created empty model with default values');
    }
    notifyListeners();
  }

  /// Ensures user data is loaded before accessing
  Future<void> ensureUserDataLoaded() async {
    if (_dataModel == null) {
      await loadUserData();
    }
  }


  // Getters for user profile data

  /// The local profile picture path.
  String get localProfilePicturePath => _localProfilePicturePath ?? '';

  /// The user's profile picture URL from the live server.
  String get profilePictureUrl => _dataModel?.profilePictureUrl ?? '';

  /// The customer's full name.
  String get customerName => _dataModel?.customerName ?? '';

  /// Updates the local profile picture path.
  Future<void> updateProfilePicture(String path) async {
    _localProfilePicturePath = path;
    await SharedPref.instance.setValue(PrefsKey.localProfilePicturePathKey, path);
    notifyListeners();
  }

  /// The customer's email address.
  String get customerEmail => _dataModel?.customerEmail ?? '';

  /// The customer's phone number.
  String get phoneNumber => _dataModel?.phoneNumber ?? '';

  /// The customer's username.
  String get username => _dataModel?.username ?? '';

  /// The user's role ID.
  int? get roleId => _dataModel?.roleId;

  /// The user's role name.
  String get roleName => _dataModel?.roleName ?? '';

  /// Whether the user has TRADER or MENTOR role.
  bool get isTrader {
    final String role = roleName.toUpperCase();
    return role == 'TRADER' || role == 'MENTOR';
  }

  /// Subscription public ID.
  String get subscriptionPublicId => _dataModel?.subscriptionPublicId ?? '';

  /// Subscription plan name.
  String get planName => _dataModel?.planName ?? '';

  /// Subscription plan code.
  String get planCode => _dataModel?.planCode ?? '';

  /// Subscription category.
  String get category => _dataModel?.category ?? '';

  /// Subscription billing cycle.
  String get billingCycle => _dataModel?.billingCycle ?? '';

  /// Subscription amount.
  double? get amount => _dataModel?.amount;

  /// Subscription currency code.
  String get currencyCode => _dataModel?.currencyCode ?? '';

  /// Subscription payment status.
  String get paymentStatus => _dataModel?.paymentStatus ?? '';

  /// Subscription status.
  String get subscriptionStatus => _dataModel?.subscriptionStatus ?? '';

  /// Subscription start date.
  String get startDate => _dataModel?.startDate ?? '';

  /// Subscription end date.
  String get endDate => _dataModel?.endDate ?? '';

  /// Whether subscription is active (Traders do not require subscription).
  bool get isSubscriptionActive {
    if (_dataModel == null) return false;
    if (isTrader) return true;

    final bool active = _dataModel?.isActive ?? false;
    final String subStatus = (_dataModel?.subscriptionStatus ?? '').toUpperCase();
    final String payStatus = (_dataModel?.paymentStatus ?? '').toUpperCase();
    final String subId = _dataModel?.subscriptionPublicId ?? '';

    if (subId.isEmpty || !active || subStatus == 'EXPIRED' || subStatus == 'CANCELLED' || subStatus == 'INACTIVE' || payStatus == 'INACTIVE') {
      return false;
    }
    if (active && subStatus == 'ACTIVE') {
      return true;
    }
    return active;
  }

  /// Whether payment is pending for a subscription.
  bool get isPaymentPending {
    if (_dataModel == null || isTrader) return false;
    final String subStatus = (_dataModel?.subscriptionStatus ?? '').toUpperCase();
    final String payStatus = (_dataModel?.paymentStatus ?? '').toUpperCase();
    final String subId = _dataModel?.subscriptionPublicId ?? '';
    return subId.isNotEmpty && (subStatus == 'PENDING' || payStatus == 'PENDING');
  }

  /// Subscription duration in days.
  int get durationDays => _dataModel?.durationDays ?? 0;

  /// The default/custom trading balance.
  double? get amountBalance => _dataModel?.amountBalance;

  /// The default/custom trading risk percentage.
  double? get riskPercentage => _dataModel?.riskPercentage;

  /// Whether it's the user's first time logging in.
  bool? get firstTimeLogin => _dataModel?.firstTimeLogin;


  /// The customer's authentication token.
  String get customerToken {
    final String token = _dataModel?.customerToken ?? '';
    DebugLog.instance.d('UserProfileService.customerToken accessed: "$token" (isDataLoaded: $isDataLoaded)');
    return token;
  }

  /// The access token for API calls.
  String get accessToken => _dataModel?.accessToken ?? '';

  /// The refresh token to renew session.
  String get refreshToken => _dataModel?.refreshToken ?? '';

  /// Ensures user data is loaded and returns the customer token.
  /// This method should be used when you need to guarantee that user data is loaded.
  Future<String> getCustomerToken() async {
    await ensureUserDataLoaded();
    return _dataModel?.customerToken ?? '';
  }

  /// The customer's unique ID.
  String? get customerId => _dataModel?.customerId ?? '';

  /// The customer's phone number prefix.
  dynamic get prefix => _dataModel?.prefix ?? "";

  /// Updates the user's profile data with the provided values.
  ///
  /// Only the fields that are provided are updated, and the others remain
  /// unchanged. After updating the data, the profile is saved back to shared
  /// preferences.
  Future<void> updateUserProfile({
    String? customerName,
    String? customerEmail,
    String? phoneNumber,
    String? customerToken,
    String? accessToken,
    String? refreshToken,
    String? customerId,
    dynamic prefix,
    String? username,
    int? roleId,
    String? roleName,
    String? subscriptionPublicId,
    String? planName,
    String? planCode,
    String? category,
    String? billingCycle,
    double? amount,
    String? currencyCode,
    String? paymentStatus,
    String? subscriptionStatus,
    String? startDate,
    String? endDate,
    bool? isActive,
    int? durationDays,
    String? profilePictureUrl,
    double? amountBalance,
    double? riskPercentage,
    bool? firstTimeLogin,
    bool clearSubscription = false,
  }) async {
    // Ensure user data exists before updating; initialize if needed
    await ensureUserDataLoaded();
    _dataModel ??= UserProfileModel(
      phoneNumber: '',
      prefix: 0,
      customerName: '',
      customerEmail: '',
      customerId: '',
      customerToken: '',
    );

    if (clearSubscription) {
      _dataModel = _dataModel?.copyWith(
        customerName: customerName ?? _dataModel?.customerName,
        customerEmail: customerEmail ?? _dataModel?.customerEmail,
        phoneNumber: phoneNumber ?? _dataModel?.phoneNumber,
        customerToken: customerToken ?? _dataModel?.customerToken,
        accessToken: accessToken ?? _dataModel?.accessToken,
        refreshToken: refreshToken ?? _dataModel?.refreshToken,
        customerId: customerId ?? _dataModel?.customerId,
        prefix: prefix ?? _dataModel?.prefix,
        username: username ?? _dataModel?.username,
        roleId: roleId ?? _dataModel?.roleId,
        roleName: roleName ?? _dataModel?.roleName,
        profilePictureUrl: profilePictureUrl ?? _dataModel?.profilePictureUrl,
        amountBalance: amountBalance ?? _dataModel?.amountBalance,
        riskPercentage: riskPercentage ?? _dataModel?.riskPercentage,
        firstTimeLogin: firstTimeLogin ?? _dataModel?.firstTimeLogin,
        subscriptionPublicId: '',
        planName: '',
        planCode: '',
        category: '',
        billingCycle: '',
        currencyCode: '',
        paymentStatus: 'INACTIVE',
        subscriptionStatus: 'EXPIRED',
        startDate: '',
        endDate: '',
        isActive: false,
        durationDays: 0,
      );
    } else {
      _dataModel = _dataModel?.copyWith(
        customerName: customerName ?? _dataModel?.customerName,
        customerEmail: customerEmail ?? _dataModel?.customerEmail,
        phoneNumber: phoneNumber ?? _dataModel?.phoneNumber,
        customerToken: customerToken ?? _dataModel?.customerToken,
        accessToken: accessToken ?? _dataModel?.accessToken,
        refreshToken: refreshToken ?? _dataModel?.refreshToken,
        customerId: customerId ?? _dataModel?.customerId,
        prefix: prefix ?? _dataModel?.prefix,
        username: username ?? _dataModel?.username,
        roleId: roleId ?? _dataModel?.roleId,
        roleName: roleName ?? _dataModel?.roleName,
        subscriptionPublicId: subscriptionPublicId ?? _dataModel?.subscriptionPublicId,
        planName: planName ?? _dataModel?.planName,
        planCode: planCode ?? _dataModel?.planCode,
        category: category ?? _dataModel?.category,
        billingCycle: billingCycle ?? _dataModel?.billingCycle,
        amount: amount ?? _dataModel?.amount,
        currencyCode: currencyCode ?? _dataModel?.currencyCode,
        paymentStatus: paymentStatus ?? _dataModel?.paymentStatus,
        subscriptionStatus: subscriptionStatus ?? _dataModel?.subscriptionStatus,
        startDate: startDate ?? _dataModel?.startDate,
        endDate: endDate ?? _dataModel?.endDate,
        isActive: isActive ?? _dataModel?.isActive,
        durationDays: durationDays ?? _dataModel?.durationDays,
        profilePictureUrl: profilePictureUrl ?? _dataModel?.profilePictureUrl,
        amountBalance: amountBalance ?? _dataModel?.amountBalance,
        riskPercentage: riskPercentage ?? _dataModel?.riskPercentage,
        firstTimeLogin: firstTimeLogin ?? _dataModel?.firstTimeLogin,
      );
    }

    // Save updated model back to shared preferences
    String jsonString = jsonEncode(_dataModel?.toJson());
    await SharedPref.instance.setValue(PrefsKey.userProfileKey, jsonString);
    notifyListeners();
  }


  /// Checks if user data is loaded
  bool get isDataLoaded => _dataModel != null;
}
