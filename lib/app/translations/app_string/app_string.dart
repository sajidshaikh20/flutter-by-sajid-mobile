import '../../../utils/exports.dart';

/// An abstract class representing the application's string resources.
/// It is used for internationalization and localization of the app.
abstract class AppString {
  /// Retrieves the [AppString] instance from the given [BuildContext].
  /// This method is used to access localized strings within the app's widget tree.
  static AppString of(BuildContext context) {
    return Localizations.of<AppString>(context, AppString)!;
  }

  /// Key for the "delivery" string.
  String get deliveryKey;

  /// Key for the "pickup" string.
  String get pickupKey;

  /// Key for the "delivery to home" string.
  String get deliveryToHomeKey;

  /// Key for the "pickup from store" string.
  String get pickupFromStoreKey;

  /// Key for the "select pickup store" string.
  String get selectPickupStoreKey;

  /// Key for the "select delivery address" string.
  String get selectDeliveryAddressKey;

  /// Key for the "loyalty points" string.
  String get loyaltyPointsKey;

  /// Key for the "shop by category" string.
  String get shopByCategoryKey;

  /// Key for the "view all" string.
  String get viewAllKey;

  /// Key for the "navigation home" string.
  String get navHomeKey;

  /// Key for the "navigation categories" string.
  String get navCategoriesKey;

  /// Key for the "navigation notifications" string.
  String get navNotificationsKey;

  /// Key for the "navigation wishlist" string.
  String get navWishlistKey;

  /// Key for the "navigation account" string.
  String get navAccountKey;

  /// Key for the "hot deals" string.
  String get hotDealsKey;

  /// Key for the "shop by brands" string.
  String get shopByBrandsKey;

  /// Key for the "you may also like" string.
  String get youMayAlsoLikeKey;

  /// Key for the "login" string.
  String get loginKey;

    /// Key for the "labelMobileOrMail" string.
    /// Label Mobile or Mail
  String get labelMobileOrMailKey;

   /// Key for the "enterPassword" string.
   /// Enter Password
  String get pleaseEnterThePasswordKey;

   /// Key for the "enterNewPassword" string.
   /// Enter New Password
  String get pleaseEnterNewPasswordKey;

   /// Key for the "enterConPassword" string.
   /// Enter Confirm Password
  String get pleaseEnterConfirmPasswordKey;

    /// Key for the "passwordLengthError" string.
    /// Password Length Error
  String get passwordLengthErrorKey;

  ///  Missing Uppercase
  String get missingUppercaseKey;

  /// Missing Lowercase
  String get missingLowercaseKey;

  /// Missing Number
  String get missingNumberKey;

  /// Missing Special Char
  String get missingSpecialCharKey;

  /// Pass All Criteria
  String get passAllCriteriaKey;

  /// Enter Mobile Or Number
  String get pleaseEnterMobileOrNumberKey;

  /// Please Enter The Email
  String get pleaseEnterTheEmailKey;

  /// Please Enter Valid Email
  String get pleaseEnterValidEmailKey;

  /// Show Key
  String get showKey;

  /// Hide Key
  String get hideKey;

  /// Key for the "continue as guest" string.
  String get continueGuestKey;

  /// Key for the "don't have account" string.
  String get dontHaveAccountKey;

  /// Key for the "forgot password" string.
  String get forgotPasswordKey;

  /// Key for the "password" string.
  String get passwordKey;

  /// Key for the "new" string.
  String get newKey;

  /// Key for the "add" button string.
  String get addButtonKey;

  /// Key for the "off" string.
  String get oFFKey;

  /// Key for the "hello" string.
  String get helloKey;

  /// Key for the "loginKey" string.
  String get loginSignupKey;

  /// Key for the "continue with facebook" string.
  String get continueWithFacebookKey;

  /// Key for the "continue with google" string.
  String get continueWithGoogleKey;

  /// Key for the "continue with apple" string.
  String get continueWithAppleKey;

  /// Key for the "continue with Mobile Email" string.
  String get continueWithMobileEmailKey;

  /// Key for the "continue as guest" string.
  String get continueAsGuestKey;

  /// Key for the validation when mobile number is empty
  String get pleaseEnterMobileNumberKey;

