import '../../../utils/exports.dart';

/// Application string resources for localization (only keys in use).
abstract class AppString {
  static AppString of(BuildContext context) {
    return Localizations.of<AppString>(context, AppString)!;
  }

  String get allKey;
  String get cancelKey;
  String get clearAllKey;
  String get hideKey;
  String get kuwaitCountryCodeKey;
  String get mobileNumberKey;
  String get navAccountKey;
  String get navCategoriesKey;
  String get navHomeKey;
  String get navNotificationsKey;
  String get navWishlistKey;
  String get noInternetConnectionKey;
  String get okayKey;
  String get otherKey;
  String get pleaseCheckYourNetworkConnectionKey;
  String get searchProductKey;
  String get showKey;
  String get tryAgainKey;
  String get workKey;

  // Login & Social Login Keys
  String get loginSignupKey;
  String get continueWithGoogleKey;
  String get continueWithMobileEmailKey;
  String get loginKey;
  String get labelMobileOrMailKey;
  String get passwordKey;
  String get pleaseEnterMobileOrNumberKey;
  String get pleaseEnterThePasswordKey;
  String get pleaseEnterMobileNumberKey;
  String get onlyNumbersAllowedKey;
  String get enterValidMobileNumberKey;
  String get pleaseEnterTheEmailKey;
  String get pleaseEnterValidEmailKey;
  String get passAllCriteriaKey;
  String get dontHaveAccountKey;
  String get forgotPasswordKey;
  String get welcomeBackKey;
  String get byContinuingAgreeKey;
  String get termsOfServiceKey;
  String get andKey;
  String get privacyPolicyKey;
  String get memberLoginKey;
  String get continueJourneySecurelyKey;
  String get emailOrUsernameKey;
  String get pleaseEnterEmailOrUsernameKey;

  // Forgot Password
  String get resetPasswordTitleKey;
  String get enterEmailToReceiveResetLinkKey;
  String get enterYourEmailKey;
  String get sendResetLinkKey;
  String get backToLoginKey;
  String get resetLinkSentSuccessKey;
  String get forgotPasswordFailedKey;

  // Sign Up
  String get signUpTitleKey;
  String get signUpBasicInfoKey;
  String get signUpVerificationKey;
  String get signUpCompleteProfileKey;
  String get signUpBasicInfoSubtitleKey;
  String get signUpVerificationSubtitleKey;
  String get signUpCompleteProfileSubtitleKey;
  String get signUpNextKey;
  String get signUpPreviousKey;
  String get signUpFinishKey;
  String get signUpCreateClientAccountKey;
  String get signUpBasicInfoDetailsKey;
  String get signUpFullNameKey;
  String get signUpEnterFullNameKey;
  String get signUpEmailAddressKey;
  String get signUpEnterEmailAddressKey;
  String get signUpPleaseEnterFullNameKey;
  String get signUpPleaseEnterValidFullNameKey;
  String get signUpSendOtpKey;
  String get signUpEnterEmailToReceiveOtpKey;
  String get signUpEnterPhoneToReceiveOtpKey;
  String get signUpOtpSentEmailKey;
  String get signUpOtpSentPhoneKey;
  String get signUpVerificationCompleteKey;
  String get signUpEmailVerificationKey;
  String get signUpPhoneVerificationKey;
  String get signUpEmailOtpSentToKey;
  String get signUpPhoneOtpSentToKey;
  String get signUpEnterOtpKey;
  String get signUpVerifyEmailOtpKey;
  String get signUpVerifyPhoneOtpKey;
  String get signUpResendOtpKey;
  String get signUpDidntReceiveOtpKey;
  String signUpResendOtpCountdown(int seconds);
  String get signUpVerifiedKey;
  String get signUpCompleteYourProfileKey;
  String get signUpSetupWekoAccountKey;
  String get signUpUsernameKey;
  String get signUpChooseUsernameKey;
  String get signUpCreateStrongPasswordKey;
  String get signUpConfirmPasswordKey;
  String get signUpConfirmPasswordHintKey;
  String get signUpPleaseEnterUsernameKey;
  String get signUpPleaseEnterValidUsernameKey;
  String get signUpPleaseConfirmPasswordKey;
  String get signUpPasswordsDoNotMatchKey;
  String get signUpPleaseEnterOtpKey;
  String get signUpPleaseEnterValidOtpKey;
  String get signUpVerifyEmailFirstKey;
  String get signUpVerifyPhoneFirstKey;
  String get signUpEmailVerifiedSuccessKey;
  String get signUpPhoneVerifiedSuccessKey;
  String get signUpOtpResentEmailKey;
  String get signUpOtpResentPhoneKey;
  String get signUpRegistrationCompleteKey;

  String get signUpSelectCountryKey;
  String get signUpSearchCountryKey;
  String get signUpNoCountryFoundKey;

  // Verification Pending (post-login)
  String get verificationPendingTitleKey;
  String get verificationPendingSubtitleKey;
  String get verificationPendingDescriptionKey;
  String get verificationPendingCurrentStatusKey;
  String get verificationPendingUnderReviewKey;
  String get verificationPendingNotifyKey;
  String get verificationPendingThankYouKey;
  String get verificationPendingNeedAssistanceKey;
  String get verificationPendingContactSupportKey;
  String get verificationPendingSupportEmailSubjectKey;
}
