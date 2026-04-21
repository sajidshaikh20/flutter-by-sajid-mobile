import '../../utils/exports.dart';

/// Represents the different environments the application can run in.
enum Environment {
  /// Staging environment for testing and pre-production.
  stage,

  /// Production environment for live usage.
  production,
}

/// Represents the different types of API requests.
enum ApiType {
  /// HTTP GET request.
  get,

  /// HTTP POST request.
  post,

  /// HTTP DELETE request.
  delete,

  /// Represents a DELETE request.
  patch,
}

/// Represents the possible states of a base state.
enum BaseStateStatus {
  /// The initial state before any action is taken.
  initial,

  /// The state when data is being loaded.
  loading,

  /// The state when data has been successfully loaded.
  success,

  /// The state when data loading has failed.
  failure,
}

/// Represents the different order statuses.
enum OrderStatus {
  /// Order is being processed.
  processing('Processing'),

  /// Order has been placed successfully.
  orderPlaced('Order Placed'),

  /// Order was canceled.
  canceled('Canceled'),

  /// Payment for the order is pending.
  pendingPayment('Pending Payment'),

  /// Order is out for delivery.
  outForDelivery("out_for_delivery"),

  /// Order has been completed.
  complete("complete"),

  /// Payment is under review.
  paymentReview("payment_review"),

  /// Order is in a pending state.
  pending("pending");

  /// Status of the order.
  final String status;

  const OrderStatus(this.status);
}

/// Enum representing different bottom sheet data types.
enum BottomSheetDataType {
  /// Country data type.
  country,

  /// State data type.
  state,

  /// City data type.
  city,
}

/// Enum representing different Facebook permissions.
enum FacebookPermissionEnum {
  /// Email permission.
  email("email"),

  /// Public profile permission.
  publicProfile("public_profile"),

  /// name
  name("name"),

  /// first_name
  firstName("first_name"),

  /// last_name
  lastName("last_name"),

  /// picture
  picture("picture");

  /// Permission value.
  final String value;

  const FacebookPermissionEnum(this.value);
}

/// Enum representing different address types.
enum AddressType {
  /// Home address.
  home("Home"),

  /// Work address.
  work("Work"),

  /// Other address.
  other("Other");

//// Name of the address type.
  final String name;

  const AddressType(this.name);
}

/// Enum defining the types of carousel items.
enum CarouselType {
  /// Image carousel item.
  image("image"),

  /// Product carousel item.
  text("text"),

  /// Product carousel item.
  product("product");

  /// Type of the carousel item.
  final String type;

  const CarouselType(this.type);
}

/// Enum defining the update operation type.
enum ProductListUpdateType {
  ///
  qty,

  ///
  wishlist,

  ///
  loader,
}

/// Enum defining the main tabs of the application.
enum TabState {
  /// Home tab.
  home,

  /// Watchlist tab.
  watchlist,

  /// Bank transfer tab.
  bankTransfer,

  /// Chat support tab.
  chatSupport,

  /// Legacy: category (kept for compatibility).
  category,

  /// Legacy: offers (kept for compatibility).
  offers,

  /// Legacy: profile tab (kept for compatibility).
  myAccount,

  /// Cart tab.
  cart,
}

/// Enum representing different types of password fields.
enum PasswordFieldType {
  /// Old password field.
  oldPassword,

  /// New password field.
  newPassword,

  /// Confirm password field.
  confirmPassword,
}

/// Enum defining product tab categories.
enum ProductTab {
  /// All products tab.
  description,

  /// Reviews tab.
  ingredients,

  /// Ingredients tab.
  reviews,
}

/// Enum representing the state of the shopping cart.
enum StatusOfCart {
  /// Initial state.
  initial,

  /// Loading state.
  loading,

  /// Success state.
  success,

  /// Failure state.
  failure,
}

/// Enum representing different actions related to an order list.
enum MyOrderListAction {
  /// Initial state.
  myOrderListInitial,