  /// Key for the validation when only number allowed
  String get onlyNumbersAllowedKey;

  /// Key for the validation when mobile number is invalid
  String get enterValidMobileNumberKey;

  /// Key for the button get otp
  String get getOtpKey;

  /// Key for the button send
  String get sendKey;

  /// Key for the label mobile number
  ///
  /// Example: 'Mobile Number'
  String get mobileNumberKey;

  /// Key for the label email id
  ///
  /// Example: 'Email Id'
  String get emailIdKey;

  /// Key for the label mobile
  ///
  /// Example: 'Mobile'
  ///
  String get mobileKey;

  /// Key for the label email
  ///
  /// Example: 'Email'
  String get emailKey;

  /// Key for the detailed forgot password helper text.
  String get detailForgotPasswordKey;

  /// Key for the "Verify OTP" action text.
  String get verifyOTPKey;

  /// Key for the "OTP Verified Successfully" message.
  String get otpVerifiedSuccessfullyKey;

  /// Key for the "Email Verified Successfully" message.
  String get updateEmailVerifiedSuccessfullyKey;

  /// Key for the "Verify OTP" screen title.
  String get verifyOTPTitleKey;

  /// Key for the "Resend OTP in" timer text.
  String get resendOtpInKey;

  /// Key for the "Resend Code" action text.
  String get resendCodeKey;

  /// Key for the "Verify" button text.
  String get verifyKey;

  // Reset screen
  /// Key for the password length guidance (min 6, max 15).
  String get minimumSixMaxFifteenKey;

  /// Key for the rule: must include at least...
  String get mustIncludeLeastKey;

  /// Key for the rule requiring at least one number.
  String get oneNumberKey;

  /// Key for the rule requiring an uppercase letter.
  String get upperCaseLetterKey;

  /// Key for the rule requiring a lowercase letter.
  String get lowerCaseLetterKey;

  /// Key for the rule requiring a special character.
  String get specialCaseLetterKey;

  /// Key for the "Reset Password" label.
  String get resetPasswordKey;

  /// Key for the "New Password" label.
  String get newPasswordKey;

  /// Key for the "Reset" button text.
  String get resetKey;

  /// Key for the "Sign Up" title text.
  String get signUpKey;

  /// Key for the "Enter First Name" helper text.
  String get enterFirstNameKey;

  /// Key for the "Agree to Terms" title text.
  String get agreeTermTitleKey;

  /// Key for the "Please enter your confirm password" validation text.
  String get pleaseEnterYourConfirmPasswordKey;

  /// Key for the "Passwords do not match" validation text.
  String get passDoNotMatchKey;

  /// Key for the "Confirm New Password" label.
  String get confirmNewPasswordKey;

  /// Key for the "Select Nationality" label.
  String get selectNationalityKey;

  /// Key for the "Select DOB" label.
  String get selectDOBKey;

  /// Key for the "Select Gender" label.
  String get selectGenderKey;

  /// Key for the "I agree to the" text.
  String get iAgreeToTheKey;

  /// Key for the "Terms and Conditions" text.
  String get termsAndConditionsSmallKey;

  /// Key for the "You must accept terms" validation text.
  String get youMustAcceptTermsKey;

  /// Key for the "Different from previous password" validation text.
  String get differentPassFromPreviousKey;

  /// Key for "Terms and conditions required" validation text.
  String get pleaseAcceptTermsConditionsRequiredKey;

  /// Key for "Please enter a valid password" validation text.
  String get pleaseEnterValidPasswordKey;

  /// Key for "Network error occurred" error text.
  String get networkErrorOccurredKey;

  /// Key for "Something went wrong" error text.
  String get somethingWentWrongKey;

  // Sign up
  /// Key for the "Full Name" field label.
  String get fullNameKey;

  /// Key for the "Nationality" field label.
  String get nationalityOnlyKey;

  /// Key for the "Date of Birth" field label.
  String get dateOfBirthKey;

  /// Key for the "Gender" field label.
  String get genderKey;

  /// Key for the "Male" option.
  String get maleKey;

  /// Key for the "Female" option.
  String get femaleKey;

