import '../../utils/exports.dart';

/// A service responsible for managing user profile data.
///
/// This service provides functionality to load, update, and store user
/// profile information, such as the customer's name, email, phone numbers,
/// order information, and more.
class UserProfileService extends ChangeNotifier {
  /// The model that holds the user profile data.
  UserProfileModel? _dataModel;

  /// Singleton instance of `UserProfileService`.
  static UserProfileService instance() => getIt<UserProfileService>();

  /// Loads the user profile data from shared preferences.
  ///
  /// If the data is available, it decodes the JSON string and populates the
  /// `_dataModel` with the decoded data. If the data is unavailable, it
  /// initializes the `_dataModel` with default values.
  Future<void> loadUserData() async {
    dynamic jsonString = await SharedPref.instance.getValue(PrefsKey.userProfileKey);
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
          mobileNumber: '',
          prefix: 0,
          quoteId: '',
          customerName: '',
          customerEmail: '',
          customerToken: '',
          totalOrderValue: '',
          lastOrderDate: '',
          storeCredit: '',
          rewardPoints: '',
          totalOrder: 0, referralCode: '', fcmToken: '', gender: '', birthday: '', nationality: '',customerId: '',cartCount: 0,arabicNationality : ''
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

  /// The customer's first name.
  String get customerName => _dataModel?.customerName ?? '';

  /// The customer's last name.
  String get customerLastName => _dataModel?.lastName ?? '';

  /// The customer's first name.
  String get firstName => _dataModel?.firstName ?? '';

  /// The customer's last name.
  String get lastName => _dataModel?.lastName ?? '';

  /// The customer's email address.
  String get customerEmail => _dataModel?.customerEmail ?? '';

  /// The customer's phone number.
  String get phoneNumber => _dataModel?.phoneNumber ?? '';

  /// The customer's mobile number.
  String get mobileNumber => _dataModel?.mobileNumber ?? '';

  /// The customer's mobile number.
  String get nationality => _dataModel?.nationality ?? '';

  /// The customer' birthday.
  String get birthday => _dataModel?.birthday ?? '';

  ///referralCode
  String get referralCode => _dataModel?.referralCode ?? '';
  ///gender
  String get gender => _dataModel?.gender ?? '';
  ///fcmToken
  String get fcmToken => _dataModel?.fcmToken ?? '';
  ///arabicNationality
  String get arabicNationality => _dataModel?.arabicNationality ?? '';

  /// The customer's username.
  String get username => _dataModel?.username ?? '';

  /// The user's role ID.
  int? get roleId => _dataModel?.roleId;

  /// The user's role name.
  String get roleName => _dataModel?.roleName ?? '';

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

  /// Whether subscription is active.
  bool get isSubscriptionActive => _dataModel?.isActive ?? false;

  /// Subscription duration in days.
  int get durationDays => _dataModel?.durationDays ?? 0;


  /// The customer's authentication token.
  String get customerToken {
    final String token = _dataModel?.customerToken ?? '';
    DebugLog.instance.d('UserProfileService.customerToken accessed: "$token" (isDataLoaded: $isDataLoaded)');
    return token;
  }

  /// Ensures user data is loaded and returns the customer token.
  /// This method should be used when you need to guarantee that user data is loaded.
  Future<String> getCustomerToken() async {
    await ensureUserDataLoaded();
    return _dataModel?.customerToken ?? '';
  }

  /// The customer's unique ID.
  String? get customerId => _dataModel?.customerId ?? '';

  /// The current quote ID for the customer.
  dynamic get quoteId => _dataModel?.quoteId ?? '';

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
    String? customerId,
    dynamic quoteId,
    String? totalOrderValue,
    String? lastOrderDate,
    String? storeCredit,
    String? rewardPoints,
    int? totalOrder,
    dynamic prefix,
    String? lastName,
    int? cartCount,
    String? referralCode,
    String? gender,
    String? birthday,
    String? nationality,
    String? fcmToken,
    String? arabicNationality,
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
  }) async {
    // Ensure user data exists before updating; initialize if needed
    await ensureUserDataLoaded();
    _dataModel ??= UserProfileModel(
        phoneNumber: '',
        mobileNumber: '',
        prefix: 0,
        quoteId: '',
        customerName: '',
        customerEmail: '',
        customerToken: '',
        totalOrderValue: '',
        lastOrderDate: '',
        storeCredit: '',
        rewardPoints: '',
        totalOrder: 0,
        referralCode: '',
        fcmToken: '',
        gender: '',
        birthday: '',
        nationality: '',
        customerId: '',
        cartCount: 0,
        arabicNationality: '',
        username: '',
      );


    // Update only the fields that are provided, keeping others unchanged
    _dataModel = _dataModel?.copyWith(
      customerName: customerName ?? _dataModel?.customerName,
      customerEmail: customerEmail ?? _dataModel?.customerEmail,
      phoneNumber: phoneNumber ?? _dataModel?.phoneNumber,
      customerToken: customerToken ?? _dataModel?.customerToken,
      customerId: customerId ?? _dataModel?.customerId,
      quoteId: quoteId ?? _dataModel?.quoteId,
      totalOrderValue: totalOrderValue ?? _dataModel?.totalOrderValue,
      lastOrderDate: lastOrderDate ?? _dataModel?.lastOrderDate,
      storeCredit: storeCredit ?? _dataModel?.storeCredit,
      rewardPoints: rewardPoints ?? _dataModel?.rewardPoints,
      totalOrder: totalOrder ?? _dataModel?.totalOrder,
      prefix: prefix ?? _dataModel?.prefix,
      lastName: lastName ?? _dataModel?.lastName,
      cartCount: cartCount ?? _dataModel?.cartCount,
      fcmToken: fcmToken ?? _dataModel?.fcmToken,
      referralCode: referralCode ?? _dataModel?.referralCode,
      gender: gender ?? _dataModel?.gender,
      birthday: birthday ?? _dataModel?.birthday,
      nationality: nationality ?? _dataModel?.nationality,
      arabicNationality: arabicNationality ?? _dataModel?.arabicNationality,
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
    );

    // Save updated model back to shared preferences
    String jsonString = jsonEncode(_dataModel?.toJson());
    await SharedPref.instance.setValue(PrefsKey.userProfileKey, jsonString);
    notifyListeners();
  }


  /// Checks if user data is loaded
  bool get isDataLoaded => _dataModel != null;

  /// Clears the quote ID by setting it to null
  /// This should be called when you want to reset the quote ID
  Future<void> clearQuoteId() async {
    await ensureUserDataLoaded();
    _dataModel = _dataModel?.copyWith();

    // Save updated model back to shared preferences
    String jsonString = jsonEncode(_dataModel?.toJson());
    await SharedPref.instance.setValue(PrefsKey.userProfileKey, jsonString);
    notifyListeners();

    DebugLog.instance.i('UserProfileService.clearQuoteId: Quote ID cleared');
  }


  /// Updates the user's profile data and clears the quote ID
  /// This method should be used when you want to update profile and reset quote ID
  Future<void> updateUserProfileAndClearQuoteId({
    String? customerName,
    String? customerEmail,
    String? phoneNumber,
    String? customerToken,
    String? customerId,
    String? totalOrderValue,
    String? lastOrderDate,
    String? storeCredit,
    String? rewardPoints,
    int? totalOrder,
    dynamic prefix,
    String? lastName,
    int? cartCount,
    String? referralCode,
    String? gender,
    String? birthday,
    String? nationality,
    String? fcmToken,
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
  }) async {
    // Ensure user data exists before updating; initialize if needed
    await ensureUserDataLoaded();
    _dataModel ??= UserProfileModel(
        phoneNumber: '',
        mobileNumber: '',
        prefix: 0,
        quoteId: '',
        customerName: '',
        customerEmail: '',
        customerToken: '',
        totalOrderValue: '',
        lastOrderDate: '',
        storeCredit: '',
        rewardPoints: '',
        totalOrder: 0,
        referralCode: '',
        fcmToken: '',
        gender: '',
        birthday: '',
        nationality: '',
        customerId: '',
        cartCount: 0,
        arabicNationality: '',
        username: '',
      );


    // Update only the fields that are provided, keeping others unchanged
    // Always set quoteId to null
    _dataModel = _dataModel?.copyWith(
      customerName: customerName ?? _dataModel?.customerName,
      customerEmail: customerEmail ?? _dataModel?.customerEmail,
      phoneNumber: phoneNumber ?? _dataModel?.phoneNumber,
      customerToken: customerToken ?? _dataModel?.customerToken,
      customerId: customerId ?? _dataModel?.customerId,
      totalOrderValue: totalOrderValue ?? _dataModel?.totalOrderValue,
      lastOrderDate: lastOrderDate ?? _dataModel?.lastOrderDate,
      storeCredit: storeCredit ?? _dataModel?.storeCredit,
      rewardPoints: rewardPoints ?? _dataModel?.rewardPoints,
      totalOrder: totalOrder ?? _dataModel?.totalOrder,
      prefix: prefix ?? _dataModel?.prefix,
      lastName: lastName ?? _dataModel?.lastName,
      cartCount: cartCount ?? _dataModel?.cartCount,
      fcmToken: fcmToken ?? _dataModel?.fcmToken,
      referralCode: referralCode ?? _dataModel?.referralCode,
      gender: gender ?? _dataModel?.gender,
      birthday: birthday ?? _dataModel?.birthday,
      nationality: nationality ?? _dataModel?.nationality,
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
    );

    // Save updated model back to shared preferences
    String jsonString = jsonEncode(_dataModel?.toJson());
    await SharedPref.instance.setValue(PrefsKey.userProfileKey, jsonString);
    notifyListeners();

    DebugLog.instance.i('UserProfileService.updateUserProfileAndClearQuoteId: Profile updated and quote ID cleared');
  }



}
