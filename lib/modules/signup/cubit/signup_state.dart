import '../../../utils/exports.dart';

/// Total steps in the sign up flow for social profile.
const int signUpSocialTotalSteps = 3;

/// Total steps in the sign up flow for trader profile.
const int signUpTraderTotalSteps = 4;

/// OTP length for sign up verification.
const int signUpOtpLength = Dimens.otpLength;

/// Cooldown before OTP can be resent again.
const int signUpOtpResendCooldownSeconds = Dimens.timeDuration30;

/// State for the sign up screen.
class SignUpState extends BaseState {
  /// Creates [SignUpState].
  const SignUpState({
    required super.status,
    required this.formKey,
    required this.fullNameController,
    required this.emailController,
    required this.phoneController,
    required this.usernameController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.fullNameFocusNode,
    required this.emailFocusNode,
    required this.phoneFocusNode,
    required this.usernameFocusNode,
    required this.passwordFocusNode,
    required this.confirmPasswordFocusNode,
    // Trader & Social new fields
    required this.previousFirmController,
    required this.primaryInstrumentsController,
    required this.preferredCurrencyPairsController,
    required this.averageTradesPerDayController,
    required this.preferredTimeframesController,
    required this.preferredSessionsController,
    required this.strategyDescriptionController,
    required this.primaryEdgeController,
    required this.indicatorsToolsController,
    required this.averageRiskPerTradeController,
    required this.riskRewardRatioController,
    required this.maxDailyDrawdownController,
    required this.maxOverallDrawdownController,
    required this.useStopLossesController,
    required this.averageMonthlyReturnController,
    required this.averageWinRateController,
    required this.largestWinningMonthController,
    required this.largestLosingMonthController,
    required this.currentAccountSizeController,
    required this.largestAccountManagedController,
    required this.propFirmsWorkedController,
    required this.accountSizesPassedController,
    required this.handlingLosingStreaksController,
    required this.biggestWeaknessController,
    required this.biggestStrengthController,
    required this.tradingPlatformController,
    required this.brokersUsedController,
    required this.performanceTrackingLinksController,
    required this.additionalNotesController,
    required this.instagramHandleController,
    required this.twitterHandleController,
    required this.traderSignatureController,
    this.accountType = UserRole.client, // client or trader
    this.tradingExperience = '',
    this.professionallyTraded = false,
    this.marketsTraded = const <String>[],
    this.tradingStyle = '',
    this.fundedAccountExperience = false,
    this.passedFundedChallenge = false,
    this.maintainTradingJournal = false,
    this.internetBackup = false,
    this.useVps = false,
    this.governmentIdSubmitted = false,
    this.tradingStatementSubmitted = false,
    this.myfxbookVerified = false,
    this.fxblueVerified = false,
    this.brokerStatementAttached = false,
    this.governmentIdPath,
    this.bankStatementPath,
    this.tradingCertificatePath,
    this.declarationConfirmed = false,
    this.currentStep = 0,
    this.totalSteps = signUpSocialTotalSteps,
    this.countryDialCode = '+91',
    this.countryIsoCode = 'IN',
    this.fullNameErrorMessage = '',
    this.emailErrorMessage = '',
    this.phoneErrorMessage = '',
    this.emailOtpErrorMessage = '',
    this.phoneOtpErrorMessage = '',
    this.usernameErrorMessage = '',
    this.passwordErrorMessage = '',
    this.confirmPasswordErrorMessage = '',
    this.passwordObscureText = true,
    this.confirmPasswordObscureText = true,
    this.isEmailVerified = false,
    this.isPhoneVerified = false,
    this.showEmailOtpField = false,
    this.showPhoneOtpField = false,
    this.emailOtp = '',
    this.phoneOtp = '',
    this.emailResendSecondsRemaining = 0,
    this.phoneResendSecondsRemaining = 0,
    super.msg = '',
    super.redirectRoute,
  });

  /// Active step index.
  final int currentStep;

  /// Total number of sign up steps.
  final int totalSteps;

  /// Root form key.
  final GlobalKey<FormState> formKey;

  /// Basic info — full name.
  final TextEditingController fullNameController;

  /// Basic info / verification — email.
  final TextEditingController emailController;

  /// Verification — phone (without dial code).
  final TextEditingController phoneController;

