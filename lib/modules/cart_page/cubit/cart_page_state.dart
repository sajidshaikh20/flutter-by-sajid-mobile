import '../../../utils/exports.dart';

/// Represents the state of the cart page, handling cart details, upsell items,
/// free gifts, coupon application, and various statuses related to cart management.
class CartPageState extends BaseState {


  /// Represents the status of adding items to the cart.
  final BaseStateStatus statusForAddToCart;

  /// Represents the status of cart listing API call.
  final BaseStateStatus statusForCartListing;

  /// List of flattened product variants for easier cart operations.
  final List<ProductVariantDukkan>? flattenedVariants;

  /// Cart listing response model containing summary and items
  final CartDetailsListingResponseModel? cartDetailsListingResponse;

  /// Represents the status of home deals API call.
  final BaseStateStatus apiCallForHomeDeals;

  /// Represents the status of you may also like deals API call.
  final BaseStateStatus apiCallForYouMayAlsoLikeDeals;

  /// List of deals response models for home deals section.
  final List<DealsResponseModel>? dealsModel;

  /// List of deals response models for you may also like section.
  final List<DealsResponseModel>? youMayAlsoLikeDealsModel;

  /// Indicates whether the snackbar is displayed.
  final bool isSnackBarDisplay;

  /// Message to display as a notification or information.
  final String? displayMessage;


  /// Stores the total count of items in the cart.
  final int? cartCount;

  /// Indicates whether the cart count has been updated.
  final bool? isCartCountUpdate;

  /// Stores the coupon code applied to the cart.
  final String? couponCode;

  /// Controller for managing the input field state.
  final TextEditingController stateTextEditingController;

  /// Indicates if a coupon is applied to the cart.
  final bool isCouponApplied;

  /// Indicates if the keyboard is currently open.
  final bool isKeyboardOpen;

  /// Represents the selected time slot for delivery.
  final int? selectedTimeSlot;

   /// Represents the selected Reward for delivery.
  final int? selectedReward;

  /// Indicates whether the selected time slot is unavailable.
  final bool isTimeUnavailable;

  /// Represents the status of time slots API call.
  final BaseStateStatus statusForTimeSlots;

  /// List of available time slots from API.
  final List<TimeSlotsResponse>? availableTimeSlots;

  /// Represents the selected payment method.
  final PaymentMethodResponse? selectedPaymentMethod;

  /// Represents the status of payment methods API call.
  final BaseStateStatus statusForPaymentMethods;

  /// List of available payment methods from API.
  final List<PaymentMethodResponse>? availablePaymentMethods;

  /// List of available Rewards List from API.
  final List<DefaultRewardIds>? defaultRewardIds;

  /// Indicates whether the order success dialog should be displayed.
  final bool showOrderSuccessDialog;

  /// Indicates whether the free gift dialog should be displayed.
  final bool showFreeGiftDialog;

  /// Indicates whether the free gift dialog should be displayed.
  final bool showNextOrderCouponDialog;

  /// Order ID from successful order creation
  final int? orderId;

  /// Transaction ID from successful order creation
  final String? transactionId;

  /// Date and time from successful order creation
  final String? orderDateTime;

  ///msgCoupon
  final String? msgCoupon;

  /// Total amount from successful order creation
  final double? orderTotalAmount;

  /// Delivery instructions captured on cart page (delivery flow only)
  final String? deliveryInstructions;

  /// Constructor for initializing the cart page state.
  const CartPageState({

    super.status = BaseStateStatus.initial,
    super.msg = '',
    super.redirectRoute,


    required this.isSnackBarDisplay,
    this.displayMessage,
    required this.statusForAddToCart,
    required this.statusForCartListing,
    this.flattenedVariants,
    this.cartDetailsListingResponse,
    required this.apiCallForHomeDeals,
    required this.apiCallForYouMayAlsoLikeDeals,
    this.dealsModel,
    this.youMayAlsoLikeDealsModel,

    this.cartCount,
    this.couponCode,
    required this.stateTextEditingController,
    this.isCartCountUpdate,
    this.isCouponApplied = false,
    this.isKeyboardOpen = false,
    this.selectedTimeSlot,
    this.selectedReward,
    this.isTimeUnavailable = false,
    required this.statusForTimeSlots,
    this.availableTimeSlots,
    this.selectedPaymentMethod,
    required this.statusForPaymentMethods,
    this.availablePaymentMethods,
    this.defaultRewardIds,
    this.showOrderSuccessDialog = false,
    this.showFreeGiftDialog = false,
    this.showNextOrderCouponDialog = false,
    this.orderId,
    this.transactionId,
    this.orderDateTime,
    this.orderTotalAmount,
    this.msgCoupon,
    this.deliveryInstructions,
  });

  /// Factory constructor to create an initial state for the cart page.
  factory CartPageState.initial() {
    return CartPageState(


      isSnackBarDisplay: false,
      couponCode: "",
      stateTextEditingController: TextEditingController(),
      statusForAddToCart: BaseStateStatus.initial,
      statusForCartListing: BaseStateStatus.initial,
      apiCallForHomeDeals: BaseStateStatus.initial,
      apiCallForYouMayAlsoLikeDeals: BaseStateStatus.initial,
      statusForTimeSlots: BaseStateStatus.initial,
      statusForPaymentMethods: BaseStateStatus.initial,
    );
  }

