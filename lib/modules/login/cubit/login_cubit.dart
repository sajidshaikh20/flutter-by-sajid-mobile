import '../../../utils/exports.dart';

/// Cubit that manages login state and authentication operations.
class LoginCubit extends Cubit<LoginState> {
  /// Creates a login cubit.
  ///
  /// [repository] The repository for login operations.
  /// [initialState] The initial state of the login screen.
  /// [isFromCart] Whether the login was initiated from the cart.
  LoginCubit(
      {required this.repository,
        required LoginState initialState,
        this.isFromCart = false})
      : super(initialState);

  /// The repository used for login operations.
  final LoginRepository repository;

  /// Whether the login was initiated from the cart.
  final bool? isFromCart;

  ///Store login response to local pref
  Future<void> saveLoginInfoInSharedPref(LoginUserResponse response) async {
    // Save both login data and login status
    await SharedPref.instance.setValue(PrefsKey.isLoggedInKey, true);

    // Debug: Verify login data was saved
    bool isLoggedIn = SharedPref.instance.getBool(PrefsKey.isLoggedInKey, defValue: false);
    String userProfileData = SharedPref.instance.getString(PrefsKey.userProfileKey,);
    DebugLog.instance.i('Login data saved - isLoggedIn: $isLoggedIn, hasUserData: ${userProfileData.isNotEmpty}');
  }

  /// Login API call method (Mock implementation for UI flow)
  Future<void> login({
    required String emailMobile,
    required String password,
  }) async {
    try {
      emit(state.copyWith(status: BaseStateStatus.loading));

      // Simulate network delay
      await Future<void>.delayed(const Duration(milliseconds: 800));

      // Save mock login data to shared preferences
      await SharedPref.instance.setValue(PrefsKey.isLoggedInKey, true);

      // Update user profile service with mock values
      await UserProfileService.instance().updateUserProfile(
        customerName: emailMobile.contains('@') ? emailMobile.split('@').first : 'User',
        customerEmail: emailMobile.contains('@') ? emailMobile : 'user@example.com',
        phoneNumber: emailMobile.contains('@') ? '+965 1234 5678' : emailMobile,
        customerToken: 'mock_login_token_12345',
        customerId: 'mock_customer_id',
        quoteId: 'mock_quote_id',
        totalOrderValue: '0.0',
        lastOrderDate: '',
        storeCredit: '0.0',
        rewardPoints: '0',
        totalOrder: 0,
        cartCount: 0,
        referralCode: 'MOCKREF',
        gender: 'Male',
        birthday: '1995-01-01',
        nationality: 'Kuwaiti',
        prefix: '+965',
        arabicNationality: 'كويتي',
      );

      await AccountVerificationHelper.setPending();

      emit(state.copyWith(
        status: BaseStateStatus.success,
        msg: 'Successfully logged in (Mock)',
        redirectRoute: AccountVerificationHelper.resolvePostLoginRoute(),
      ));
    } on Exception {
      emit(state.copyWith(
        status: BaseStateStatus.failure,
      ));
    }
  }

  /// Guest User Login API call method (Mock implementation for UI flow)
  Future<void> callGuestUserLoginApi() async {
    try {
      emit(state.copyWith(status: BaseStateStatus.loading));

      // Simulate network delay
      await Future<void>.delayed(const Duration(milliseconds: 800));

      // Mark as logged in (guest)
      await SharedPref.instance.setValue(PrefsKey.isLoggedInKey, false);

      // Update user profile service with mock values
      await UserProfileService.instance().updateUserProfile(
        customerName: 'Guest User',
        customerEmail: 'guest@example.com',
        phoneNumber: '+965 1234 5678',
        customerToken: 'mock_guest_token_12345',
        customerId: 'mock_guest_id',
        quoteId: 'mock_quote_id',
        totalOrderValue: '0.0',
        lastOrderDate: '',
        storeCredit: '0.0',
        rewardPoints: '0',
        totalOrder: 0,
        cartCount: 0,
        referralCode: '',
        gender: '',
        birthday: '',
        nationality: '',
        prefix: '+965',
        arabicNationality: '',
      );

      emit(state.copyWith(
        status: BaseStateStatus.success,
        msg: 'Successfully logged in as Guest (Mock)',
        redirectRoute: const DashboardRoute(),
      ));
    } on Exception {
      emit(state.copyWith(status: BaseStateStatus.failure));
    }
  }

  ///Toggle password visibility
  void toggleCurrentPassObscureText() {
    emit(
      state.copyWith(
        passwordObscureText: !state.passwordObscureText,
        status: BaseStateStatus.initial,
      ),
    );
  }

  /// Changes focus to the next field.
  ///
  /// [nextFocusNode] The focus node to move focus to.
  void moveToNextField(FocusNode nextFocusNode) {
    nextFocusNode.requestFocus();
  }

  /// Updates the validation error message for the email field.
  ///
  /// [value] The error message to display.
  void handleValidationErrorMessageForEmail(String value) {
    emit(state.copyWith(emailErrorMessage: value));
  }

  /// Updates the validation error message for the password field.
  ///
  /// [value] The error message to display.
  void handleValidationErrorMessageForPassword(String value) {
    emit(state.copyWith(passwordErrorMessage: value));
  }

  /// Updates whether email authentication is being considered.
  ///
  /// [isEmail] Whether email authentication is selected.
  void updateEmailConsideration({required bool isEmail}) {
    emit(state.copyWith(
      isEmailConsidered: isEmail,
    ));
  }

  /// Updates whether phone number authentication is being considered.
  ///
  /// [isNumber] Whether phone number authentication is selected.
  void updateNumberConsideration({required bool isNumber}) {
    emit(state.copyWith(
      isNumberConsidered: isNumber,
    ));
  }
}
