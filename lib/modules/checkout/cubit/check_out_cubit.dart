import '../../../utils/exports.dart';

/// Cubit responsible for managing the state and business logic related
/// to the checkout process, including fetching address list and shipping
/// methods.
class CheckOutCubit extends BaseCubit<CheckOutState> {
  /// Creates an instance of CheckOutCubit, initializes the state, and triggers
  /// address list fetch operation.
  CheckOutCubit({
    required this.repository,
  }) : super(
          const CheckOutState(
            startShowingShimmer: true,
            addressShimmer: true,
          ),
        );

  /// Repository for handling checkout-related operations.
  final CheckOutRepository repository;

  /// The cart list response model that contains the cart items.


  /// Holds a list of available time slots for selecting delivery time.
  final List<TimeSlotData> _timeSlotData = <TimeSlotData>[];

  /// Holds the list of selected time slots for a specific date.
  final List<Slot> _selectedDateSlotData = <Slot>[];

  /// Contains the list of available shipping methods for delivery.
  final List<ShippingMethods> _shippingMethods = <ShippingMethods>[];

  /// The billing address used for the checkout process.
  BillingAddress? billingAddress;



  /// Calls the API to set the selected slot and handles the response.
  /// On success, updates the state and redirects to the payment review route.
  /// On failure, displays an error message or the default error message.
  Future<void> callSetSlotApi() async {
    emit(state.copyWith(status: BaseStateStatus.loading));
    SetSlotRequestModel request = SetSlotRequestModel(
      slotId: int.tryParse(
        _selectedDateSlotData
                .firstWhereOrNull(
                  (Slot element) => element.isSelected ?? false,
                )
                ?.id ??
            '0',
      ),
      quoteId: int.tryParse(
        getIt<UserProfileService>().quoteId,
      ),
    );
    await repository.setSlot(setSlotRequestModel: request).then(
      (ResponseHandler<SetSlotResponseModel> value) {
        if (value.isSuccess()) {
          OnSuccessResponse<SetSlotResponseModel>? successInstance =
              value.getSuccessInstance();
          if (successInstance != null) {
            SetSlotResponseModel response = successInstance.response;
            if (response.status == 200 &&
                response.message.toString().toLowerCase() ==
                    AppConstant.success.toLowerCase()) {
              emit(
                state.copyWith(
                  status: BaseStateStatus.success,
                  redirectRoute: PaymentReviewRoute(
                    billingAddress: billingAddress ?? BillingAddress(),
                    shippingData: _shippingMethods
                            .firstWhereOrNull(
                              (ShippingMethods element) =>
                                  element.isSelected ?? false,
                            )
                            ?.method
                            ?.first ??
                        Method(),
                  ),
                ),
              );
            } else {
              emit(
                state.copyWith(
                  status: BaseStateStatus.failure,
                  isSnackBarDisplay: true,
                  msg: response.message,
                ),
              );
            }
          }
        } else if (value.isFailure()) {
          OnFailureResponse<SetSlotResponseModel>? failureInstance =
              value.getFailureInstance();
          if (failureInstance?.error?.errorMessage != null) {
            _handleFailure(failureInstance?.error?.errorMessage);
          } else {
            emit(
              state.copyWith(
                status: BaseStateStatus.failure,
                showDefaultErrMsg: true,
              ),
            );
          }
        }
      },
    );
  }



  /// Handle failure case
  void _handleFailure(String? msg) {
    emit(state.copyWith(status: BaseStateStatus.failure, msg: msg));
  }

  /// Selects a shipping method by its index and updates the state.
  /// It resets the selection for all shipping methods and selects the
  /// one at the given index.
  void selectShippingMethod(int index) {
    List<ShippingMethods> shippingMethods = state.shippingMethodsList;

    // Reset all selections and select the new method
    for (int i = 0; i < shippingMethods.length; i++) {
      shippingMethods[i].isSelected = (i == index);
    }

    emit(
      state.copyWith(
        status: BaseStateStatus.initial,
        shippingMethodsList: shippingMethods,
      ),
    );
  }



