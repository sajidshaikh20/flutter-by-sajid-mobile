import '../../../utils/exports.dart';

/// Constants are must be define here
/// Constants which don't need Localization
/// the Constants which depends on Localization should be defined in AppStrings Class
abstract class AppConstant {
  static const int crossAxisCount2 = 2;
  static const int otpTextLength = 4;
  static const int zero = 0;
  static const int one = 1;
  static const String zeroStr = "0";
  static const String oneStr = "1";
  static const String empty = "";
  static const String plus = "+";
  static const String newOrderStatus = "new";
  static const String pastOrderStatus = "past";
  static const int encryptionLength = 16;
  static const int emailLength = 50;
  static const String india = "India";
  static const String kuwait = "Kuwait";
  static const String android = "android";
  static const String cashOnDelivery = "cashondelivery";
  static const String success = "success";
  static const String ios = "ios";
  static const String web = "web";
  static const double smallDeviceHeight = 800;
  static const double webPixelWidth = 1200;
  static const double mobilePixelWidth = 600;
  static const double maxScrollExtent = 1500;
  static const String en = "en";
  static const String ar = "ar";
  static const String nonceKey =
      "0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._";
  static const String updateApp = "force_update_maintainance_config";
  static const String update = "Update";

  static const String playStoreURL =
      "https://play.google.com/store/apps/details?id=";
  static const String appstoreURL = "https://apps.apple.com/app/";
  static const String appId = "base.com.flutterbysajid.app";
  static const String appStoreId = "kdd-online-grocery/id1551339483";
  static const String stage = "stage";
  static const String prod = "prod";
  static const String promotion = "promotion";
  static const String product = "product";
  static const String order = "order";
  static const String delivery = "delivery";
  static const String pickup = "pickUp";
  static const String pickup1 = "pickup";
  static const String pickupStarted = "Pickup Started";
  static const String promotional = "promotional";
  static const String websiteIdDefault = "1";
  static const String customerTokenDefault = "";
  static const int superSaleLength = 4;
  static const String entityIdDefault = "1";
  static const String qtyDefault = "1";
  static const int entityIdDefaultInt = 1;
  static const String defaultCartQty = "1";
  static const int defaultListLength = 30;
  static const int limitProduct = 10;
  static const int limitDeal = 7;
  static const int limitCategory = 8;
  static const int limitCategoryList = 20;
  static const int limitReviewRatingList = 8;
  static const int limitMyOrderList = 4;
  static const int shimmerCategoryLength = 7;

  static const String defaultSelectedIndex = "-1";
  static const String defaultCountry = "KW";
  static const String defaultCountryCode = "+965";
  static const int defaultCountryCodeInt = 965;
  static const int badgeCountCountMoreThan1000 = 999;
  static const String badgeCountMoreThan1000 = "999+";
  static const int max1000 = 1000;
  static const int minLengthMobileNumber = 8;
  static const int maxLengthMobileNumber = 14;
  static const int commentLength = 10;
  static const int recentLength = 10;
  static const int pageNum = 1;
  static const int limitingTextInputFormatter = 200;
  static const int reviewItemCount = 5;
  static const int mainIndex = 0;
  static const int itemCount5 = 5;
  static const int itemCount2 = 2;
  static const int itemCount3 = 3;
  static const int itemCount7 = 7;
  static const int itemCount8 = 8;
  static const double itemCount16 = 16;

  static const int width380 = 380;
  static const String officeHours = "(MONDAY - FRIDAY 10 AM TO 8 PM )";
  static const String office = "office";
  static const String work = "work";
  static const String home = "home";
  static const String idKey = "Id:";

  static const String editProfile = "editProfile";
  static const String newsMedia = "News & Media";
  static const String dateFormatPattern = "dd/MM/yyyy";
  static const String errorForWishlist = "Failed to load wishlist";

  static const String itemAddedSuccessMsg = "Item Added Successfully ";

  static const String wishlistDeleteSuccessMsg =
      "WishList Deleted Successfully";