  /// Key for the "Referral Code" field label.
  String get referralCodeKey;

  /// Key for the "Forgot Password" label text.
  String get forgotPasswordLabelKey;

  // product listing
  /// Key for the "Filter" action.
  String get filterKey;

  /// Key for the "Sort" action.
  String get sortKey;

  /// Key for the "Sort By" label.
  String get sortByKey;

  /// Key for the "Cancel" action.
  String get cancelKey;

  /// Key for the "Clear All" action.
  String get clearAllKey;

  /// Key for the "Clear" action.
  String get clearKey;

  /// Key for the "Brand" filter category.
  String get brandFilterKey;

  /// Key for the "Category" filter category.
  String get categoryFilterKey;

  /// Key for the "Price" filter category.
  String get priceFilterKey;

  /// Key for "day" (singular) for time ago calculations.
  String get dayKey;

  /// Key for "days" (plural) for time ago calculations.
  String get daysKey;

  /// Key for "hour" (singular) for time ago calculations.
  String get hourKey;

  /// Key for "hours" (plural) for time ago calculations.
  String get hoursKey;

  /// Key for "min" (singular) for time ago calculations.
  String get minKey;

  /// Key for "mins" (plural) for time ago calculations.
  String get minsKey;

  /// Key for "Just now" for time ago calculations.
  String get justNowKey;

  /// Key for "ago" for time ago calculations.
  String get agoKey;

// product search
  /// Key for the product search placeholder.
  String get searchProductKey;

  /// Key for the "Pay using" label.
  String get payUsingKey;

  /// Key for a dummy product name placeholder.
  String get dummyProductNameKey;

  /// Key for the "Select Unit" label.
  String get selectUnitKey;

  /// Key for the "Description" section title.
  String get descriptionKey;

  /// Key for a dummy description placeholder.
  String get dummyDescriptionKey;

  /// Key for the "Nutritions" section title.
  String get nutritionsKey;

  /// Key for the "Key Features" section title.
  String get keyFeaturesKey;

  /// Key for the "Related Products" section title.
  String get relatedProductsKey;

  /// Key for the "Accessories Products" section title.
  String get accessoriesProductsKey;

  /// Key for the "Review & Rating" section title.
  String get reviewRatingKey;

  /// Key for the "Anonymous User" text.
  String get anonymousUserKey;

  /// Key for the time indicator such as "mins ago".
  String get minsAgoKey;

  /// Key for a dummy rating title placeholder.
  String get dummyRatingTitleKey;

  /// Key for a dummy rating description placeholder.
  String get dummyRatingDescKey;

  /// Key for the "Reviews" section title.
  String get reviewsKey;

  /// Key for the "Please select a rating" validation message.
  String get pleaseSelectRatingKey;

  /// Key for the "Please enter review details" validation message.
  String get pleaseEnterReviewDetailsKey;

  /// Key for the "Product not found" error message.
  String get productNotFoundKey;

  /// Key for the "Product rated successfully" success message.
  String get productRatedSuccessfullyKey;

  /// Key for the "Failed to rate product" error message.
  String get failedToRateProductKey;

  /// Key for the "Add" button.
  String get addKey;

  /// Key for the order success message with points earned.
  String get yourOrderSuccesfullyPlacedAndYouEarnedKey;

  /// Key for the "Paid Amount" label.
  String get paidAmountKey;

  /// Key for the "Date and Time" label.
  String get dateAndTimeKey;

  /// Key for the "Transaction ID" label.
  String get transactionIdKey;

  /// Key for the "Order No" label.
  String get orderNoKey;

  /// Key for the "Okay" button.
  String get okayKey;

  /// Key for the "Use My Current Location" action.
  String get userMyCurrentLocationKey;

  /// Key for the "My Address" section title.
  String get myAddressKey;

  /// Key for the "Add New" action.
  String get addNewKey;

  /// Key for the "Add New Address" action.
  String get addNewAddressKey;

  /// Key for the "Search for area/street name" placeholder.
  String get searchForAreaStreetNameKey;

  /// Snackbar/message: No search result found
  String get noSearchResultFoundKey;

  /// Key for the "House/Flat/Floor No" label.
  String get houseAndflatAndFloorNoKey;

