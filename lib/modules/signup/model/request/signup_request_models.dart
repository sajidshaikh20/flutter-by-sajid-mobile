import '../../../../app/enums/enums.dart';

/// Request model for the /api/auth/start-registration API.
class StartRegistrationRequest {
  final String name;
  final String email;
  final UserRole role;

  StartRegistrationRequest({
    required this.name,
    required this.email,
    this.role = UserRole.client,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'role': role.value,
    };
  }
}

/// Request model for the /api/auth/verify-email-otp API.
class VerifyEmailOtpRequest {
  final String email;
  final String otp;

  VerifyEmailOtpRequest({required this.email, required this.otp});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'email': email,
      'otp': otp,
    };
  }
}

/// Request model for the /api/auth/send-phone-otp API.
class SendPhoneOtpRequest {
  final String email;
  final String countryCode;
  final String phone;

  SendPhoneOtpRequest({
    required this.email,
    required this.countryCode,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'email': email,
      'countryCode': countryCode,
      'phone': phone,
    };
  }
}

/// Request model for the /api/auth/verify-phone-otp API.
class VerifyPhoneOtpRequest {
  final String email;
  final String countryCode;
  final String phone;
  final String otp;

  VerifyPhoneOtpRequest({
    required this.email,
    required this.countryCode,
    required this.phone,
    required this.otp,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'email': email,
      'countryCode': countryCode,
      'phone': phone,
      'otp': otp,
    };
  }
}

/// Request model for the /api/auth/complete-registration API.
class CompleteRegistrationRequest {
  final String email;
  final String username;
  final String password;
  final String name;
  final String phone;
  final UserRole role;
  final double? experience;
  final String? bio;
  final String fcmToken;
  final String deviceType;
  final String deviceId;
  final String platform;
  final String appVersion;
  final SignUpQuestionnaireModel? questionnaire;

  CompleteRegistrationRequest({
    required this.email,
    required this.username,
    required this.password,
    required this.name,
    required this.phone,
    this.role = UserRole.client,
    this.experience,
    this.bio,
    required this.fcmToken,
    required this.deviceType,
    required this.deviceId,
    required this.platform,
    required this.appVersion,
    this.questionnaire,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{
      'email': email,
      'username': username,
      'password': password,
      'name': name,
      'phone': phone,
      'role': role.value,
      if (experience != null) 'experience': experience,
      if (bio != null) 'bio': bio,
      'fcmToken': fcmToken,
      'deviceType': deviceType,
      'deviceId': deviceId,
      'platform': platform,
      'appVersion': appVersion,
    };
    if (questionnaire != null) {
      data.addAll(questionnaire!.toJson());
    }
    return data;
  }
}

/// Model representing the detailed questionnaire filled during signup.
class SignUpQuestionnaireModel {
  final String accountType;
  final String tradingExperience;
  final bool professionallyTraded;
  final String previousFirm;
  final List<String> marketsTraded;
  final String primaryInstruments;
  final String preferredCurrencyPairs;
  final String tradingStyle;
  final String averageTradesPerDay;
  final String preferredTimeframes;
  final String preferredSessions;
  final String strategyDescription;
  final String primaryEdge;
  final String indicatorsTools;
  final String averageRiskPerTrade;
  final String riskRewardRatio;
  final String maxDailyDrawdown;
  final String maxOverallDrawdown;
  final String useStopLosses;
  final String averageMonthlyReturn;
  final String averageWinRate;
  final String largestWinningMonth;
  final String largestLosingMonth;
  final String currentAccountSize;
  final String largestAccountManaged;
  final bool fundedAccountExperience;
  final String propFirmsWorked;
  final bool passedFundedChallenge;
  final String accountSizesPassed;
  final String handlingLosingStreaks;
  final String biggestWeakness;
  final String biggestStrength;
  final bool maintainTradingJournal;
  final String tradingPlatform;
  final String brokersUsed;
  final bool internetBackup;
  final bool useVps;
  final bool governmentIdSubmitted;
  final bool tradingStatementSubmitted;
  final bool myfxbookVerified;
  final bool fxblueVerified;
  final bool brokerStatementAttached;
  final String performanceTrackingLinks;
  final String additionalNotes;
  final String instagramHandle;
  final String twitterHandle;
  final String? governmentId;
  final String? bankStatement;
  final String? tradingCertificate;
  final String traderSignature;
  final bool declarationConfirmed;

