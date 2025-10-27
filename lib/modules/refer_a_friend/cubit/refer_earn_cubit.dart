import '../../../utils/exports.dart';

/// Cubit that manages refer and earn functionality and state.
class ReferEarnCubit extends Cubit<ReferEarnState> {
  /// Creates a refer earn cubit.
  ReferEarnCubit({
    required this.referEarnRepositoryImpl,
    required ReferEarnState initialState,
  }) : super(initialState) {
    unawaited(_loadReferralCode());
  }


  /// The repository implementation for refer and earn operations.
  final ReferEarnRepositoryImpl referEarnRepositoryImpl;

  /// Load referral code from UserProfileService
  Future<void> _loadReferralCode() async {
    try {
      await UserProfileService.instance().ensureUserDataLoaded();
      final String referralCode = UserProfileService.instance().referralCode;
      
      if (referralCode.isNotEmpty) {
        emit(state.copyWith(referCode: referralCode));
      } else {
        // Fallback to static code if no referral code is available
       // emit(state.copyWith(referCode: AppConstant.jHKT5454));
      }
    } on Exception catch (e) {
      DebugLog.instance.e('ReferEarnCubit._loadReferralCode: Error loading referral code: $e');
      // Fallback to static code on error
     // emit(state.copyWith(referCode: AppConstant.jHKT5454));
    }
  }

  /// Refresh referral code from UserProfileService
  Future<void> refreshReferralCode() async {
    await _loadReferralCode();
  }
}