  /// Key for the "Apartment/Road/Area" label.
  String get apartmentAndRoadAndAreaKey;

  /// Key for the "Mobile No (optional)" label.
  String get mobileNoOptionalKey;

  /// Key for the "Work" tag.
  String get workKey;

  /// Key for the "Other" tag.
  String get otherKey;

  /// Key for the "Save As" label.
  String get saveAsKey;

  /// Key for the "Save As" label.
  String get saveKey;

  /// Key for the "Select New Address" title.
  String get selectNewAddressKey;

  /// Key for the "Thank You" title.
  String get thankYouKey;

  /// Key for the "Out of Stock" label.
  String get outOfStockKey;

  /// Key for the "Buy It Again" action.
  String get buyItAgainKey;

  /// Key for the "Select Delivery Location" title.
  String get selectDeliveryLocationKey;

  /// Key for the "Confirm Location" action.
  String get confirmLocationKey;

  /// Key for the "Save Address" action.
  String get saveAddressKey;

  /// Key for the "Saved Address" label.
  String get savedAddressKey;

  /// Key for the validation: please enter house/flat/floor no.
  String get pleaseEnterhouseAndFlatAndFloorNoKey;

  /// Key for the validation: please enter apartment/road/area.
  String get pleaseEnterApartmentAndRoadAndAreaKey;

  /// Key for the instruction: move to map to set location.
  String get moveToMapToSetLocationKey;

  /// Key for the "Enable location to view nearest stores" message.
  String get enableLocationToViewNearestStoresKey;

  /// Key for the "Enable Location" action.
  String get enableLocationKey;

  /// Key for the title: select available store.
  String get selectAvaliableStoreKey;

  /// Key for the "Start Shopping" action.
  String get startShoppingKey;

  /// Key for the "Map" label.
  String get mapKey;

  /// Key for the "Call" action.
  String get callKey;

  /// Key for the "Share" action.
  String get shareKey;

  /// Key for the logout confirmation message.
  String get logoutConformationKey;


  /// Key for the delete account confirmation message.
  String get deleteAccountConformationKey;

  /// Key for the "Yes" confirmation action.
  String get yesKey;

  /// Key for the "Cancel Order" action label.
  String get cancelOrderKey;

  /// Key for the cancel order confirmation message.
  String get cancelOrderConformationKey;

  /// Key for the "Apply" action label.
  String get applyKey;

  /// Key for the "Forgot Password" screen title.
  String get forgotPasswordTitleKey;

  /// Key for the "Delete" action label.
  String get deleteKey;

  /// Key for the "Delete Address" action label.
  String get deleteAddressKey;

  /// Key for the delete address confirmation message.
  String get deleteAddressMessageKey;

  /// Key for the "No" confirmation action.
  String get noKey;

  /// Key for the "Enter Coupon/Gift Card Code" placeholder.
  String get enterCouponGiftCardCodeKey;

  /// Key for the "Credit/Debit Card" payment option.
  String get creditDebitCardKey;

  /// Key for the "Wallet" payment option.
  String get walletKey;

  /// Key for the "Checkout" title.
  String get checkoutKey;

  /// Key for the "Nationality" selection title.
  String get nationalityKey;

  /// Key for the "Done" action.
  String get doneKey;

  /// Key for the "Total" label.
  String get totalKey;

  /// Key for the "Success" status.
  String get successKey;

  /// Key for the OTP success message.
  String get otpSuccessMsgKey;

  /// Key for the generic account message text.
  String get accountMsgKey;

  /// Key for the Kuwait country code label.
  String get kuwaitCountryCodeKey;

  /// Key for the minimum value in KD label.
  String get minInKDKey;

  /// Key for the maximum value in KD label.
  String get maxInKDKey;

  /// Key for the "Cash on Delivery" payment option.
  String get cashonDeliveryKey;

  /// Key for the "Available Balance" label.
  String get availableBalanceKey;

  /// Key for the "Discount on Order Total" label.
  String get discountOnOrderTotalKey;

  /// Key for the redeem points message.
  String get redeemPointsMessageKey;

  /// Key for the "Change" action.
  String get changeKey;

  /// Key for the "From" label.
  String get fromKey;