  /// Profile — username.
  final TextEditingController usernameController;

  /// Profile — password.
  final TextEditingController passwordController;

  /// Profile — confirm password.
  final TextEditingController confirmPasswordController;

  /// Focus nodes.
  final FocusNode fullNameFocusNode;
  final FocusNode emailFocusNode;
  final FocusNode phoneFocusNode;
  final FocusNode usernameFocusNode;
  final FocusNode passwordFocusNode;
  final FocusNode confirmPasswordFocusNode;

  /// Selected country dial code for phone field.
  final String countryDialCode;

  /// ISO country code for country picker e.g. `IN`.
  final String countryIsoCode;

  /// Field validation messages.
  final String fullNameErrorMessage;
  final String emailErrorMessage;
  final String phoneErrorMessage;
  final String emailOtpErrorMessage;
  final String phoneOtpErrorMessage;
  final String usernameErrorMessage;
  final String passwordErrorMessage;
  final String confirmPasswordErrorMessage;

  /// Password visibility toggles.
  final bool passwordObscureText;
  final bool confirmPasswordObscureText;

  /// Whether email / phone OTP has been verified.
  final bool isEmailVerified;
  final bool isPhoneVerified;

  /// Whether OTP pin fields are visible after send.
  final bool showEmailOtpField;
  final bool showPhoneOtpField;

  /// Current OTP pin values.
  final String emailOtp;
  final String phoneOtp;

  /// Seconds until email / phone OTP can be resent (0 = enabled).
  final int emailResendSecondsRemaining;
  final int phoneResendSecondsRemaining;

  // New fields / controllers for Trader Questionnaire & Social
  final UserRole accountType; // client or trader
  final String tradingExperience;
  final bool professionallyTraded;
  final TextEditingController previousFirmController;
  final List<String> marketsTraded;
  final TextEditingController primaryInstrumentsController;
  final TextEditingController preferredCurrencyPairsController;
  final String tradingStyle;
  final TextEditingController averageTradesPerDayController;
  final TextEditingController preferredTimeframesController;
  final TextEditingController preferredSessionsController;
  final TextEditingController strategyDescriptionController;
  final TextEditingController primaryEdgeController;
  final TextEditingController indicatorsToolsController;
  final TextEditingController averageRiskPerTradeController;
  final TextEditingController riskRewardRatioController;
  final TextEditingController maxDailyDrawdownController;
  final TextEditingController maxOverallDrawdownController;
  final TextEditingController useStopLossesController;
  final TextEditingController averageMonthlyReturnController;
  final TextEditingController averageWinRateController;
  final TextEditingController largestWinningMonthController;
  final TextEditingController largestLosingMonthController;
  final TextEditingController currentAccountSizeController;
  final TextEditingController largestAccountManagedController;
  final bool fundedAccountExperience;
  final TextEditingController propFirmsWorkedController;
  final bool passedFundedChallenge;
  final TextEditingController accountSizesPassedController;
  final TextEditingController handlingLosingStreaksController;
  final TextEditingController biggestWeaknessController;
  final TextEditingController biggestStrengthController;
  final bool maintainTradingJournal;
  final TextEditingController tradingPlatformController;
  final TextEditingController brokersUsedController;
  final bool internetBackup;
  final bool useVps;
  final bool governmentIdSubmitted;
  final bool tradingStatementSubmitted;
  final bool myfxbookVerified;
  final bool fxblueVerified;
  final bool brokerStatementAttached;
  final TextEditingController performanceTrackingLinksController;
  final TextEditingController additionalNotesController;
  final TextEditingController instagramHandleController;
  final TextEditingController twitterHandleController;
  final String? governmentIdPath;
  final String? bankStatementPath;
  final String? tradingCertificatePath;
  final TextEditingController traderSignatureController;
  final bool declarationConfirmed;

  /// Whether email OTP resend is available.
  bool get canResendEmailOtp => emailResendSecondsRemaining <= 0;

  /// Whether phone OTP resend is available.
  bool get canResendPhoneOtp => phoneResendSecondsRemaining <= 0;

  /// Trimmed email.
  String get email => emailController.text.trim();

  /// Trimmed full name.
  String get fullName => fullNameController.text.trim();

  /// Full phone with dial code.
  String get fullPhoneNumber => phoneController.text.trim();

