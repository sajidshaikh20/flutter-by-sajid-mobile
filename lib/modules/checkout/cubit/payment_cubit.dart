import '../../../utils/exports.dart';

/// The [PaymentCubit] is responsible for managing the state
/// of the payment process.
/// It fetches payment review information and handles the
/// related API interactions.
class PaymentCubit extends BaseCubit<PaymentState> {
  /// Creates an instance of [PaymentCubit] with the provided dependencies.
  ///

  /// to be used during payment.
  PaymentCubit()  :
        super(
          const PaymentState(),
        );

  /// This method handles the API call to retrieve the payment
  /// review information.
  /// the actual API request.
  /// This function can be used to fetch the details of the payment
  /// review before proceeding
  /// to the final checkout steps.




  @override
  PaymentState getResetErrorState() => state.copyWith(msg: '');

  @override
  PaymentState getResetRedirectionState() => state.copyWith(msg: '');


  /// Updates the selected payment method based on the provided index [value].
  /// The payment method at the given index will be marked as selected, and
  /// the updated list will be emitted as part of the new state.

  /// This method proceeds to checkout by verifying the selected payment method.
  /// If the selected method is Cash on Delivery, it sends a request to the
  /// repository to proceed with the checkout. If successful, it tracks the
  /// purchase event and redirects to the payment status page.
  /// In case of failure,
  /// an error message is displayed.

}