  /// Key for the "Store Name" label.
  String get storeNameKey;

  /// Key for the "Delivery To" label.
  String get deliveryToKey;

  /// Key for the "No Store Available" message.
  String get noStoreAvailableKey;

  /// Key for the "No Store Found" message.
  String get noStoreFoundKey;

  /// Key for the "No stores available in your area." message.
  String get noStoresAvailableInYourAreaKey;

  /// Key for the "Km" distance unit.
  String get kmKey;

  /// Key for the "Select Pickup Time" label.
  String get selectPickupTimeKey;

  /// Message shown when no pickup time slots are available.
  String get noTimeSlotsAvailableKey;

  /// Key for the "Enter Coupon/Gift Card" placeholder.
  String get enterCouponGiftCardKey;

  /// Key for the "Profile" title.
  String get profileKey;

  /// Key for the "Welcome to Dukkan" title.
  String get welcomeToDukkanKey;

  /// Key for the profile message subtitle.
  String get profileMsgKey;

  /// Key for the "Edit Profile" action.
  String get editProfileKey;

  /// Key for the "Change Password" action.
  String get changePasswordKey;

  /// Key for the "Order ID" label.
  String get orderIDKey;

  /// Key for the "No. of Items" label.
  String get noOfItemsKey;

  /// Key for the "Total Amount" label.
  String get totalAmountKey;

  /// Key for the "Track Order" action.
  String get trackOrderKey;

  /// Key for the "Cancel Order" action.
  String get cancelOrderkey;

  /// Key for the order status "Order Placed".
  String get orderPlacedKey;

  /// Key for the order status "Delivered".
  String get deliveredKey;

  /// Key for the order status "Cancelled".
  String get cancelledKey;

  /// Key for the order status "Collected".
  String get collectedKey;

  /// Key for the "Wishlist" title.
  String get wishlistKey;

  /// Key for the empty wishlist message.
  String get emptyWishlistKey;

  /// Key for the empty wishlist description.
  String get emptyWishlistDescKey;

  /// Key for the no store receipt available message.
  String get noStoreReceiptAvailableKey;

  /// Key for the no store receipt description message.
  String get noStoreReceiptDescKey;

  /// Key for the "Select Amount" label.
  String get selectAmountKey;

  /// Key for the "Gift Cards" title.
  String get giftCardsKey;

  /// Key for the "Choose Recipient" title.
  String get chooseRecipientKey;

  /// Key for the "Recipient Full Name" field label.
  String get recipientFullNameKey;

  /// Key for the "Recipient Email ID" field label.
  String get recipientEmailIdKey;

  /// Key for the "Custom Amount" field label.
  String get customAmountKey;

  /// Key for the "Update" action.
  String get updateKey;

  /// Key for the "My Orders" title.
  String get myOrdersKey;

  /// Key for the "Past" tab.
  String get pastKey;

  /// Key for the "Reorder" action.
  String get reorderKey;

  /// Key for the "Invite a Friend" title.
  String get inviteFriendKey;

  /// Key for the invite friend description.
  String get inviteFriendDescKey;

  /// Key for the "Terms & Condition" link/label.
  String get termsAndConditionKey;

  /// Key for the referral code description.
  String get refCodeDescKey;

  /// Key for the "Your Referral Code" label.
  String get yourReferralCodeKey;

  /// Key for the "Please enter comment" validation.
  String get pleaseEnterCommentKey;

  /// Key for the "Language" setting.
  String get languageKey;

  /// Key for the "Contact Us" title.
  String get contactUsKey;

  /// Key for the contact us description.
  String get contactUsDescKey;

  /// Key for the "Write Comment" label.
  String get writeCommentKey;

  /// Key for the "Store Locations" title.
  String get storeLocationsKey;

  /// Key for the "About App" title.
  String get aboutAppKey;

  /// Key for the "Terms and Conditions" link/label.
  String get termsAndConditionsKey;

  /// Key for the "Rate the App" action.
  String get rateTheAppKey;

  /// Key for the "My Wallet" title.
  String get myWalletKey;

  /// Key for the "Notifications Settings" title.
  String get notificationsSettingsKey;