  /// Loaded state.
  myOrderListLoaded,

  /// success state.
  reOrderSuccess,

  /// Failed state.
  myOrderListFailed,

  /// No data state.
  myOrderListNoData,
}

/// {@template navigate_to}
/// Enum defining navigation destinations for the application.
///
/// This enum is used to define where a user should be navigated to
/// after completing a certain action, such as writing a review or tracking
/// an order.
/// {@endtemplate}
enum NavigateTo {
  /// {@macro navigate_to}
  none,

  /// {@macro navigate_to}
  writeReview,

  /// {@macro navigate_to}
  trackOrder,
}

/// {@template my_account_item_type}
/// Enum defining different sections or actions available in the My Account page.
///
/// This enum is used to represent the various options a user has
/// when managing their account, such as editing their profile, changing
/// their password, viewing their orders, and more.
/// {@endtemplate}
enum MyAccountItemType {
  /// {@macro my_account_item_type}
  editProfile,

  /// {@macro my_account_item_type}
  changePassword,

  /// {@macro my_account_item_type}
  myOrders,

  /// {@macro my_account_item_type}
  myReturns,

  /// {@macro my_account_item_type}
  myWallet,

  /// {@macro my_account_item_type}
  signUp,

  /// {@macro my_account_item_type}
  signIn,

  /// {@macro my_account_item_type}
  myAddress,

  /// {@macro my_account_item_type}
  myWishList,

  /// {@macro my_account_item_type}
  myReviewAndRating,

  /// {@macro my_account_item_type}
  referAndEarn,

  /// {@macro my_account_item_type}
  country,

  /// {@macro my_account_item_type}
  language,

  /// {@macro my_account_item_type}
  currency,

  /// {@macro my_account_item_type}
  aboutUs,

  ///
  contactUs,

  ///
  help,

  ///
  none,
}

/// Enum representing wishlist actions.
enum WishListAction {
  /// Initial state.
  wishListInitial,

  /// Loaded state.
  wishListLoaded,

  /// No data state.
  wishListNoData,

  /// Deleted successfully state.
  wishListDeletedSuccessfully,

  /// Failed state.
  wishListFailed,

  /// Added to card successfully state.
  wishListAddToCardProduct,

  /// Failed to add to card state.
  wishListAddToCardProductFailed,

  /// Updated successfully state.
  wishListUpdateCardProduct,

  /// Failed to update state.
  wishListUpdateCardProductFailed,

  /// Added to card successfully state.
  wishListToCard,
}

/// Enum defining different contact list types.
enum ContactListType {
  /// Phone contact type.
  phone,

  /// Email contact type.
  email,

  /// Whatsapp contact type.
  whatsapp,

  /// Facebook contact type.
  requestACallback,
}

/// Enum representing API call states for different screens.
enum BackScreenApiCall {
  /// Initial state.
  homeScreen,

  /// Initial state.
  cartScreen,

  ///
  none,
}

/// Enum defining social login methods.
enum SocialLoginType {
  /// Apple login.
  apple,

  /// Google login.
  google,

  /// Facebook login.
  facebook,

  /// Normal login.
  normalLogin,
}

/// Enum representing different screen types.
enum ScreenType {
  /// mobile
  mobile,

  /// tablet
  tablet,

  /// desktop
  desktop,
}

/// Enum representing under maintenance status.
enum UnderMaintenanceType {
  /// Under maintenance.
  none(0),

  /// text
  text(1),

  /// image
  image(2);

  /// Type of under maintenance.
  final int type;

  const UnderMaintenanceType(this.type);
}

/// Enum representing update maintenance type.
enum UpdateMaintenanceType {
  /// Update
  maintenance,

  /// No update
  none,

  /// Text
  force,

  /// Image
  optional;

  /// Type of update maintenance.
  const UpdateMaintenanceType();
}

/// Enum defining supported language codes.
enum LanguageCode {
  ///english
  en,

  ///arabic
  ar, // Arabic
}

