import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/exports.dart';
import '../state/signup_state.dart';
import '../repository/sign_up_repository.dart';

/// Notifier for managing signup state and operations (Riverpod version).
class SignupNotifier extends StateNotifier<SignupState> {
  /// Creates a signup notifier.
  SignupNotifier({
    required this.repository,
    required SignupState initialState,
  }) : super(initialState);

  /// Repository used to perform sign-up API calls.
  final SignUpRepository repository;

  /// Validates the signup form input and prepares the request model.
  Future<void> validateInput(
    String messageForFullName,
    String messageForMobileNumber,
    String messageForEmail,
    String messageForNationality,
    String messageForDob,
    String messageForGender,
    String messageForPassword,
    String messageForOnlyNumbersAllowed,
    String messageForEnterValidMobileNumber,
    String messageForInvalidEmail,
    String messageForInvalidPassword,
    String messageForAcceptTerms,
  ) async {
    if (state.formKey.currentState?.validate() ?? false) {
      final String fullName = state.fullNameController.text.trim();
      final String mobileNumber = state.mobileController.text.trim();
      final String email = state.emailController.text.trim();
      final String nationality = state.nationalityController.text.trim();
      final String dateOfBirth = state.dateOfBirthController.text.trim();
      final String password = state.passwordController.text.trim();
      final String? selectedGender = state.selectedGender;
      
      bool isValid = true;
      
      if (fullName.isEmpty) {
        handleValidationErrorMessageForFullName(messageForFullName);
        isValid = false;
      }

      if (mobileNumber.isEmpty) {
        handleValidationErrorMessageForMobileNumber(messageForMobileNumber);
        isValid = false;
      } else {
        final String? numberError = mobileNumber.validMobileNo(
            emptyMobileMsg : messageForMobileNumber,
            onlyNumbersAllowedMsg : messageForOnlyNumbersAllowed,
            invalidMobileMsg : messageForEnterValidMobileNumber);
        if (numberError != null && numberError.isNotEmpty) {
          handleValidationErrorMessageForMobileNumber(numberError);
          isValid = false;
        } else {
          handleValidationErrorMessageForMobileNumber("");
        }
      }

      if (email.isEmpty) {
        handleValidationErrorMessageForEmail(messageForEmail);
        isValid = false;
      } else {
        final String? emailError = email.validateEmail(
            isOnlyEmail: true,
            enterMobileOrNumberMsg : messageForInvalidEmail,
            enterEmailMsg: messageForEmail,
            validEmailMsg: messageForInvalidEmail
        );
        if (emailError != null && emailError.isNotEmpty) {
          handleValidationErrorMessageForEmail(emailError);
          isValid = false;
        } else {
          handleValidationErrorMessageForEmail("");
        }
      }

      if (nationality.isEmpty) {
        handleValidationErrorMessageForNationality(messageForNationality);
        isValid = false;
      }

      if (dateOfBirth.isEmpty) {
        handleValidationErrorMessageForDateOfBirth(messageForDob);
        isValid = false;
      }

      if (selectedGender == null || selectedGender.isEmpty) {
        handleValidationErrorMessageForGender(messageForGender);
        isValid = false;
      }

      if (password.isEmpty) {
        handleValidationErrorMessageForPassword(messageForPassword);
        isValid = false;
      } else {
        final String? passwordError = password.validatePassword(
            isNewPassword: true,
            customError: messageForInvalidPassword,
            emptyPasswordMsg: messageForPassword,
            invalidPasswordMsg: messageForInvalidPassword);
        if (passwordError != null && passwordError.isNotEmpty) {
          handleValidationErrorMessageForPassword(passwordError);
          isValid = false;
        } else {
          handleValidationErrorMessageForPassword("");
        }
      }

      if (!state.isAgreed) {
        handleValidationErrorMessageForTerms(messageForAcceptTerms);
        isValid = false;
      }

      if (isValid) {
        state = state.copyWith(status: BaseStateStatus.loading);
        // Continue with API call logic here
      }
    }
  }

  void handleValidationErrorMessageForFullName(String value) {
    state = state.copyWith(fullNameErrorMessage: value);
  }

  void handleValidationErrorMessageForMobileNumber(String value) {
    state = state.copyWith(mobileErrorMessage: value);
  }

  void handleValidationErrorMessageForEmail(String value) {
    state = state.copyWith(emailErrorMessage: value);
  }

  void handleValidationErrorMessageForNationality(String value, {bool? isMenuOpen}) {
    state = state.copyWith(
      nationalityErrorMessage: value,
      isMenuOpen: isMenuOpen ?? state.isMenuOpen,
    );
  }

  void handleValidationErrorMessageForDateOfBirth(String value) {
    state = state.copyWith(dateOfBirthErrorMessage: value);
  }

  void handleValidationErrorMessageForGender(String value) {
    state = state.copyWith(genderErrorMessage: value);
  }

  void handleValidationErrorMessageForPassword(String value) {
    state = state.copyWith(passwordErrorMessage: value);
  }

  void handleValidationErrorMessageForTerms(String value) {
    state = state.copyWith(termConditionErrorMessage: value);
  }

  void togglePasswordObscureText() {
    state = state.copyWith(passwordObscureText: !state.passwordObscureText);
  }

  void toggleAgreement(bool value) {
    state = state.copyWith(isAgreed: value);
  }

  void toggleReceiveEmail(bool value) {
    state = state.copyWith(isReceiveEmail: value);
  }

  void setSelectedGender(String? gender) {
    state = state.copyWith(selectedGender: gender);
  }

  void toggleMenuOpen() {
    state = state.copyWith(isMenuOpen: !state.isMenuOpen);
  }

  void moveToNextField(FocusNode nextFocusNode) {
    nextFocusNode.requestFocus();
  }

  void updateDateOfBirth(String formattedDate) {
    state.dateOfBirthController.text = formattedDate;
    state = state.copyWith(dateOfBirthErrorMessage: '');
  }

  void setCountryCode(String countryCode) {
    state = state.copyWith(mobilePrefix: countryCode);
  }

  void togglePassObscureText() {
    state = state.copyWith(passwordObscureText: !state.passwordObscureText);
  }
}

/// Provider for SignUpRepository.
final Provider<SignUpRepository> signUpRepositoryProvider =
    Provider<SignUpRepository>((Ref ref) {
  return SignUpRepositoryImpl();
});

/// Provider for SignupNotifier (auto-dispose for page-level instances).
final AutoDisposeStateNotifierProviderFamily<SignupNotifier, SignupState, SignupState> signupNotifierProvider =
    StateNotifierProvider.autoDispose.family<SignupNotifier, SignupState, SignupState>(
  (AutoDisposeStateNotifierProviderRef<SignupNotifier, SignupState> ref, SignupState initialState) {
    final SignUpRepository repository = ref.watch(signUpRepositoryProvider);
    return SignupNotifier(repository: repository, initialState: initialState);
  },
);