  /// Key for the "My Addresses" title.
  String get myAddressesKey;

  /// Key for the "My Reviews & Ratings" title.
  String get myReviewsAndRatingsKey;

  /// Key for the "No reviews found" message.
  String get noReviewsFoundKey;

  /// Key for the "No reviews found" description.
  String get noReviewsFoundDescKey;

  /// Key for the "No categories available" message.
  String get noCategoriesKey;

  /// Key for the "No categories available" description.
  String get noCategoriesDescKey;

  /// Key for the "Refer a Friend" title.
  String get referAFriendKey;

  /// Key for the "FAQs" title.
  String get faqsKey;

  /// Key for the "Logout" action label.
  String get logoutKey;

  /// Key for the "Delete Account" action label.
  String get deleteAccountKey;

  /// Key for the "Select Delivery Method" dialog title.
  String get selectDeliveryMethodKey;

  /// Key for the "Please select delivery method before continuing" dialog message.
  String get pleaseSelectDeliveryMethodBeforeContinuingKey;

  /// Key for the "Your Wallet Balance" label.
  String get yourWalletBalanceKey;

  /// Key for the "Transaction History" title.
  String get transactionHistoryKey;

  /// Key for the "Refund Received" label.
  String get refundReceivedKey;

  /// Key for the "Amount Used" label.
  String get amountUsedKey;


  /// Key for the "Order Status" label.
  String get orderStatuesKey;


  /// Key for the "Promotions & Offers" label.
  String get promotionsOffersKey;

  /// Key for the "Submit" button.
  String get submitButtonKey;

  /// Key for the "Copy" action.
  String get copyKey;

  /// Key for the "Re-Order" action.
  String get reOrderKey;

  /// Key for the "List of Items" label.
  String get listOfItemsKey;

  /// Key for the cart title label.
  /// Example: 'Cart'
  String get cartKey;

  /// Key for singular item label.
  /// Example: 'Item'
  String get itemKey;

  /// Key for plural items label.
  /// Example: 'Items'
  String get itemsKey;

  /// Key for the validation: please enter the recipient full name.
  String get pleaseEnterTheFullNameKey;

  /// Key for the validation: please enter the recipient email ID.
  String get pleaseEnterTheEmailIdKey;

  /// Key for the "Rate the Product" title.
  String get rateTheProductKey;

  /// Key for a generic "Title" label.
  String get titleKey;

  /// Key for the "Write a Review" title.
  String get writeAReviewKey;

  /// Key for the store name "Dukaan Hawally".
  String get dukaanHawallyKey;

  /// Key for the points history text
  /// Example: 'Points History'
  String get pointsHistoryKey;

  /// Key for the last activities text
  /// Example: 'Last Activities'
  String get lastActivitiesKey;

  /// Key for the see all activities text
  /// Example: 'See All Activities'
  String get seeAllActivitiesKey;

  /// Key for the how it works text
  /// Example: 'How It Works'
  String get howItWorksKey;

  /// Key for the point expiry note text
  /// Example: 'Point Expiry Note'
  String get pointExpiryNoteKey;

  /// Key for the current password text
  /// Example: 'Current Password'
  String get currentPasswordKey;

  /// Key for the entered password does not match text
  /// Example: 'Entered Password Does Not Match'
  String get enteredPasswordDoesNotMatchKey;

  /// Key for the password updated successfully text
  /// Example: 'Password Updated Successfully'
  String get passwordUpdatedSuccessfullyKey;

  /// Key for the please enter the current password text
  /// Example: 'Please Enter The Current Password'
  String get pleaseEnterTheCurrentPasswordKey;


  /// Key for the new email id text
  /// Example: 'New Email Id'
  String get newEmailIdKey;

  /// Key for the edit text
  /// Example: 'Edit'
  String get editKey;

  /// Key for the please enter new email id text
  /// Example: 'Please Enter New Email Id'
  String get pleaseEnterNewEmailIdKey;

  /// Key for the total points text
  /// Example: 'Total Points'
  String get totalPointsKey;

  /// Key for the silver text
  /// Example: 'Silver'
  String get silverKey;

  /// Key for the order summary text
  /// Example: 'Order Summary'
  String get orderSummaryKey;