  static const String intialSearchValue = "0";
  static const String nextAvailableSlotKey = "Next Available Slot";
  static const String newsMediaKey = "News & Media";

  static const String maxSearchValue = "100";

  static const String male = "male";
  static const String female = "female";
  static const String facebookUrl = "";
  static const String changeVisibility = "Change Visibility";
  static const String instagramUrl = "";
  static const String twitterUrl = "";
  static const String youtubeUrl = "https://www.youtube.com/";
  static const String staticAddress =
      "Lotus Corporate Park,Off, Western Express Hwy, Geetanjali Railway Colony,";
  static const String staticMiles = "1mi";
  static const String moveLocation = "Move the map to set the location";
  static const String dummyToken =
      "cMDDqwCwTdiNxMCcZvKYCN:APA91bG8tIcXusfV9piXj_aDNRGPye4EamxNQNPJNps9_zHAPS5NZzKMVAc_GVdydR7jJqrmk6SWdUxdOgAXBamXMvj8GHvi1bMbdLoyYoKXlOfR4YCQ0LM";

  static const List<String> ratingValues = ["0", "11", "12", "13", "14", "15"];

  static const double initialRating = 0;
  static const double maxRating = 5;
  static const double minRating = 0;
  static const double max = 100;
  static const String defaultAEDPrice = "AED 0.00";
  static const String defaultCAPrice = "CA\$ 0.00";
  static const String defaultUKPrice = "€ 0.00";
  static const String defaultSARPrice = "SAR 0.00";
  static const String transactionId = "Transaction ID #123456";
  static const String staticDate = "12/12/2024";
  static const String staticDescription = "description";
  static const String staticAmount = "amount";
  static const String appName = "FlutterBySajid";

  static const String productNameForFrequentBought =
      "Rooibos organic herbal tea - 25 teabags in foil... wrapped envelopes";
  static const String priceForFrequentBought = "300 AED";
  static const String freeGiftCardMsg =
      "Free Gift when you spend AED 100 Above";

  // Define the latitude and longitude as constants
  static const double targetLatitude = 19.223537;
  static const double targetLongitude = 72.904741;
  static const double zoomLevel = 11.5;

  static const String shareDetails = "Share Details";

  static const String desiredArray = "desiredArray";
  static const String filteredOptionList = "filteredOptionList";
  static const String selectedLabel = "selectedLabel";
  static const String doWeNeedToCallApi = "doWeNeedToCallApi";

  // it's app constant value for price
  static const String zeroPointZeroZero = "0.00";
  static const double maxZoom = 2.0;

  static const String phonoNo = "+971 46728894";

  static const String priceForShipping = "AED5.00";
  static const String sortingLowToHigh = "LOW_TO_HIGH";

  static const String freeGiftDesc =
      "Choose your premium gifts for orders of AED 100 & above";

  // Validation Keys
  static const String emptyEmail = "EMPTY_EMAIL";
  static const String invalidEmail = "INVALID_EMAIL";
  static const String invalidMobile = "INVALID_MOBILE";
  static const String emptyPassword = "EMPTY_PASSWORD";
  static const String invalidPassword = "INVALID_PASSWORD";

  static const String category = "category";
  static const List<String> imageExtensions = [
    'png',
    'jpg',
    'jpeg',
    'gif',
    'bmp',
    'webp',
  ];
  static const List<String> jsonExtensions = [
    'json',
  ];
  static const String somethingWentWrong = "Something went wrong";
  static const String selectShippingMethod = "Please select shipping method";
  static const String selectDateMethod = "Please select date & time slot";
  static const String contentType = "application/x-www-form-urlencoded";
  static const String defaultLanguageAlignment = "LTR";
  static const String rtlLanguageAlignment = "RTL";

  static const String iHaveChangedMyMindKey = "I have changed my mind";
  static const String iBoughtTheWrongItemKey = "I bought the wrong item(s)";
  static const String pleaseSelectLanguageKey = "Please select language";
  static const String rooibosOrganicHerbalTea = "Rooibos organic herbal tea";
  static const String aed320 = "AED 320.2";
  static const String aed32 = "AED 320.2";
  static const String markerId = "1";



