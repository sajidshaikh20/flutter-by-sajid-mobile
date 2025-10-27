/// A centralized class containing all the route paths used in the application.
///
/// Each constant represents a unique route name used for navigation
/// within the app. Sub-paths (nested routes) **must not** start with a `/`.
///
/// Example usage:
/// ```dart
/// context.router.pushNamed(AppPaths.login);
/// ```
abstract class AppPaths {
  /// Login screen route.
  static const String login = '/login';

  /// New login screen route.
  static const String loginNew = '/LoginNew';

  /// Dashboard or main landing page route.
  static const String dashboard = '/dashboard';

  /// Nested tab view route for handling multiple tabs.
  static const String nestedTabView = 'nested_tab_view';

  /// Default first tab route (empty path).
  static const String tabOne = '';

  /// Details page route for the first tab.
  static const String tabOneDetail = 'tab_one_detail';

  /// Second tab route.
  static const String tabTwo = 'tab_two';

  /// Maintenance screen route.
  static const String maintenance = '/maintenance';

  /// Splash screen route.
  static const String splash = '/splash';

  /// Social login screen route.
  static const String socialLogin = '/socialLogin';

  /// Forgot password page route.
  static const String forgotPassword = '/forgetPassword';

  /// OTP verification screen route.
  static const String otpVerification = '/otpVerification';

  /// Reset password page route.
  static const String resetPassword = '/resetPassword';

  /// Password changed confirmation route.
  static const String changedPassword = '/changedPassword';

  /// Signup or registration page route.
  static const String signup = '/signup';

  /// Country selection screen route.
  static const String countrySelection = '/selectCountry';

  /// Language selection screen route.
  static const String languageSelection = '/selectLanguage';

  /// Edit profile page route.
  static const String editProfile = '/editProfile';

  /// OTP verification route used for account validation.
  static const String verifyOtp = '/verifyOtp';

  /// Home page route (sub-path).
  static const String home = 'home';

  /// Category page route (sub-path).
  static const String category = 'category';

  /// Offers or promotions page route (sub-path).
  static const String offers = 'offers';

  /// Account or profile page route (sub-path).
  static const String account = 'account';

  /// Cart page route.
  static const String cartPage = '/cartPage';

  /// Account detail page route (sub-path).
  static const String accountDetail = 'accountDetail';

  /// Contact Us page route.
  static const String contactUs = '/contactUs';

  /// Request a callback page route.
  static const String requestACallback = '/requestACallBack';

  /// Product view page route.
  static const String productView = '/productView';

  /// Filter page route.
  static const String filterPage = '/filterPage';

  /// Product details page route.
  static const String productDetails = '/productDetails';

  /// My orders listing page route.
  static const String myOrderListing = '/myOrderListing';

  /// My order details page route.
  static const String myOrderDetails = '/myOrderDetails';

  /// My order cancel page route.
  static const String myOrderCancel = '/myOrderCancel';

  /// Write a review page route.
  static const String writeReview = '/writeReview';

  /// Review page route.
  static const String review = '/review';

  /// Review listing page route.
  static const String reviewListing = '/reviewListing';

  /// Photo gallery page route.
  static const String photoGallery = '/photoGallery';

  /// Category listing page route.
  static const String categoryListing = '/categoryListing';

  /// Search page route.
  static const String search = '/search';

  /// Add new address page route.
  static const String addAddress = '/addAddress';

  /// Address list page route.
  static const String addressList = '/addressList';

  /// Wishlist page route (sub-path).
  static const String wishlist = 'wishlist';

  /// Payment screen route.
  static const String payment = '/payment';

  /// Track order page route.
  static const String trackOrder = '/trackOrder';

  /// Refer a friend page route.
  static const String referFriend = '/referFriend';

  /// Currency selection screen route.
  static const String selectCurrency = '/selectCurrency';

  /// Order return page route.
  static const String orderReturn = '/orderReturn';

  /// Shipping method selection page route.
  static const String shippingMethod = '/shippingMethod';

  /// Payment success or failure status page route.
  static const String paymentSuccessFailure = '/paymentSuccessFailure';

  /// About Us detail page route.
  static const String aboutUsDetailPage = '/aboutUsDetailPage';

  /// View rewards history page route.
  static const String viewRewardsHistory = '/viewRewardsHistory';

  /// My wallet page route.
  static const String myWallet = '/myWallet';

  /// My review and rating page route.
  static const String myReviewRating = '/myReviewRating';

  /// My returns page route.
  static const String myReturn = '/myReturn';

  /// No internet connection page route.
  static const String noInternet = '/noInternet';

  /// Notification page route (sub-path).
  static const String notification = 'notification';

  /// Checkout address selection page route.
  static const String checkoutAddressPage = '/checkoutAddressPage';

  /// Data not found placeholder page route.
  static const String dataNotFound = '/dataNotFound';

  /// Product listing page with filter route.
  static const String productListingWithFilter = '/productListingWithFilter';

  /// Select address page route.
  static const String selectAddressPage = '/selectAddressPage';

  /// Add or update address page route.
  static const String addAddressPage = '/addAddressPage';

  /// Store locations page route.
  static const String storeLocations = '/storeLocations';

  /// Gift card page route.
  static const String giftCard = '/giftCard';

  /// Loyalty points page route.
  static const String loyaltyPoints = '/loyaltyPoints';

  /// CMS (Content Management System) page route.
  static const String cmspage = '/cmsPage';

  /// Notification settings page route.
  static const String notificationSetting = '/notificationSetting';

  /// Points history page route.
  static const String pointsHistory = '/pointsHistory';

  /// Change language page route.
  static const String changeLanguage = '/changeLanguage';

  /// Store receipt page route.
  static const String storeReceipt = '/store_Receipt';
}