/// Enum defining new order statuses.
enum OrderStatusNew {
  /// Order is being processed.
  placed,

  /// Order has been placed successfully.
  delivered,

  /// Order was canceled.
  canceled,

  /// Order has been collected.
  collected,
}

/// Enum representing different file types.
enum FileType {
  /// Image file type.
  image,

  /// PDF file type.
  jsonFile,

  /// Other file type.
  unknown,
}

/// Enum representing different cart operation types.
enum CartOperation {
  /// Add item to cart.
  add,

  /// Increase quantity of item in cart.
  increase,

  /// Decrease quantity of item in cart.
  decrease,

  /// Remove item from cart.
  remove,
}

/// Enum representing different types of notifications in the app.
enum NotificationType {
  /// Delivery notification type.
  deliverd('deliverd'),

  /// Pickup notification type.
  pickup('pickup'),

  /// Loyalty points notification type.
  loyalty('loyalty'),

  /// Promotion notification type.
  promotion('promotion');

  /// The string value of the notification type.
  final String value;

  /// Creates a notification type with the given value.
  const NotificationType(this.value);

  /// Get SVG icon path based on enum
  String get iconPath {
    switch (this) {
      case NotificationType.deliverd:
        return Assets.svgs.icOrderDelivery.path;
      case NotificationType.pickup:
        return Assets.svgs.icPickup.path;
      case NotificationType.loyalty:
        return Assets.svgs.icLoyalty.path;
      case NotificationType.promotion:
        return Assets.svgs.icPromotion.path;
    }
  }

  /// Converts a string value to the corresponding NotificationType enum safely.
  ///
  /// Returns [NotificationType.promotion] as fallback if no match is found.
  static NotificationType fromValue(String? value) {
    return NotificationType.values.firstWhere(
      (NotificationType e) =>
          e.value.toLowerCase() == (value ?? '').toLowerCase(),
      orElse: () => NotificationType.promotion, // fallback default
    );
  }
}

/// Documentation
///
/// [IndicatorType] is an enum that defines the position of the indicator line
/// in the custom bottom navigation bar.
///
/// The indicator can be placed either at the [top] or [bottom] of the navigation bar.
enum IndicatorType {
  /// Indicator at the top of the navigation bar.
  top,

  /// Indicator at the bottom of the navigation bar.
  bottom,
}

/// Enum representing different OTP verification flow types.
enum OtpFlowType {
  /// OTP verification for forgot password flow
  forgotPassword,

  /// OTP verification for signup flow
  signup,

  /// OTP verification for update email flow
  updateEmail,
}

/// Enum for validation types used in forms and input validation.
enum ValidationType {
  /// Required field validation.
  required,

  /// Optional field validation.
  optional,

  /// Street address validation.
  street,
}

/// Enum to define radio button position in UI components.
enum RadioPosition {
  /// Radio button positioned on the left side.
  left,

  /// Radio button positioned on the right side.
  right,
}

/// Enum representing track order status strings
enum TrackOrderStatus {
  /// Order has been placed
  orderPlaced('Order Placed'),

  /// Order has been confirmed/accepted
  confirmed('Confirmed'),

  /// Order has been assigned/processing
  assigned('Assigned'),

  /// Order is in delivery
  inDelivery('In Delivery'),

  /// Order has been delivered
  delivered('Delivered'),

  /// Pickup has started
  pickupStarted('Pickup Started'),

  /// Order has been picked up
  pickedUp('Picked Up');

  /// The string value of the status
  final String value;

  const TrackOrderStatus(this.value);

  /// Get enum from string value
  static TrackOrderStatus? fromValue(String? value) {
    if (value == null) return null;
    final String lowerValue = value.toLowerCase().trim();
    try {
      return TrackOrderStatus.values.firstWhere(
        (TrackOrderStatus e) => e.value.toLowerCase() == lowerValue,
      );
    } on StateError {
      return null;
    }
  }
}
