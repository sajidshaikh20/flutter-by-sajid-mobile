/// A class containing API endpoint constants used in the app.
abstract class Apis {
  /// Base URL for the service.

  static const String subBaseUrl = '/_svc/api/md';

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
  static const String login = '$apiVersion/login';

  /// Endpoint to reset password using mobile number.
  static const String forgotPasswordWithMobile =
      '$apiVersion/forgot_password_with_mobile';

  /// Endpoint to reset password using email.
  static const String forgotPasswordWithEmail =
      '$apiVersion/forgot_password_with_email';

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
}
