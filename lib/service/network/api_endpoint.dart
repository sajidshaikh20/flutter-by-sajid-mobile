/// A class containing API endpoint constants used in the app.
abstract class Apis {
  /// Base URL for the service.

  static const String subBaseUrl = 'api';

  ///version number
  static const String apiVersion = '/v1';

  /// Endpoint to get account information.
  static const String getAccountInfo = '/mobikulhttp/customer/accountinfoData?';

  /// Endpoint to set a selected checkout time slot.
  static const String setSlot = '/rest/V1/checkout/setslot';

  /// Endpoint to review and complete checkout payment.
  static const String reviewAndPayment = '/rest/V2/checkout/reviewandpayment';

  /// Endpoint to place a user order.
  static const String placeOrder = '/mobikulhttp/checkout/placeorder';

  /// Endpoint to get CMS account data.
  static const String cmsAccountApi = '/_svc/api/md/v1/cms/';

  /// Endpoint to send OTP for user signup.
  static const String signupUserOtp = '$apiVersion/signup_user_otp';

  /// Endpoint to verify OTP and complete user signup.
  static const String signupUserWithVerifyOtp =
      '$apiVersion/signup_user_with_verify_otp';

  /// Endpoint to fetch the list of available countries and languages.
  static const String listOfCountryAndLanguage =
      '$apiVersion/list_of_country_and_language';

  /// Endpoint for user login.
  static const String login = '$subBaseUrl/auth/login';

  /// Endpoint for Google login.
  static const String googleLogin = '$subBaseUrl/auth/google';

  /// Endpoint to send login OTP for WhatsApp.
  static const String sendLoginOtp = '$subBaseUrl/auth/send-login-otp';

  /// Endpoint to login with WhatsApp OTP.
  static const String loginWithOtp = '$subBaseUrl/auth/login-with-otp';

  /// Endpoint to start registration
  static const String startRegistration = '$subBaseUrl/auth/start-registration';

  /// Endpoint to verify email OTP
  static const String verifyEmailOtp = '$subBaseUrl/auth/verify-email-otp';

  /// Endpoint to send phone OTP
  static const String sendPhoneOtp = '$subBaseUrl/auth/send-phone-otp';

  /// Endpoint to verify phone OTP
  static const String verifyPhoneOtp = '$subBaseUrl/auth/verify-phone-otp';

  /// Endpoint to complete registration
  static const String completeRegistration = '$subBaseUrl/auth/complete-registration';

  /// Endpoint to reset password using mobile number.
  static const String forgotPasswordWithMobile =
      '$apiVersion/forgot_password_with_mobile';

  /// Endpoint to reset password using email.
  static const String forgotPasswordWithEmail =
      '$subBaseUrl/auth/forgot-password';

  /// Endpoint to fetch the list of saved addresses.
  static const String addressListing = '$apiVersion/address_listing';

  /// Endpoint to add a new address or update an existing one.
  static const String addressAddUpdate = '$apiVersion/save_address';

  /// Endpoint to delete address.
  static const String deleteAddressListing = '$apiVersion/delete_address';

  /// Endpoint to list_of_store'.
  static const String listOfStore = '$apiVersion/list_of_store';

  /// list_of_brand
  static const String listOfBrands = '$apiVersion/list_of_brand';

  /// Endpoint to category List.
  static const String categoryListing =
      '$apiVersion/list_of_ecommerce_categories';

  /// Endpoint to get category details including child categories.
  static const String categoryDetails = '$apiVersion/category_details';

  /// Endpoint to Deals List.
  static const String dealsListing = '$apiVersion/get_best_deals';

  /// Endpoint to get product listing.
  static const String productListing = '$apiVersion/product_listing';

  /// Endpoint to get banner listing.
  static const String bannerListing = '$apiVersion/home_banner';

  ///post api end points
  static const String addToWishlist = '$apiVersion/add_to_wishlist';

  ///Delete api end points
  static const String removeFromWishlist = '$apiVersion/remove_from_wishlist';

  ///Change Password api end points
  static const String changePassword = '$apiVersion/changePassword';

  ///  post api Endpoint to get the user's wishlist.
  static const String getWishlist = '$apiVersion/customer/wishlist';

  ///This post method of productDetails
  static const String productDetails = '$apiVersion/product_details';

  /// Endpoint for contact us form submission.
  static const String contactUs = '$apiVersion/contactus';

  /// Endpoint for getting loyalty points.
  static const String loyaltyPoints = '$apiVersion/get_loyality_points';

  /// delete a user's account.
  static const String deleteAccount = '$apiVersion/deleteUser';

  /// logout API
  static const String logout = '$apiVersion/logOut';

  /// Endpoint for Notification List.
  static const String notificationList = '$apiVersion/getNotificationList';

  /// Endpoint for editProfile
  static const String editProfile = '$apiVersion/updateMyProfile';

  ///Endpoint for Read Notification Count
  static const String readNotificationCount =
      '$apiVersion/readNotificatonCount';

  /// Endpoint to get the logged-in user profile
  static const String getMe = '$subBaseUrl/auth/me';

  /// Endpoint to get all subscription plans
  static const String getAllPlans = '$subBaseUrl/plans/getAll';

  /// Endpoint to create subscription
  static const String createSubscription = '$subBaseUrl/subscriptions/create';

  /// Endpoint to get leaderboard
  static const String getLeaderboard = '$subBaseUrl/common/leaderboard';

  /// Endpoint to get all trades
  static const String getAllTrades = '$subBaseUrl/common/trades/getAll';

  /// Endpoint to get trade details
  static const String getTradeDetails = '$subBaseUrl/common/trades';

  /// Trades tab — signals available for the user's subscription plan.
  static const String getTradesByPlan = '$subBaseUrl/trade/my-trades-by-plan';

  /// Endpoint to get client profile
  static const String getClientProfile = '$subBaseUrl/client/profile';

  /// Endpoint to update client profile
  static const String updateClientProfile = '$subBaseUrl/client/update-profile';

  /// Endpoint to upload client profile picture
  static const String uploadProfilePicture = '$subBaseUrl/client/upload-profile-picture';

  /// Endpoint prefix to take a trade
  static const String takeTrade = '$subBaseUrl/client/trades';

  /// My Trades tab — client's taken / personal trades.
  static const String clientMyTrades = '$subBaseUrl/client/my-trades';

  /// Endpoint to search trades
  static const String searchTrades = '$subBaseUrl/trade/search';

  /// Endpoint to register/unregister crypto live prices
  static const String cryptoLivePrice = '$subBaseUrl/crypto-market/live-price';

  /// Endpoint to register/unregister market live prices
  static const String marketLivePrice = '$subBaseUrl/market/live-price';

  /// Endpoint to get trade results
  static const String getTradeResults = '$subBaseUrl/trade/results';

  /// Endpoint to get client dashboard data
  static const String clientDashboard = '$subBaseUrl/client/dashboard';
}
