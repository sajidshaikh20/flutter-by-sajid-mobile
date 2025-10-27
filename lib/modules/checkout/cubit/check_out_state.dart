import '../../../utils/exports.dart';

/// Represents the state of the checkout process in the application, holding
/// various data related to shipping methods, address information, time slots,
/// cart details, and other necessary information. This state is used to manage
/// the flow of the checkout process, including error handling, snackbars,
/// and UI states.
class CheckOutState extends BaseState {
  /// Constructor to initialize [CheckOutState] with all necessary properties.
  ///
  /// - [status] represents the current status of the state.
  /// - [shippingMethodsList] is a list of available shipping methods.
  /// - [msg] contains any message to be displayed (like error messages).
  /// - [redirectRoute] holds the route to redirect after certain actions.
  /// - [showDefaultErrMsg] flag to show a default error message
  /// in case of failures.
  /// - [showSelectionErrMsg] flag to show error message related to
  /// selection issues.
  /// - [addressListResponseModel] contains the response model for
  /// the address list.
  /// - [myAddressList] is a list of addresses associated with the user.
  /// - [selectedAddress] is the address that is currently selected for
  /// checkout.
  /// - [timeSlotResponseModel] holds the response for available time slots.
  /// - [selectedDateSlotData] contains data for the selected date slot.
  /// - [timeSlotData] contains the list of available time slots.
  /// - [isSnackBarDisplay] flag to control the display of snackbar messages.
  /// - [startShowingShimmer] flag to trigger the shimmer loading effect.
  /// - [addressShimmer] flag to trigger shimmer effect for address loading.
  const CheckOutState({
    super.status = BaseStateStatus.initial,
    this.shippingMethodsList = const <ShippingMethods>[],
    super.msg = '',
    super.redirectRoute,
    this.showDefaultErrMsg = false,
    this.showSelectionErrMsg = false,
    this.addressListResponseModel,
    this.myAddressList,
    this.selectedAddress,
    this.timeSlotResponseModel,
    this.selectedDateSlotData,
    this.timeSlotData,
    this.isSnackBarDisplay,
    this.startShowingShimmer = false,
    this.addressShimmer = false,
  });

  /// A list of available shipping methods.
  final List<ShippingMethods> shippingMethodsList;

  /// A flag indicating whether to show the default error message.
  final bool? showDefaultErrMsg;

  /// A flag indicating whether to show the error message related to selection.
  final bool? showSelectionErrMsg;

  /// The response model containing the address list.
  final AddressListResponseModel? addressListResponseModel;

  /// A list of addresses associated with the user.
  final List<BillingAddress>? myAddressList;



  /// The address that has been selected for checkout.
  final BillingAddress? selectedAddress;

  /// The response model for available time slots.
  final TimeSlotsResponseModel? timeSlotResponseModel;

  /// The list of available time slots for the user to choose from.
  final List<TimeSlotData>? timeSlotData;

  /// A list of slots for the selected date.
  final List<Slot>? selectedDateSlotData;

  /// A flag that indicates whether a snackbar is displayed for messages.
  final bool? isSnackBarDisplay;

  /// A flag to indicate whether the shimmer effect for loading is enabled.
  final bool? startShowingShimmer;

  /// A flag to control the shimmer effect for address loading.
  final bool? addressShimmer;

  @override
  List<Object?> get props => <Object?>[
    shippingMethodsList,
    showDefaultErrMsg,
    showSelectionErrMsg,
    addressListResponseModel,
    myAddressList,
    selectedAddress,
    timeSlotResponseModel,
    selectedDateSlotData,
    timeSlotData,
    isSnackBarDisplay,
    startShowingShimmer,
    addressShimmer,
    ...super.props,
  ];

  /// Creates a new [CheckOutState] with the updated properties.
  ///
  /// - [status] updates the current state status.
  /// - [shippingMethodsList] updates the list of shipping methods.
  /// - [redirectRoute] specifies the route to redirect after action.
  /// - [msg] updates the message field, typically for displaying errors.
  /// - [showDefaultErrMsg], [sh,owSelectionErrMsg] control error displays.
  /// - [addressListResponseModel], [myAddressList], [selectedAddress] handle
  /// address-related data.
  /// - [timeSlotResponseModel], [timeSlotData], [selectedDateSlotData] handle
  /// time slot data.
  /// - [isSnackBarDisplay] and [startShowingShimmer] control UI behavior.
  /// - [addressShimmer] triggers the shimmer effect for address loading.
  CheckOutState copyWith({
    BaseStateStatus? status,
    List<ShippingMethods>? shippingMethodsList,
    PageRouteInfo? redirectRoute,
    String? msg,
    bool? showDefaultErrMsg,
    bool? showSelectionErrMsg,
    AddressListResponseModel? addressListResponseModel,
    List<BillingAddress>? myAddressList,
    BillingAddress? selectedAddress,
    TimeSlotsResponseModel? timeSlotResponseModel,
    List<TimeSlotData>? timeSlotData,
    List<Slot>? selectedDateSlotData,
    bool? isSnackBarDisplay,
    bool? startShowingShimmer,
    bool? addressShimmer,
  }) =>
      CheckOutState(
        status: status ?? this.status,
        shippingMethodsList: shippingMethodsList ?? this.shippingMethodsList,
        redirectRoute: redirectRoute,
        msg: msg,
        addressListResponseModel:
        addressListResponseModel ?? this.addressListResponseModel,
        myAddressList: myAddressList ?? this.myAddressList,
        showDefaultErrMsg: showDefaultErrMsg ?? this.showDefaultErrMsg,
        showSelectionErrMsg: showSelectionErrMsg ?? this.showSelectionErrMsg,
        selectedAddress: selectedAddress ?? this.selectedAddress,
        timeSlotResponseModel:
        timeSlotResponseModel ?? this.timeSlotResponseModel,
        timeSlotData: timeSlotData ?? this.timeSlotData,
        selectedDateSlotData: selectedDateSlotData ?? this.selectedDateSlotData,
        isSnackBarDisplay: isSnackBarDisplay ?? this.isSnackBarDisplay,
        startShowingShimmer: startShowingShimmer ?? this.startShowingShimmer,
        addressShimmer: addressShimmer ?? this.addressShimmer,
      );
}