  SignUpQuestionnaireModel({
    required this.accountType,
    required this.tradingExperience,
    required this.professionallyTraded,
    required this.previousFirm,
    required this.marketsTraded,
    required this.primaryInstruments,
    required this.preferredCurrencyPairs,
    required this.tradingStyle,
    required this.averageTradesPerDay,
    required this.preferredTimeframes,
    required this.preferredSessions,
    required this.strategyDescription,
    required this.primaryEdge,
    required this.indicatorsTools,
    required this.averageRiskPerTrade,
    required this.riskRewardRatio,
    required this.maxDailyDrawdown,
    required this.maxOverallDrawdown,
    required this.useStopLosses,
    required this.averageMonthlyReturn,
    required this.averageWinRate,
    required this.largestWinningMonth,
    required this.largestLosingMonth,
    required this.currentAccountSize,
    required this.largestAccountManaged,
    required this.fundedAccountExperience,
    required this.propFirmsWorked,
    required this.passedFundedChallenge,
    required this.accountSizesPassed,
    required this.handlingLosingStreaks,
    required this.biggestWeakness,
    required this.biggestStrength,
    required this.maintainTradingJournal,
    required this.tradingPlatform,
    required this.brokersUsed,
    required this.internetBackup,
    required this.useVps,
    required this.governmentIdSubmitted,
    required this.tradingStatementSubmitted,
    required this.myfxbookVerified,
    required this.fxblueVerified,
    required this.brokerStatementAttached,
    required this.performanceTrackingLinks,
    required this.additionalNotes,
    required this.instagramHandle,
    required this.twitterHandle,
    required this.governmentId,
    required this.bankStatement,
    required this.tradingCertificate,
    required this.traderSignature,
    required this.declarationConfirmed,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'accountType': accountType,
      'tradingExperience': tradingExperience,
      'professionallyTraded': professionallyTraded,
      'previousFirm': previousFirm,
      'marketsTraded': marketsTraded,
      'primaryInstruments': primaryInstruments,
      'preferredCurrencyPairs': preferredCurrencyPairs,
      'tradingStyle': tradingStyle,
      'averageTradesPerDay': averageTradesPerDay,
      'preferredTimeframes': preferredTimeframes,
      'preferredSessions': preferredSessions,
      'strategyDescription': strategyDescription,
      'primaryEdge': primaryEdge,
      'indicatorsTools': indicatorsTools,
      'averageRiskPerTrade': averageRiskPerTrade,
      'riskRewardRatio': riskRewardRatio,
      'maxDailyDrawdown': maxDailyDrawdown,
      'maxOverallDrawdown': maxOverallDrawdown,
      'useStopLosses': useStopLosses,
      'averageMonthlyReturn': averageMonthlyReturn,
      'averageWinRate': averageWinRate,
      'largestWinningMonth': largestWinningMonth,
      'largestLosingMonth': largestLosingMonth,
      'currentAccountSize': currentAccountSize,
      'largestAccountManaged': largestAccountManaged,
      'fundedAccountExperience': fundedAccountExperience,
      'propFirmsWorked': propFirmsWorked,
      'passedFundedChallenge': passedFundedChallenge,
      'accountSizesPassed': accountSizesPassed,
      'handlingLosingStreaks': handlingLosingStreaks,
      'biggestWeakness': biggestWeakness,
      'biggestStrength': biggestStrength,
      'maintainTradingJournal': maintainTradingJournal,
      'tradingPlatform': tradingPlatform,
      'brokersUsed': brokersUsed,
      'internetBackup': internetBackup,
      'useVps': useVps,
      'governmentIdSubmitted': governmentIdSubmitted,
      'tradingStatementSubmitted': tradingStatementSubmitted,
      'myfxbookVerified': myfxbookVerified,
      'fxblueVerified': fxblueVerified,
      'brokerStatementAttached': brokerStatementAttached,
      'performanceTrackingLinks': performanceTrackingLinks,
      'additionalNotes': additionalNotes,
      'instagramHandle': instagramHandle,
      'twitterHandle': twitterHandle,
      'governmentId': governmentId,
      'bankStatement': bankStatement,
      'tradingCertificate': tradingCertificate,
      'traderSignature': traderSignature,
      'declarationConfirmed': declarationConfirmed,
    };
  }
}