  @override
  List<Object?> get props => <Object?>[
        currentStep,
        totalSteps,
        countryDialCode,
        countryIsoCode,
        fullNameErrorMessage,
        emailErrorMessage,
        phoneErrorMessage,
        emailOtpErrorMessage,
        phoneOtpErrorMessage,
        usernameErrorMessage,
        passwordErrorMessage,
        confirmPasswordErrorMessage,
        passwordObscureText,
        confirmPasswordObscureText,
        isEmailVerified,
        isPhoneVerified,
        showEmailOtpField,
        showPhoneOtpField,
        emailOtp,
        phoneOtp,
        emailResendSecondsRemaining,
        phoneResendSecondsRemaining,
        accountType,
        tradingExperience,
        professionallyTraded,
        marketsTraded,
        tradingStyle,
        fundedAccountExperience,
        passedFundedChallenge,
        maintainTradingJournal,
        internetBackup,
        useVps,
        governmentIdSubmitted,
        tradingStatementSubmitted,
        myfxbookVerified,
        fxblueVerified,
        brokerStatementAttached,
        governmentIdPath,
        bankStatementPath,
        tradingCertificatePath,
        declarationConfirmed,
        ...super.props,
      ];

  /// Returns a copy with updated fields.
  SignUpState copyWith({
    BaseStateStatus? status,
    String? msg,
    PageRouteInfo? redirectRoute,
    int? currentStep,
    int? totalSteps,
    String? countryDialCode,
    String? countryIsoCode,
    String? fullNameErrorMessage,
    String? emailErrorMessage,
    String? phoneErrorMessage,
    String? emailOtpErrorMessage,
    String? phoneOtpErrorMessage,
    String? usernameErrorMessage,
    String? passwordErrorMessage,
    String? confirmPasswordErrorMessage,
    bool? passwordObscureText,
    bool? confirmPasswordObscureText,
    bool? isEmailVerified,
    bool? isPhoneVerified,
    bool? showEmailOtpField,
    bool? showPhoneOtpField,
    String? emailOtp,
    String? phoneOtp,
    int? emailResendSecondsRemaining,
    int? phoneResendSecondsRemaining,
    UserRole? accountType,
    String? tradingExperience,
    bool? professionallyTraded,
    List<String>? marketsTraded,
    String? tradingStyle,
    bool? fundedAccountExperience,
    bool? passedFundedChallenge,
    bool? maintainTradingJournal,
    bool? internetBackup,
    bool? useVps,
    bool? governmentIdSubmitted,
    bool? tradingStatementSubmitted,
    bool? myfxbookVerified,
    bool? fxblueVerified,
    bool? brokerStatementAttached,
    String? governmentIdPath,
    String? bankStatementPath,
    String? tradingCertificatePath,
    bool? declarationConfirmed,
  }) {
    return SignUpState(
      status: status ?? this.status,
      formKey: formKey,
      fullNameController: fullNameController,
      emailController: emailController,
      phoneController: phoneController,
      usernameController: usernameController,
      passwordController: passwordController,
      confirmPasswordController: confirmPasswordController,
      fullNameFocusNode: fullNameFocusNode,
      emailFocusNode: emailFocusNode,
      phoneFocusNode: phoneFocusNode,
      usernameFocusNode: usernameFocusNode,
      passwordFocusNode: passwordFocusNode,
      confirmPasswordFocusNode: confirmPasswordFocusNode,
      previousFirmController: previousFirmController,
      primaryInstrumentsController: primaryInstrumentsController,
      preferredCurrencyPairsController: preferredCurrencyPairsController,
      averageTradesPerDayController: averageTradesPerDayController,
      preferredTimeframesController: preferredTimeframesController,
      preferredSessionsController: preferredSessionsController,
      strategyDescriptionController: strategyDescriptionController,
      primaryEdgeController: primaryEdgeController,
      indicatorsToolsController: indicatorsToolsController,
      averageRiskPerTradeController: averageRiskPerTradeController,
      riskRewardRatioController: riskRewardRatioController,
      maxDailyDrawdownController: maxDailyDrawdownController,
      maxOverallDrawdownController: maxOverallDrawdownController,
      useStopLossesController: useStopLossesController,
      averageMonthlyReturnController: averageMonthlyReturnController,
      averageWinRateController: averageWinRateController,
      largestWinningMonthController: largestWinningMonthController,
      largestLosingMonthController: largestLosingMonthController,
      currentAccountSizeController: currentAccountSizeController,
      largestAccountManagedController: largestAccountManagedController,
      propFirmsWorkedController: propFirmsWorkedController,
      accountSizesPassedController: accountSizesPassedController,
      handlingLosingStreaksController: handlingLosingStreaksController,
      biggestWeaknessController: biggestWeaknessController,
      biggestStrengthController: biggestStrengthController,
      tradingPlatformController: tradingPlatformController,
      brokersUsedController: brokersUsedController,
      performanceTrackingLinksController: performanceTrackingLinksController,
      additionalNotesController: additionalNotesController,
      instagramHandleController: instagramHandleController,
      twitterHandleController: twitterHandleController,
      traderSignatureController: traderSignatureController,
      accountType: accountType ?? this.accountType,
      tradingExperience: tradingExperience ?? this.tradingExperience,
      professionallyTraded: professionallyTraded ?? this.professionallyTraded,
      marketsTraded: marketsTraded ?? this.marketsTraded,
      tradingStyle: tradingStyle ?? this.tradingStyle,
      fundedAccountExperience: fundedAccountExperience ?? this.fundedAccountExperience,
      passedFundedChallenge: passedFundedChallenge ?? this.passedFundedChallenge,
      maintainTradingJournal: maintainTradingJournal ?? this.maintainTradingJournal,
      internetBackup: internetBackup ?? this.internetBackup,
      useVps: useVps ?? this.useVps,
      governmentIdSubmitted: governmentIdSubmitted ?? this.governmentIdSubmitted,
      tradingStatementSubmitted: tradingStatementSubmitted ?? this.tradingStatementSubmitted,
      myfxbookVerified: myfxbookVerified ?? this.myfxbookVerified,
      fxblueVerified: fxblueVerified ?? this.fxblueVerified,
      brokerStatementAttached: brokerStatementAttached ?? this.brokerStatementAttached,
      governmentIdPath: governmentIdPath ?? this.governmentIdPath,
      bankStatementPath: bankStatementPath ?? this.bankStatementPath,
      tradingCertificatePath: tradingCertificatePath ?? this.tradingCertificatePath,
      declarationConfirmed: declarationConfirmed ?? this.declarationConfirmed,
      currentStep: currentStep ?? this.currentStep,
      totalSteps: totalSteps ?? this.totalSteps,
      countryDialCode: countryDialCode ?? this.countryDialCode,
      countryIsoCode: countryIsoCode ?? this.countryIsoCode,
      fullNameErrorMessage: fullNameErrorMessage ?? this.fullNameErrorMessage,
      emailErrorMessage: emailErrorMessage ?? this.emailErrorMessage,
      phoneErrorMessage: phoneErrorMessage ?? this.phoneErrorMessage,
      emailOtpErrorMessage: emailOtpErrorMessage ?? this.emailOtpErrorMessage,
      phoneOtpErrorMessage: phoneOtpErrorMessage ?? this.phoneOtpErrorMessage,
      usernameErrorMessage: usernameErrorMessage ?? this.usernameErrorMessage,
      passwordErrorMessage: passwordErrorMessage ?? this.passwordErrorMessage,
      confirmPasswordErrorMessage:
          confirmPasswordErrorMessage ?? this.confirmPasswordErrorMessage,
      passwordObscureText: passwordObscureText ?? this.passwordObscureText,
      confirmPasswordObscureText:
          confirmPasswordObscureText ?? this.confirmPasswordObscureText,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,
      showEmailOtpField: showEmailOtpField ?? this.showEmailOtpField,
      showPhoneOtpField: showPhoneOtpField ?? this.showPhoneOtpField,
      emailOtp: emailOtp ?? this.emailOtp,
      phoneOtp: phoneOtp ?? this.phoneOtp,
      emailResendSecondsRemaining:
          emailResendSecondsRemaining ?? this.emailResendSecondsRemaining,
      phoneResendSecondsRemaining:
          phoneResendSecondsRemaining ?? this.phoneResendSecondsRemaining,
      msg: msg ?? this.msg,
      redirectRoute: redirectRoute ?? this.redirectRoute,
    );
  }
}