  /// Key for the more text
  /// Example: 'More'
  String get moreKey;

  /// Key for the no internet connection text
  /// Example: 'No Internet Connection'
  String get noInternetConnectionKey;

  /// Key for the please check your network connection text
  /// Example: 'Please Check Your Network Connection'
  String get pleaseCheckYourNetworkConnectionKey;

  /// Key for the try again text
  /// Example: 'Try Again'
  String get tryAgainKey;

   /// Key for the label pleaseEnterTheValidEmailId
  ///
  /// Example: 'pleaseEnterTheValidEmailId'
  ///
  String get pleaseEnterTheValidEmailIdKey;

  /// Key for the label openingHours
  ///
  /// Example: 'openingHours'
  ///
  String get openingHoursKey;


  /// Key for the points earned text
  /// Example: 'Points Earned'
  String get pointsEarnedKey;

  /// Key for the order detail section title: Delivery Address
  String get deliveryAddressTitleKey;

  /// Key shown when there is no address available
  String get noAddressAvailableKey;

  /// Key for the order detail section title: Payment Method
  String get paymentMethodTitleKey;

  /// Generic "Not available" label
  String get notAvailableKey;

  /// Label for zero points display
  String get zeroPointsKey;

  /// Key for order status "Out for Delivery"
  String get outForDeliveryKey;

  /// Key for order description "Your Order is Accepted"
  String get orderAcceptedDescKey;

  /// Key for order description "Your Order is Processing"
  String get orderProcessingDescKey;

  /// Key for order description "Your Order is Out for Delivery"
  String get orderOutForDeliveryDescKey;

  /// Key for order description "Your Order is Delivered"
  String get orderDeliveredDescKey;

  /// Key for order description "Your Order is Canceled"
  String get orderCanceledDescKey;

  /// Key for order description "Your order has been placed"
  String get orderPlacedDescKey;


  /// Key for order description "Your Order is Ready to Pickup"
  String get orderReadyToPickupDescKey;

  /// Key for order description "Your Order is Picked Up"
  String get orderPickedUpDescKey;

  /// Key for waiting status description
  String get waitingDescKey;

  /// Key for "No order status available" message
  String get noOrderStatusAvailableKey;

  /// Key for "Order tracking information is not available at the moment." message
  String get orderTrackingNotAvailableDescKey;

  /// Key for the points redeemed text
  /// Example: 'Points Redeemed'
  String get pointsRedeemedKey;


  /// Key for the your order has been placed message
  /// Example: 'Your order has been placed'
  String get yourOrderHasBeenPlacedKey;

  /// Key for the accepted status message
  /// Example: 'Accepted'
  String get acceptedKey;

  /// Key for the processing status message
  /// Example: 'Processing'
  String get processingKey;

  /// Key for the ready to pickup status message
  /// Example: 'Ready to Pickup'
  String get readyToPickupKey;

  /// Key for the picked up status message
  /// Example: 'Picked Up'
  String get pickedUpKey;

  /// Key for the waiting status message
  /// Example: 'Waiting'
  String get waitingKey;

  /// Key for the out of stock message
  String get outOfStockMsgKey;

  /// Key for the label codeCopyClipBoard
  ///
  /// Example: 'codeCopyClipBoard'
  String get codeCopyClipBoardKey;

  /// Key for the label issuewithQuality
  ///
  /// Example: 'issuewithQuality'
  String get issuewithQualityKey;

  /// Key for the label keyStoreReceipt
  ///
  /// Example: 'keyStoreReceipt'
  String get keyStoreReceiptKey;


  // New Add Address labels and errors (per updated spec)
  /// Key for the "Area" label (auto-fetched).
  String get areaLabelKey; // Area (auto-fetched)

  /// Key for the "Block" label (mandatory).
  String get blockLabelKey; // Block (mandatory)

  /// Key for the "Street" label (mandatory).
  String get streetLabelKey; // Street (mandatory)

  /// Key for the "Building/Villa" label (mandatory).
  String get buildingVillaLabelKey; // Building/Villa (mandatory)

  /// Key for the "Floor" label (optional).
  String get floorLabelKey; // Floor (optional)