  static const String pageNotFound = "Page not found!!!";
  static const String freeTxtForSpan = "Free";
  static const String giftTxtForSpan = "Gift";
  static const String tel = "tel";
  static const String mailTo = "mailto";
  static const String whatsapp = "https://wa.me/";
  static const String shareLink = "Sign up and get 100 points on your first order!";

  static const String locationPermission = "Location Permission";
  static const String Permission = "Permission";


  static const String cairoFontFamily = "cairo";
  static const String keyPleaseEnterYourQuantity = "Please enter your quantity";

  static const int youMaxLikeCellMainIndex = 0;
  static const int reivewItemsLength = 3;

  static const int productHeaderMainIndexZero = 0;
  static const int productHeaderIndexMinusOne = -1;
  static const int productDetailsTabBarLength = 3;
  static const int shimmerGrey300 = 300;
  static const int shimmerGrey400 = 400;
  static const appleSignInFailed = "Apple Sign in Failed";
  static const googleSignInFailed = "Google Sign in Failed";
  static const facebookSignInFailed = "Facebook Sign in Failed";
  static const facebookSignInSuccess = "facebook Sign in Complete";
  static const googleSignInSuccess = "Google Sign in Complete";
  static const appleSignInSuccess = "Apple Sign in Complete";





  static const String testingEmail = 'Test@gmail.com';
  static const String dummyProductMango =
      'Mango Peach Beverage (0% Sugar) 250ml';
  static const String dummyProductName =
      'Mango Peach Beverage (0% Sugar) 250ml consectetur adipiscing elit';
  static const String dummyProductPrice = '11KD';
  static const String dummyProductPrice2 = '17KD';
  static const String dummyProductPrice3 = '20.44 KD';



  static const String salmiyahAddress = "Salmiyah, Block 12";
  static const String salmiyahAddressTail =
      " Al Moghira Ben Shaaba St. Facing Al Ikhlass Mosque";
  static const String address =
      'Salmiyah, Block 12, Al Moghira Ben Shaaba St. Facing Al Ikhlass Mosque ';
  static const int notificationCount = 99;
  static const double minRange = 0;
  static const double maxRange = 0;
  static const String cartItem = 'Cart ( 2 Items)';

  // Deprecated - use DealsTagName.bestDeals.value instead
  // Deprecated - use DealsScreen.home.value instead
  static const String dealsParamScreen = 'home';



  static const String dummyDairyName = 'Dairy';
  static const String dummyCartonName = 'Carton - 18 Pieces';
  static const String dummyPacksName = 'Pack of 6';
  static const double ratingNumber = 4.5;
  static const int totalReviews = 135;

  // Subtotal details
  static const String subtotalTitle = 'Subtotal';
  static const String subtotalFormattedValue = '16.50 KD';

  // Delivery Charges details
  static const String deliveryChargesTitle = 'Delivery Charges';
  static const String deliveryChargesFormattedValue = '3.50 KD';

  // Loyalty/Tax details
  static const String loyaltyAppliedTitle = 'Loyalty Applied (Used 144 points)';
  static const String loyaltyAppliedFormattedValue = '-1.44 KD';
  static const String refundReceived = '+ 1.44 KD';
  static const String amountUsed = '- 10.44 KD';

  // Grand Total details
  static const String totalFormattedValue = '20.44 KD';



  static const String transactionIdValue = '3546446115445';
  static const String orderId = "#45156322";
  static const String orderDate = "19 Dec 2024, 10:45 AM";

  static const List<String> listOfLanguage = [
    AppConstantString.englishText,
    AppConstantString.arabicText
  ];

