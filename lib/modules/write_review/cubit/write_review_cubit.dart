import '../../../utils/exports.dart';

/// Handles write-review interactions and API calls.
class WriteReviewCubit extends Cubit<WriteReviewState> {
  ///repository
  WriteReviewRepository repository;


  ///Constructor
  WriteReviewCubit({
    required this.repository,
    required WriteReviewState initialState,
  }) : super(initialState);

  /// Updates the current rating in state.
  void updateRating(int rating) {
    emit(state.copyWith(
        rating: rating,
        status: BaseStateStatus.success)); // Update the rating in the state
  }

  /// Calls API to save a review using current form values.
  Future<void> callApiSaveReview(
      SaveReviewRequestModel saveReviewRequestModel) async {
    emit(state.copyWith(status: BaseStateStatus.loading));
    SaveReviewRequestModel saveReviewRequestModel = SaveReviewRequestModel(
        quoteId: getIt<UserProfileService>().quoteId,
        websiteId: getIt<CountryService>().websiteId,
        customerToken: getIt<UserProfileService>().customerToken,
        title: AppConstant.stage,
        details: state.writeReviewTextController.text,
        productID: state.product?.entityId?.toString() ?? '' ,
        nickname: getIt<UserProfileService>().customerName,
        ratings: <String, dynamic>{"3": state.rating});
    try {
      final ResponseHandler<SaveReview> response = await repository
          .callSaveReviewAPI(createParamMap(saveReviewRequestModel));
      if (response.isSuccess()) {
        emit(state.copyWith(
            status: BaseStateStatus.success,
            saveReviewResponse: response.getSuccessInstance()?.response));
      } else if (response.isFailure()) {
        emit(state.copyWith(
            status: BaseStateStatus.failure,
            errorMessage:
                response.getFailureInstance()?.error?.errorMessage ?? ""));
      }
    }on Exception catch (error) {
      emit(state.copyWith(
          status: BaseStateStatus.failure, errorMessage: error.toString()));
    }
  }

  /// Builds the request payload for saving a review.
  Map<String, dynamic> createParamMap(
      SaveReviewRequestModel saveReviewRequestModel) {
    return <String, dynamic>{
      APIConstant.websiteId: saveReviewRequestModel.websiteId,
      APIConstant.storeId: saveReviewRequestModel.storeId,
      APIConstant.quoteId: saveReviewRequestModel.quoteId,
      APIConstant.customerToken: saveReviewRequestModel.customerToken,
      APIConstant.title: saveReviewRequestModel.title,
      APIConstant.detail: saveReviewRequestModel.details,
      APIConstant.nickname: saveReviewRequestModel.nickname,
      APIConstant.ratings: jsonEncode(saveReviewRequestModel.ratings),
      APIConstant.productId: saveReviewRequestModel.productID,
    };
  }
///getLabel
  String getLabel({
    required String formattedFinalPrice,
    required String formattedPrice,
  }) {
    return formattedFinalPrice.isNotEmpty &&
            formattedFinalPrice.isNotEmpty &&
            (formattedFinalPrice
                    .replaceAll(RegExpressions.instance.checkCurrency, "")
                    .trim() !=
                AppConstant.zeroPointZeroZero)
        ? formattedFinalPrice
        : formattedPrice;
  }

  /// Calls API to rate a product with the provided parameters.
  Future<void> rateProducts({
    required String productSKU,
    required String overview,
    required int rating,
  }) async {
    emit(state.copyWith(status: BaseStateStatus.loading));
    
    try {
      // Create RateProductRequestModel with appropriate parameters
      final RateProductRequestModel rateProductRequestModel = RateProductRequestModel(
        languageId: int.tryParse(getIt<LanguageService>().languageId) ?? 1,
        customerToken: getIt<UserProfileService>().customerToken,
        platform: getPlatformName(),
        version: getIt<MainConfig>().packageInfo.version,
        productSKU: productSKU,
        overview: overview,
        rating: rating,
      );

      final ResponseHandler<BaseResponse<void>> response = await repository
          .rateProducts(rateProductRequestModel);
      
      if (response.isSuccess()) {
        emit(state.copyWith(
          status: BaseStateStatus.success,
          msg: response.getSuccessInstance()?.response.message,
        ));
        // Clear form data after successful rating
        clearFormData();
      } else if (response.isFailure()) {
        emit(state.copyWith(
          status: BaseStateStatus.failure,
          msg: response.getFailureInstance()?.error?.errorMessage ?? ''
        ));
      }
    } on Exception catch (error) {
      emit(state.copyWith(
        status: BaseStateStatus.failure, 
        msg: error.toString(),
      ));
    }
  }

  /// Calls API to rate an order with the provided parameters.
  Future<void> rateOrder({
    required int orderId,
    required String overview,
    required int rating,
  }) async {
    emit(state.copyWith(status: BaseStateStatus.loading));
    try {
      final RateOrderRequestModel rateOrderRequestModel = RateOrderRequestModel(
        languageId: int.tryParse(getIt<LanguageService>().languageId) ?? 1,
        customerToken: getIt<UserProfileService>().customerToken,
        platform: getPlatformName(),
        version: getIt<MainConfig>().packageInfo.version,
        orderId: orderId,
        overview: overview,
        rating: rating,
      );

      final ResponseHandler<BaseResponse<void>> response = await repository
          .rateOrder(rateOrderRequestModel);
      
      if (response.isSuccess()) {
        emit(state.copyWith(
          status: BaseStateStatus.success,
          msg: response.getSuccessInstance()?.response.message,
        ));
        // Clear form data after successful rating
        clearFormData();
      } else if (response.isFailure()) {
        emit(state.copyWith(
          status: BaseStateStatus.failure,
          errorMessage: response.getFailureInstance()?.error?.errorMessage ?? '',
        ));
      }
    } on Exception catch (error) {
      emit(state.copyWith(
        status: BaseStateStatus.failure, 
        errorMessage: error.toString(),
      ));
    }
  }

  /// Moves focus to the provided focus node.
  void moveToNextField(FocusNode nextFocusNode) {
    nextFocusNode.requestFocus();
  }

  /// Clears all form data after successful submission.
  void clearFormData() {
    state.writeReviewTextController.clear();
    state.titleTextController.clear();
    emit(state.copyWith(
      rating: 0,
      status: BaseStateStatus.initial,
      msg: '',
      errorMessage: '',
    ));
  }

  @override
  Future<void> close() {
    state.writeReviewTextController.dispose();
    state.titleTextController.dispose();
    return super.close();
  }
}