  /// Key for the "Flat/Apartment" label (optional).
  String get flatApartmentLabelKey; // Flat/Apartment (optional)

  /// Key for the "Landmark" label (optional).
  String get landmarkLabelKey; // Landmark (optional)

  /// Key for the validation: please enter block number.
  String get pleaseEnterBlockNumberKey;

  /// Key for the validation: please enter street.
  String get pleaseEnterStreetKey;

  /// Key for the validation: please enter building/villa.
  String get pleaseEnterBuildingVillaKey;

  /// Key for the validation: please enter area.
  String get pleaseEnterAreaKey;

  /// Key for the allowed street characters validation message.
  /// You can only use letters, numbers, hyphens (-), underscores (_), and apostrophes (').
  String get onlyAllowedStreetCharsKey; // You can only use letters, numbers, hyphens (-), underscores (_), and apostrophes (')

  /// Key for the label StoreReceipt
  /// Example: 'storeReceiptKey'
  String get storeReceiptKey;

  /// Key for the label freeKey
  /// Example: 'freeKey'
  String get freeKey;

  /// Key for the label keyBuy1Get1
  /// Example: 'buy1Get1Key'
  String get buy1Get1Key;

  /// Key for the label rateOrderKey
  ///Example: 'rateOrderKey'
  String get rateOrderKey;

  /// Key for the label walletAppliedKey
  ///Example: 'walletAppliedKey'
  String get walletAppliedKey;

  /// Key for the label couponDiscountAppliedKey
  ///Example: 'couponDiscountAppliedKey'
  String get couponDiscountAppliedKey;

  /// Key for the label orderRatingsKey
  ///Example: 'orderRatingsKey'
  String get orderRatingsKey;

  /// Key for the "Permission Required" dialog title.
  String get permissionRequiredKey;

  /// Key for the "Open Settings" button text.
  String get openSettingsKey;

  /// Key for the permission settings dialog message.
  String get permissionSettingsMessageKey;

  /// Key for the trendingProductsKey message.
  String get trendingProductsKey;

  /// Key for the "No Address Found" message.
  String get noAddressFoundKey;

  /// Key for the no address found description.
  String get noAddressFoundDescKey;


  /// Key for the empty wishlist message.
  String get emptyNotificationListKey;

  /// Key for the empty wishlist description.
  String get emptyNotificationListDescKey;

  /// Key for the "No orders found" message.
  String get noOrdersFoundKey;

  /// Key for the no orders found description.
  String get noOrdersFoundDescKey;

  /// Key for the "Please select a store before continuing" validation message.
  String get pleaseSelectStoreBeforeContinuingKey;

  /// Key for the Subtotal label in order summary.
  String get subtotalKey;

  /// Key for the "Enable Notification" button text.
  String get enableNotificationKey;

  /// Key for the notification permission message.
  String get enableNotificationToReceiveUpdatesKey;

  /// Key for the "Delivery Charge" label in order summary.
  String get deliveryChargeKey;

  /// Key for the "Loyalty Points Applied" label in order summary.
  String get loyaltyPointsAppliedKey;

  /// Key for the "Coupon Discount" label in order summary.
  String get couponDiscountKey;

  /// Key for the "You saved" message in order summary.
  String get youSavedKey;


  /// Key for selectPay.
  String get selectPay;

  /// Key for englishKey.
  String get englishKey;

  /// Key for the "All" string.
  String get allKey;

  /// Key for inviteKey.
  String get inviteKey;

  /// Key for inviteKey
  String get referalKey;
  
  /// Key for the "Select Reward" title.
  String get selectRewardKey;

  /// Key for the generic "Reward" label used with an id.
  String get rewardKey;

  /// Title for free gift added dialog
  String get yayFreeGiftAddedKey;

  /// Subtitle for free gift added dialog
  String get freeGiftAddedSubtitleKey;

  /// Generic Thanks label
  String get thanksKey;

  /// Hurray label
  String get hurrayKey;

  /// DeliveryInstruction label
  String get deliveryInstructionKey;

  ///Add DeliveryInstruction label
  String get addDeliveryInstructionKey;

  ///Add DeliveryInstruction label
  String get writeDeliveryInstructionKey;
}