  static const String term_conditions = 'https://stage-flutterbysajid.odoo.com/terms-and-conditions';
  static const String term_conditions_ar = 'https://stage-flutterbysajid.odoo.com/ar/terms-and-conditions';
  static const String privacy_policy = 'https://stage-flutterbysajid.odoo.com/privacy-policy';
  static const String privacy_policy_ar = 'https://stage-flutterbysajid.odoo.com/ar/privacy-policy';
  static const String about_us = 'https://stage-flutterbysajid.odoo.com/about-us';
  static const String about_us_ar = 'https://stage-flutterbysajid.odoo.com/ar/about-us';
  static const String faq = 'https://stage-flutterbysajid.odoo.com/faq';
  static const String faq_ar = 'https://stage-flutterbysajid.odoo.com/ar/faq';

  static const String storeLocation = '07:00 to 24:00';
  static const String reviewDate = '29 Jan 2025';

  static const String dummyTime = '12:56 PM';
  static const String dummyTrackOrderDate = "14 Dec 2024";

  static const List<CategoryResponseModel>? tabLabels =
      <CategoryResponseModel>[];
  static const String all = 'All';
  static const String dairy = 'Dairy';
  static const String pointsHistory = "8000 Pt = 80KD";
  static const String otpTimer = '00:54';

  static const int maxPreviewLength = 250; // Max length before "More" appears

  static const String pointsExpiryDate = "Points Expiring 20 | 24 April 2025";
  static const String pointsExpiryNote =
      "Each (order, birthday, refer first order) earned point will be valid for 365 days and if user is not redeeming then automatically that will be lapsed after 365 days";
  static const String pointsHistoryDate = "24 Apr 2024,\n10:15 AM";

  static const String loyaltyPointheaderNotes =
      "Earn 92000 points more to reach Gold tier";
  static const String loyaltyPointheaderBold1 = '92000';
  static const String loyaltyPointheaderBold2 = 'points';

  static const String platformNotSupportedCode = 'PlatformNotSupported';
  static const String platformNotSupportedMessage =
      'This platform is not supported';
}

/// Enum for product types
enum ProductType {
  brand('Brand'),
  category('category');

  const ProductType(this.value);

  final String value;
}

/// Enum for product types
enum BannerType {
  fullWidth('full_width'),
  secondary('secondary');

  const BannerType(this.value);

  final String value;
}

/// Enum for deals tag names
enum DealsTagName {
  bestDeals('Best Deals'),
  youMayAlsoLike('You May Also Like'),
  related('related'),
  trending('trending');

  const DealsTagName(this.value);

  final String value;
}

/// Enum for deals screen values
enum DealsScreen {
  home('home'),
  cart('cart'),
  productDetail('product_detail');

  const DealsScreen(this.value);

  final String value;
}

abstract class NotificationConst {
  static const String channelGroupKey = 'basic_channel_group';
  static const String channelGroupName = 'Basic group';
  static const String channelKey = 'basic_channel';
  static const String channelName = 'Basic notifications';
  static const String channelDescription =
      'Notification channel for basic tests';
}

abstract class APIConstant {
  static const String defaultWebsiteId = "1";

  // static const String defaultStoreId = "1";
  static const String defaultFactorValue = '2.8125';
  static const String defaultCurrency = "AED";
  static const String website = 'website';
  static const String store = 'store';
  static const String id = 'id';
  static const String query = 'query';
  static const String start = 'start';
  static const String size = 'size';
  static const String aggs = 'aggs';
  static const String customer = "customer";
  static const String guest = "guest";
  static const String sort = 'sort';
  static const String editApiCalled = 'editApiCalled';
  static const String type = 'type';