  /// Creates a copy of the current state with modified values.
  CartPageState copyWith({
    UpsellResponseModel? upsellResponseModel,
    BaseStateStatus? statusForUpsell,
    BaseStateStatus? statusForFreeGift,
    String? errorMsgForUpSell,
    String? errorMsgForFreeGift,
    BaseStateStatus? status,
    String? msg,
    List<ProductList>? freeProductList,
    bool? isSnackBarDisplay,
    String? displayMessage,
    BaseStateStatus? statusForAddToCart,
    BaseStateStatus? statusForCartListing,
    List<ProductVariantDukkan>? flattenedVariants,
    CartDetailsListingResponseModel? cartDetailsListingResponse,
    BaseStateStatus? apiCallForHomeDeals,
    BaseStateStatus? apiCallForYouMayAlsoLikeDeals,
    List<DealsResponseModel>? dealsModel,
    List<DealsResponseModel>? youMayAlsoLikeDealsModel,
    List<String>? qtyDropdownItems,
    int? cartCount,
    String? couponCode,
    BaseStateStatus? statusForCartDetails,
    bool? isCartCountUpdate,
    bool? isCouponApplied,
    bool? isKeyboardOpen,
    int? selectedTimeSlot,
    int? selectedReward,
    bool? isTimeUnavailable,
    BaseStateStatus? statusForTimeSlots,
    List<TimeSlotsResponse>? availableTimeSlots,
    PaymentMethodResponse? selectedPaymentMethod,
    BaseStateStatus? statusForPaymentMethods,
    List<PaymentMethodResponse>? availablePaymentMethods,
    List<DefaultRewardIds>? defaultRewardIds,
    bool? showOrderSuccessDialog,
    bool? showFreeGiftDialog,
    bool? showNextOrderCouponDialog,
    int? orderId,
    String? transactionId,
    String? orderDateTime,
    String? msgCoupon,
    double? orderTotalAmount,
    String? deliveryInstructions,
  }) {
    return CartPageState(


      status: status ?? this.status,
      msg: msg ?? this.msg,

      isSnackBarDisplay: isSnackBarDisplay ?? this.isSnackBarDisplay,
      displayMessage: displayMessage ?? this.displayMessage,
      statusForAddToCart: statusForAddToCart ?? this.statusForAddToCart,
      statusForCartListing: statusForCartListing ?? this.statusForCartListing,
      flattenedVariants: flattenedVariants ?? this.flattenedVariants,
      cartDetailsListingResponse: cartDetailsListingResponse ?? this.cartDetailsListingResponse,
      apiCallForHomeDeals: apiCallForHomeDeals ?? this.apiCallForHomeDeals,
      apiCallForYouMayAlsoLikeDeals: apiCallForYouMayAlsoLikeDeals ?? this.apiCallForYouMayAlsoLikeDeals,
      dealsModel: dealsModel ?? this.dealsModel,
      youMayAlsoLikeDealsModel: youMayAlsoLikeDealsModel ?? this.youMayAlsoLikeDealsModel,
      cartCount: cartCount ?? this.cartCount,
      isCartCountUpdate: isCartCountUpdate ?? this.isCartCountUpdate,
      stateTextEditingController: stateTextEditingController,
      couponCode: couponCode ?? this.couponCode,
      isCouponApplied: isCouponApplied ?? this.isCouponApplied,
      isKeyboardOpen: isKeyboardOpen ?? this.isKeyboardOpen,
      selectedTimeSlot: selectedTimeSlot ?? this.selectedTimeSlot,
      selectedReward: selectedReward ?? this.selectedReward,
      isTimeUnavailable: isTimeUnavailable ?? this.isTimeUnavailable,
      statusForTimeSlots: statusForTimeSlots ?? this.statusForTimeSlots,
      availableTimeSlots: availableTimeSlots ?? this.availableTimeSlots,
      selectedPaymentMethod: selectedPaymentMethod ?? this.selectedPaymentMethod,
      statusForPaymentMethods: statusForPaymentMethods ?? this.statusForPaymentMethods,
      availablePaymentMethods: availablePaymentMethods ?? this.availablePaymentMethods,
      defaultRewardIds: defaultRewardIds ?? this.defaultRewardIds,
      showOrderSuccessDialog: showOrderSuccessDialog ?? this.showOrderSuccessDialog,
      showFreeGiftDialog: showFreeGiftDialog ?? this.showFreeGiftDialog,
      showNextOrderCouponDialog: showNextOrderCouponDialog ?? this.showNextOrderCouponDialog,
      orderId: orderId ?? this.orderId,
      transactionId: transactionId ?? this.transactionId,
      orderDateTime: orderDateTime ?? this.orderDateTime,
      orderTotalAmount: orderTotalAmount ?? this.orderTotalAmount,
      msgCoupon: msgCoupon ?? this.msgCoupon,
      deliveryInstructions: deliveryInstructions ?? this.deliveryInstructions,
    );
  }

  @override
  List<Object?> get props =>
      <Object?>[
        super.msg,
        super.status,
        super.redirectRoute,
        statusForAddToCart,
        statusForCartListing,
        flattenedVariants,
        cartDetailsListingResponse,
        apiCallForHomeDeals,
        apiCallForYouMayAlsoLikeDeals,
        dealsModel,
        youMayAlsoLikeDealsModel,
        isSnackBarDisplay,
        displayMessage,
        cartCount,
        isCartCountUpdate,
        couponCode,
        stateTextEditingController,
        isCouponApplied,
        isKeyboardOpen,
        selectedTimeSlot,
        selectedReward,
        isTimeUnavailable,
        statusForTimeSlots,
        availableTimeSlots,
        defaultRewardIds,
        selectedPaymentMethod,
        statusForPaymentMethods,
        availablePaymentMethods,
        showOrderSuccessDialog,
        showFreeGiftDialog,
        showNextOrderCouponDialog,
        orderId,
        transactionId,
        orderDateTime,
        orderTotalAmount,
        deliveryInstructions,
      ];
}

