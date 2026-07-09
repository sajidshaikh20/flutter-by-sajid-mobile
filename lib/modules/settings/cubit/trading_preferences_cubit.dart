import '../../../utils/exports.dart';
import 'trading_preferences_state.dart';

class TradingPreferencesCubit extends BaseCubit<TradingPreferencesState> {
  TradingPreferencesCubit({
    required this.profileRepository,
  }) : super(TradingPreferencesState.initial()) {
    balanceController.addListener(_onBalanceChanged);
    riskController.addListener(_onRiskChanged);
  }

  final ProfileRepository profileRepository;

  final TextEditingController balanceController = TextEditingController();
  final TextEditingController riskController = TextEditingController();

  void _onBalanceChanged() {
    final double? val = double.tryParse(balanceController.text);
    if (val != null) {
      emit(state.copyWith(amountBalance: val));
    }
  }

  void _onRiskChanged() {
    final double? val = double.tryParse(riskController.text);
    if (val != null) {
      emit(state.copyWith(riskPercentage: val));
    }
  }

  Future<void> loadPreferences() async {
    emit(state.copyWith(status: BaseStateStatus.loading));
    final ResponseHandler<BaseResponse<TradingPreferencesResponse>> response =
        await profileRepository.getTradingPreferences();

    if (response.isSuccess()) {
      final TradingPreferencesResponse? prefs = response.getSuccessInstance()?.response.data;
      if (prefs != null) {
        // Temporarily remove listener to avoid feedback loop
        balanceController.removeListener(_onBalanceChanged);
        riskController.removeListener(_onRiskChanged);

        balanceController.text = prefs.amountBalance.toStringAsFixed(2);
        riskController.text = prefs.riskPercentage.toStringAsFixed(2);

        balanceController.addListener(_onBalanceChanged);
        riskController.addListener(_onRiskChanged);

        emit(state.copyWith(
          status: BaseStateStatus.success,
          amountBalance: prefs.amountBalance,
          riskPercentage: prefs.riskPercentage,
        ));
      } else {
        emit(state.copyWith(status: BaseStateStatus.success));
      }
    } else {
      // Fallback to cache
      final double? cachedBalance = UserProfileService.instance().amountBalance;
      final double? cachedRisk = UserProfileService.instance().riskPercentage;

      balanceController.removeListener(_onBalanceChanged);
      riskController.removeListener(_onRiskChanged);

      balanceController.text = (cachedBalance ?? 1000.0).toStringAsFixed(2);
      riskController.text = (cachedRisk ?? 1.0).toStringAsFixed(2);

      balanceController.addListener(_onBalanceChanged);
      riskController.addListener(_onRiskChanged);

      emit(state.copyWith(
        status: BaseStateStatus.success,
        amountBalance: cachedBalance ?? 1000.0,
        riskPercentage: cachedRisk ?? 1.0,
      ));
    }
  }

  Future<void> savePreferences() async {
    emit(state.copyWith(status: BaseStateStatus.loading, msg: 'Saving...'));

    final ResponseHandler<BaseResponse<ClientProfileResponse>> response =
        await profileRepository.updateBalanceAndRisk(
      amountBalance: state.amountBalance,
      riskPercentage: state.riskPercentage,
    );

    if (response.isSuccess()) {
      final ClientProfileResponse? profile = response.getSuccessInstance()?.response.data;
      if (profile != null) {
        await UserProfileService.instance().updateUserProfile(
          amountBalance: profile.amountBalance,
          riskPercentage: profile.riskPercentage,
          firstTimeLogin: false,
        );
      }
      emit(state.copyWith(
        status: BaseStateStatus.success,
        msg: 'Trading preferences updated.',
      ));
    } else {
      final String errorMsg = response.getFailureInstance()?.error?.errorMessage ??
          'Unable to update preferences.';
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: errorMsg,
      ));
    }
  }

  @override
  Future<void> close() {
    balanceController.dispose();
    riskController.dispose();
    return super.close();
  }

  @override
  TradingPreferencesState getResetErrorState() => state.copyWith(msg: '');

  @override
  TradingPreferencesState getResetRedirectionState() => state.copyWith();
}