  static const String storeId = 'storeId';
  static const String quoteId = 'quoteId';
  static const String websiteId = 'websiteId';
  static const String customerToken = 'customerToken';
  static const String productId = 'productId';
  static const String title = 'title';
  static const String detail = 'detail';
  static const String nickname = 'nickname';
  static const String ratings = 'ratings';
  static const String qty = 'qty';
  static const String itemIds = 'itemIds';
  static const String itemQtys = 'itemQtys';
  static const String mFactor = 'mFactor';
  static const String username = 'username';
  static const String password = 'password';
  static const String currency = 'currency';
  static const String os = 'os';
  static const String width = 'width';
  static String files = 'files';
  static const String android = 'android';
  static const String ios = 'ios';
  static const String token = 'token';
  static const String params = 'params';
  static const String eTag = 'eTag';
  static const String pageNumber = 'pageNumber';
  static const String itemId = 'itemId';
  static const String incrementId = 'incrementId';
  static const String firstName = 'firstName';
  static const String lastName = 'lastName';
  static const String mobileNumber = 'mobileNumber';
  static const String mobileNumberPrefix = 'mobileNumberPrefix';
  static const String email = 'email';
  static const String category = 'category';
  static const String categoryId = 'category_id';
  static const String isFromSearch = 'isFromSearch';
  static const String filterData = 'filterData';
  static const String yes = "1";
  static const String no = "0";
  static const String regionId = "region_id";
  static const String guestKey = "guest";
  static const String customerKey = "customer";
  static const String freeGift = "freeGift";
  static const String defaultQty = "1";
  static const String badRequest = "Bad Request";
  static const String contentType = "application/json";

  static const String poorInternetConnectionKey = "Poor internet connection";
  static const String badRequestStateKey = "Bad Request";
  static const String serverNotRespondKey = "Server not responding";
  static const String unauthorizedKey = "Unauthorized";

  static const String noInternetConnectionDescriptionKey =
      "please check your internet connection and try again";

  static const String cookie =
      'private_content_version=6d5fe654c801a721bf77a4b59bb1824c';
}

abstract class ApiConst {
  /// The argument key for caching.
  static const String cacheArgument = 'cache';

  /// The argument key for cache validation time.
  static const String cacheDurationArgument = 'validate_time';

  /// The default cache time in minutes.
  static const int defaultCacheTime = 30;
}

abstract class DataBaseConst {
  static const String hiveBoxDBName = "recentview";
}

abstract class AppAnalyticsConstant {
  //Event key names
  static const String itemId = "Item_id";
  static const String itemName = "item_name";
  static const String price = "price";
  static const String items = "items";
  static const String sku = "sku";
  static const String curruncyCode = "curruncy_code";

  //Event Time
  static const String eventTime = "Event_time";

  //Event Source
  static const String source = "Source";

  //Event Name
  static const String appInstalled = "App_Installed_Screen";
  static const String userSignedUp = "User_Signed_Up";
  static const String userLoggedIn = "User_Logged_In";
  static const String viewItem = "View_Item";
  static const String viewItemList = "View_item_list";
  static const String login = "login";
  static const String method = "costomer_token";
  static const String signUp = "sign_up";
  static const String viewCart = "view_cart";
  static const String beginCheckout = "begin_checkout";
  static const String purchase = "purchase";
  static const String addToCart = "add_to_cart";
  static const String removeFromCart = "remove_from_cart";
  static const String page = "page";

  //FireBase Custom Events
  static const String eventActionField = "actionField";
  static const String currency = "currency";
  static const String userId = "userid";
  static const String transactionId = "transaction_id";
  static const String affiliation = "affiliation";
  static const String value = "value";
  static const String tax = "tax";
  static const String shipping = "shipping";
  static const String discount = "discount";
  static const String coupom = "coupon";

  //Web engage event name implement through firebase
  static const String productSearched = "product_Searched";
  static const String searchKeyword = "Search_Keyword";
  static const String itemCount = "Item_Count";
  static const String tags = "tags";

  // Banner Clicked event
  static const String bannerClicked = 'banner_clicked';
  static const String bannerId = 'banner_id';
  static const String bannerImage = 'banner_image';
  static const String bannerName = 'banner_name';
  static const String bannerCategory = 'banner_category';
  static const String cta = 'cta';
}

abstract class AppConstantString {
  static const String selectLanguageEnglish =
      'Please select your preference between\nthese two languages';
  static const String selectLanguageArabic =
      'يرجى تحديد تفضيلاتك بين\nهاتين اللغتين';
  static const String englishText = 'English';
  static const String login = 'Login';
  static const String arabicText = 'العربية';
  static const String welcomeMsg = 'Hello!\nWelcome to Dukkan';
}
