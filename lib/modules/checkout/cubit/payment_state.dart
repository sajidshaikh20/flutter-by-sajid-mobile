import '../../../utils/exports.dart';

/// Represents the state of the payment process in the application.
class PaymentState extends BaseState {
  /// Constructor for initializing the [PaymentState].
  /// It allows setting values for the status, message, redirect
  /// route, payment methods,
  /// review payment response, and whether the snackbar should be displayed.
  const PaymentState({
    super.status = BaseStateStatus.initial, // Initial state for status
    super.msg = '', // Initial state for message
    super.redirectRoute, // Optional redirect route to navigate
    this.paymentMethods, // List of available payment methods
    this.reviewPaymentResponse, // Response model for payment review
    this.isSnackBarDisplay, // Flag to show or hide snackbar
  });

  /// List of payment methods available in the payment process.
  final List<PaymentMethodResponse>? paymentMethods;

  /// Model containing the review payment response data.
  final ReviewPaymentResponseModel? reviewPaymentResponse;

  /// Boolean flag to control the visibility of the snackbar.
  final bool? isSnackBarDisplay;

  /// Overridden [props] method to return the list of properties for comparison
  /// in state updates and for equality checking.
  @override
  List<Object?> get props => <Object?>[
        paymentMethods,
        reviewPaymentResponse,
        isSnackBarDisplay,
        ...super.props, // Inherit properties from the BaseState class
      ];

  /// Creates a new instance of [PaymentState] with updated values.
  /// This method returns a new [PaymentState] with specific fields replaced.
  PaymentState copyWith({
    BaseStateStatus? status, // Optional updated status
    String? msg, // Optional updated message
    PageRouteInfo? redirectRoute, // Optional updated route
    List<PaymentMethodResponse>? paymentMethods, // Optional updated payment methods
    ReviewPaymentResponseModel?
        reviewPaymentResponse, // Optional updated response
    bool? isSnackBarDisplay, // Optional updated snackbar display flag
  }) =>
      PaymentState(
        msg: msg ?? this.msg,
        // If provided, replace msg, otherwise keep the current one
        status: status ?? this.status,
        // If provided, replace status, otherwise keep the current one
        redirectRoute: redirectRoute ?? this.redirectRoute,
        // If provided, replace route
        paymentMethods: paymentMethods ?? this.paymentMethods,
        // If provided, replace paymentMethods
        reviewPaymentResponse:
            reviewPaymentResponse ?? this.reviewPaymentResponse,
        // If provided, replace response
        isSnackBarDisplay: isSnackBarDisplay ??
            this.isSnackBarDisplay, // If provided, replace snackbar flag
      );
}
