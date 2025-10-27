/// A class containing API endpoint constants used in the app.
abstract class Apis {
  /// Base URL for the service.
  ///
  ///
  static const String subBaseUrl = '/_svc/api/md';

  ///version number
  static const String apiVersion = '/v1';

  /// Endpoint for user-related actions.
  static const String user = 'users/';

  /// Endpoint to get the list of countries.
  static const String getCountryList = '$subBaseUrl/v1/country/';

  /// Endpoint to get the language configuration.
  static const String getLanguageList = '$subBaseUrl/v1/config/';

  /// Endpoint to get the list of available currencies.
  static const String getCurrencyList = '/mobikulhttp/store/currencyListing';

  /// Endpoint to get the list of offer products.
  static const String getOfferProductList = '/_svc/api/es/v1/list/';

  /// Endpoint to get home details.
  static const String getHomeDetails = '$subBaseUrl/v2/webhome/?';

  /// Endpoint to get home details notice.
  static const String getHomeDetailsNotice = '$subBaseUrl/v1/notice/?';

  /// Endpoint to get home banner details.
  static const String getHomeDetailsBanner = '$subBaseUrl/v1/webbanner/?';

  /// Endpoint to get home categories.
  static const String getHomeCategories = '/_svc/api/es/v2/categories/?';

  /// Endpoint to get product reviews.
  static const String getProductReview = '/_svc/api/es/v1/reviews/?';

  /// Endpoint to get search query results.
  static const String getSearchQuery = '/_svc/api/es/v1/search/?';

  /// Endpoint to add a product to the cart.
  static const String addToCartProduct = '/mobikulhttp/checkout/addtoCartV1';

  /// Endpoint to update cart product details.
  static const String updateCartProduct = '/mobikulhttp/checkout/updateCart';

  /// Endpoint to remove a product from the cart.
  static const String removeCartProduct =
      '/mobikulhttp/checkout/removeCartItemDetailsV1';

  /// Endpoint for user login.
  static const String getLogin = '/mobikulhttp/customer/logIn?';

  /// Endpoint to authenticate user login.
  static const String loginApi = '/mobikulhttp/customer/loginV1';

  /// Endpoint to move a wishlist item to the cart.
  static const String wishlistToCart = '/mobikulhttp/customer/wishlisttocart';

  /// Endpoint to get the list of user orders.
  static const String getOrderList = '/mobikulhttp/customer/orderlist?';

  /// Endpoint to reorder a user product.
  static const String getReOrder = '/mobikulhttp/customer/reOrder?';

  /// Endpoint to get account information.
  static const String getAccountInfo = '/mobikulhttp/customer/accountinfoData?';

  /// Endpoint to get the search list results.
  static const String getSearchList = '/_svc/api/es/v1/search/';

  /// Endpoint to get cart list data.
  static const String getCartListData = '/rest/V2/cart/details';



  /// Endpoint to set a selected checkout time slot.
  static const String setSlot = '/rest/V1/checkout/setslot';

  /// Endpoint to review and complete checkout payment.
  static const String reviewAndPayment = '/rest/V2/checkout/reviewandpayment';

  /// Endpoint to remove all items from the cart.
  static const String removeAllCartItem = '/mobikulhttp/checkout/emptyCart';

  /// Endpoint to fetch upsell products.
  static const String upsellApiCall = '/_svc/api/md/v1/upsell/';

  /// Endpoint to get free product details for promotions.
  static const String freeProductDetailApiCall =
      '/mobikulhttp/catalog/freeGiftProductCollectionV1';

  /// Endpoint to get the user's address list.
  static const String getAddressListData =
      '/mobikulhttp/customer/addressBookDataV1';

  /// Endpoint to delete a user address.
  static const String deleteAddress = '/mobikulhttp/customer/deleteAddress';

  /// Endpoint to place a user order.
  static const String placeOrder = '/mobikulhttp/checkout/placeorder';

  /// Endpoint to save the default address for the user.
  static const String saveDefaultAddress =
      '/mobikulhttp/customer/saveDefaultAddress';

  /// Endpoint to get CMS account data.
  static const String cmsAccountApi = '/_svc/api/md/v1/cms/';

  /// Endpoint to get CMS data.
  static const String cmsDataApi = '/mobikulhttp/extra/cmsData';

  /// Endpoint for user referral.
  static const String referFriendApi = '/mobikulhttp/customer/referfriend';

  /// Endpoint for user password recovery.
  static const String forgotPassword = '/mobikulhttp/customer/forgotpassword';

  /// Endpoint to get offers listing.
  static const String offersListing = '/_svc/api/es/v2/list/';

  /// Endpoint to get address form data for the user.
  static const String addressFormData = '/mobikulhttp/customer/addressformData';

  /// Endpoint to get address city data.
  static const String addressCity = '/mobikulhttp/customer/addressCity';

