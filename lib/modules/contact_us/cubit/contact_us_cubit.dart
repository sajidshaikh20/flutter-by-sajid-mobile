import '../../../utils/exports.dart';

/// Cubit responsible for managing the state and actions of the Contact Us page.
class ContactUsCubit extends Cubit<ContactUsState> {
  /// Creates an instance of [ContactUsCubit] with the given initial state.
  ContactUsCubit({required ContactUsState initialState}) : super(initialState);

  /// Repository for making API calls
  final ContactUsRepository _repository = ContactUsRepositoryImpl();

  /// Launches the phone dialer with the provided [phoneNumber].
  ///
  /// Throws an exception if the dialer cannot be opened.
  Future<void> launchDialer(String phoneNumber) async {
    Uri phoneNo = Uri(scheme: AppConstant.tel, path: phoneNumber);
    if (await canLaunchUrl(phoneNo)) {
      await launchUrl(phoneNo);
    } else {
      throw 'Could not launch $phoneNo';
    }
  }

  /// Launches WhatsApp for the given [phoneNumber].
  ///
  /// Throws an exception if WhatsApp cannot be opened.
  Future<void> launchWhatsApp(String phoneNumber) async {
    final Uri whatsAppUrl = Uri.parse('${AppConstant.whatsapp}$phoneNumber');
    if (await canLaunchUrl(whatsAppUrl)) {
      await launchUrl(whatsAppUrl);
    } else {
      throw 'Could not launch $whatsAppUrl';
    }
  }

  /// Launches the default email client with the given [emailAddress].
  ///
  /// Throws an exception if the email client cannot be opened.
  Future<void> launchEmail(String emailAddress) async {
    final Uri url = Uri(scheme: AppConstant.mailTo, path: emailAddress);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  /// Initializes the cubit with the list of contact status models.
  FutureOr<void> init(List<LocalContactUsModel> listOfContactStatus) {
    emit(state.copyWith(status: BaseStateStatus.loading));
  }

  /// Shows a snackbar message and resets to loading state after a delay.
  void showSnackBarView(String? value) {
    emit(state.copyWith(status: BaseStateStatus.success));
    unawaited(Future<void>.delayed(
      const Duration(seconds: Dimens.seconds5),
          () {
        emitLoadingState();
        emit(state.copyWith(status: BaseStateStatus.success));
      },
    ));
  }

  /// Emits a loading state.
  void emitLoadingState() {
    emit(state.copyWith(status: BaseStateStatus.loading));
  }

  /// Handles validation error for the full name field.
  void handleValidationErrorMessageForFullName(String value) {
    emit(state.copyWith(fullNameErrorMessage: value));
  }

  /// Handles validation error for the description/comment field.
  void handleValidationErrorMessageForDescription(String value) {
    emit(state.copyWith(writeCommnetMessage: value));
  }

  /// Handles validation error for the mobile number field.
  void handleValidationErrorMessageForMobileNumber(String value) {
    emit(state.copyWith(mobileErrorMessage: value));
  }

  /// Handles validation error for the email field.
  void handleValidationErrorMessageForEmail(String value) {
    emit(state.copyWith(emailErrorMessage: value));
  }

  /// Updates the selected nationality.
  void updateNationality(String nationality) {
    emit(state.copyWith(selectedNationality: nationality));
  }

  /// Handles validation error for the date of birth field.
  void handleValidationErrorMessageForDateOfBirth(String value) {
    emit(state.copyWith(dateOfBirthErrorMessage: value));
  }

  /// Changes focus to the next input field.
  void moveToNextField(FocusNode nextFocusNode) {
    nextFocusNode.requestFocus();
  }

  /// Updates the mobile country code.
  void updateMobileCode(String phoneCode) {
    emit(state.copyWith(status: BaseStateStatus.success, phoneCode: phoneCode));
  }

  /// Submits the contact us form via API call.
  Future<void> submitContactUsForm({
    required String name,
    required String mobile,
    required String email,
    required String comment,
  }) async {
    emit(state.copyWith(status: BaseStateStatus.loading));

    // Get customer token from UserProfileService
    final String customerToken = getIt<UserProfileService>().customerToken;
    
    // Create contact us request model
    final ContactUsRequestModel request = ContactUsRequestModel(
      name: name,
      mobile: mobile,
      email: email,
      comment: comment,
      customerToken: customerToken,
      platform: getPlatformName(),
      version: getIt<MainConfig>().packageInfo.version,
      languageId: int.tryParse(getIt<LanguageService>().languageId)
    );

    try {
      final ResponseHandler<BaseResponse<void>> response =
          await _repository.contactUsApi(contactUsRequestModel: request);

      if (response.isSuccess()) {
        final OnSuccessResponse<BaseResponse<void>>?
            successInstance = response.getSuccessInstance();

        if (successInstance != null) {
          final BaseResponse<void> baseResponse = successInstance.response;

          if (baseResponse.success) {
            emit(state.copyWith(
              status: BaseStateStatus.success,
              msg: baseResponse.message,
              successMsg: baseResponse.message,
            ));
            // Clear form after successful submission
            _clearForm();
          } else {
            emit(state.copyWith(
              status: BaseStateStatus.failure,
              msg: baseResponse.message.isNotEmpty ? baseResponse.message : 'Something went wrong',
            ));
          }
        } else {
          emit(state.copyWith(
            status: BaseStateStatus.failure,
            msg: 'Something went wrong',
          ));
        }
      } else {
        final OnFailureResponse<BaseResponse<void>>?
            failureInstance = response.getFailureInstance();
        final String errorMessage = failureInstance?.error?.errorMessage ?? 'Something went wrong';
        emit(state.copyWith(
          status: BaseStateStatus.failure,
          msg: errorMessage,
        ));
      }
    } on Exception catch (_) {
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: 'Something went wrong',
      ));
    }
  }

  /// Clears the form fields after successful submission
  void _clearForm() {
    state.fullNameController.clear();
    state.mobileNumberController.clear();
    state.emailController.clear();
    state.writeCommentContoller.clear();
    state.dateOfBirthController.clear();
    
    // Clear error messages
    emit(state.copyWith(
      fullNameErrorMessage: '',
      mobileErrorMessage: '',
      emailErrorMessage: '',
      writeCommnetMessage: '',
      dateOfBirthErrorMessage: '',
    ));
  }

  @override
  Future<void> close() {
    // Dispose text controllers to prevent memory leaks
    state.fullNameController.dispose();
    state.mobileNumberController.dispose();
    state.emailController.dispose();
    state.writeCommentContoller.dispose();
    state.dateOfBirthController.dispose();
    
    // Dispose focus nodes to prevent memory leaks
    state.fullNameFocusNode.dispose();
    state.mobileNumberFocusNode.dispose();
    state.writeCommentFocusNode.dispose();
    state.emailFocusNode.dispose();
    state.nationalityFocusNode.dispose();
    state.dateOfBirthFocusNode.dispose();
    
    return super.close();
  }
}