  @override
  CheckOutState getResetErrorState() => state.copyWith(msg: '');

  @override
  CheckOutState getResetRedirectionState() => state.copyWith(msg: '');

  /// Updates the billing address and triggers the necessary state changes.
  /// It sets the new billing address, triggers loading, and fetches the
  /// shipping methods
  /// and available time slots based on the updated address.


  /// Handles the selection of a time slot date.
  /// It updates the selection status of
  /// the selected date and its associated slots, and emits the updated state
  /// with the selected time slots and time slot data.
  void onTapDate(int index) {
    for (final TimeSlotData elements in _timeSlotData) {
      elements.isSelected = false;
      elements.slots?.forEach(
        (Slot element) => element.isSelected = false,
      );
    }
    _timeSlotData[index].isSelected = true;
    _selectedDateSlotData
      ..clear()
      ..addAll(
        _timeSlotData
                .firstWhereOrNull(
                    (TimeSlotData element) => element.isSelected ?? false)
                ?.slots ??
            <Slot>[],
      );
    emit(
      state.copyWith(
        selectedDateSlotData: List<Slot>.from(_selectedDateSlotData),
        timeSlotData: List<TimeSlotData>.from(_timeSlotData),
        status: BaseStateStatus.success,
      ),
    );
  }

  /// Handles the selection of a specific time slot.
  /// It updates the selection status
  /// of the selected slot and emits the updated state with the selected time
  /// slot data.
  void onTapSlot(int index) {
    for (final Slot elements in _selectedDateSlotData) {
      elements.isSelected = false;
    }
    _selectedDateSlotData[index].isSelected = true;
    emit(state.copyWith(status: BaseStateStatus.loading));
    emit(
      state.copyWith(
        status: BaseStateStatus.success,
        selectedDateSlotData: List<Slot>.from(_selectedDateSlotData),
      ),
    );
  }

  /// Handles the logic when the user taps the proceed button. It checks whether
  /// the necessary conditions (shipping method, time slot, and selected date)
  /// are met. If all conditions are satisfied, it proceeds to call the API to
  /// set the selected slot, otherwise, it shows appropriate error messages.
  Future<void> onTapProceedButton() async {
    if (_shippingMethods.isNotEmpty &&
        _shippingMethods.firstWhereOrNull(
              (ShippingMethods element) => element.isSelected ?? false,
            ) !=
            null) {
      if (_timeSlotData.isNotEmpty &&
          _timeSlotData.firstWhereOrNull(
                (TimeSlotData element) => element.isSelected ?? false,
              ) !=
              null) {
        if (_selectedDateSlotData.isNotEmpty &&
            _selectedDateSlotData.firstWhereOrNull(
                  (Slot element) => element.isSelected ?? false,
                ) !=
                null) {
          await callSetSlotApi();
        } else {
          emit(
            state.copyWith(
              msg: AppConstant.selectDateMethod,
              isSnackBarDisplay: true,
            ),
          );
          unawaited(Future<void>.delayed(
              const Duration(milliseconds: Dimens.milliseconds200), () {
            emit(
              state.copyWith(
                isSnackBarDisplay: false,
                status: BaseStateStatus.success,
              ),
            );
          }));
        }
      } else {
        emit(
          state.copyWith(
            redirectRoute: PaymentReviewRoute(
              billingAddress: billingAddress ?? BillingAddress(),
              shippingData: _shippingMethods
                      .firstWhereOrNull(
                        (ShippingMethods element) =>
                            element.isSelected ?? false,
                      )
                      ?.method
                      ?.first ??
                  Method(),
            ),
          ),
        );
      }
    } else {
      emit(
        state.copyWith(
          msg: AppConstant.selectShippingMethod,
          isSnackBarDisplay: true,
        ),
      );
      unawaited(Future<void>.delayed(
        const Duration(milliseconds: Dimens.milliseconds200),
        () {
          emit(
            state.copyWith(
              isSnackBarDisplay: false,
              status: BaseStateStatus.success,
            ),
          );
        },
      ));
    }
  }
}