  /// Endpoint to save the user's address.
  static const String saveAddress = '/mobikulhttp/customer/saveAddress';

  /// Endpoint for user sign-up OTP.
  static const String signUpApi = '/mobikulhttp/customer/createAccountSentOtp';

  /// Endpoint to create a user account.
  static const String createAccountApi = '/mobikulhttp/customer/createAccount';

  /// Endpoint to save a user review.
  static const String saveReview = '/mobikulhttp/customer/saveReview';



  /// Endpoint to get the user's return orders.
  static const String myReturn = '/mobikulhttp/returnorder/orderlisting';

  /// Endpoint to get available shipping methods.
  static const String shippingMethod = '/rest/V2/checkout/shippingMethods';

  /// Endpoint to request a callback from customer support.
  static const String requestCallback = '/mobikulhttp/contact/post';

  /// Endpoint to view the user's reward history.
  static const String viewRewards = '/mobikulhttp/customer/rewardHistory';

  /// Endpoint to get the user's wallet balance.
  static const String myWallet = '/mobikulhttp/customer/getStoreCredit';

  /// Endpoint to save account information after verification.
  static const String saveAccountAfterVerify =
      '/mobikulhttp/customer/SaveAccountAfterVerify';


  /// Endpoint to send OTP for user signup.
  static const String signupUserOtp = '$apiVersion/signup_user_otp';

  /// Endpoint to verify OTP and complete user signup.
  static const String signupUserWithVerifyOtp = '$apiVersion/signup_user_with_verify_otp';

  /// Endpoint to fetch the list of available countries and languages.
  static const String listOfCountryAndLanguage = '$apiVersion/list_of_country_and_language';

  /// Endpoint for user login.
  static const String login = '$apiVersion/login';

  /// Endpoint to reset password using mobile number.
  static const String forgotPasswordWithMobile = '$apiVersion/forgot_password_with_mobile';

  /// Endpoint to reset password using email.
  static const String forgotPasswordWithEmail = '$apiVersion/forgot_password_with_email';

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
  static const String categoryListing = '$apiVersion/list_of_ecommerce_categories';

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

  /// Endpoint for addToCart.
  static const String addToCart = '$apiVersion/add_to_cart';

  /// Endpoint for updateToCart.
  static const String updateToCart = '$apiVersion/update_to_cart';

  /// Endpoint for removeToCart.
  static const String removeToCart = '$apiVersion/remove_from_cart';

  /// Endpoint for getRelatedProducts.
  static const String getRelatedProducts = '$apiVersion/get_related_products';

  /// Endpoint for getTrendingProducts.
  static const String getTrendingProducts = '$apiVersion/get_trending_products';

  ///getReviewSummary
  static const String getReviewSummary = '$apiVersion/get_review_summary';

  /// Endpoint to get payment methods.
  static const String paymentMethods = '$apiVersion/paymentMehods';

  /// Endpoint to get time slots.
  static const String timeSlots = '$apiVersion/timeslots';

  /// Endpoint to get cartDetails.
  static const String cartDetails = '$apiVersion/cart_details';

  /// Endpoint to create an order from cart (cart checkout confirm).
  static const String addOrder = '$apiVersion/addOrder';

  /// Endpoint for toggleNotificationStatus.
  static const String toggleNotificationStatus = '$apiVersion/toggle_notification_status';

  /// Endpoint for Notification List.
  static const String notificationList = '$apiVersion/getNotificationList';

  /// Endpoint for editProfile
  static const String editProfile = '$apiVersion/updateMyProfile';

  /// Endpoint for myOrder
  static const String myOrder = '$apiVersion/myOrder';

  /// Endpoint for update Email
  static const String updateEmail = '$apiVersion/updateEmail';

  /// Endpoint for rate Products
  static const String rateProducts = '$apiVersion/rateProducts';

  /// Endpoint for rate Order
  static const String rateOrder = '$apiVersion/rateOrder';

  /// Endpoint for Order Detail
  static const String myOrderDetail = '$apiVersion/orderDetails';

  /// Endpoint for My Review Summary
  static const String myReviewSummary = '$apiVersion/my_review_summary';

  ///Endpoint for My Review Summary
  static const String getFilterData = '$apiVersion/get_filter_data';

  ///Endpoint for Cancel Order
  static const String cancelOrder = '$apiVersion/cancelOrder';

  ///Endpoint for My Reorder
  static const String reOrder = '$apiVersion/reOrder';

  ///Endpoint for Apply Coupon Code
  static const String applyCoupon = '$apiVersion/apply_coupon_code';

  ///Endpoint for Apply Reward
  static const String applyReward = '$apiVersion/apply_reward';

  ///Endpoint for Read Notification Count
  static const String readNotificationCount = '$apiVersion/readNotificatonCount';

  ///Endpoint for changeStoreOrOrderMethod
  static const String changeStoreOrOrderMethod = '$apiVersion/change_store_or_order_method';
}
