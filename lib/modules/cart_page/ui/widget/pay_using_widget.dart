
import '../../../../utils/exports.dart';
/// A widget that allows users to select a payment method.
///
/// This widget can display available payment options (e.g., credit card,
/// wallet, COD) and handle user selection.
class PayUsingWidget extends StatefulWidget {
  /// Creates a [PayUsingWidget] instance.
  const PayUsingWidget({
    super.key,
    required this.paymentMethods,
    required this.selectedPaymentMethod,
    required this.onPaymentMethodSelected,
    this.onBottomSheetClose,
  });

  /// The list of available payment methods to display.
  final List<PaymentMethodResponse> paymentMethods;

  /// The currently selected payment method, if any.
  final PaymentMethodResponse? selectedPaymentMethod;

  /// Callback triggered when a payment method is selected by the user.
  final Function(PaymentMethodResponse) onPaymentMethodSelected;

  /// Optional callback triggered when the bottom sheet is closed.
  final VoidCallback? onBottomSheetClose;


  @override
  State<PayUsingWidget> createState() => _PayUsingWidgetState();
}

class _PayUsingWidgetState extends State<PayUsingWidget> {
  @override
  Widget build(BuildContext context) {

    return
      Column(
      children: <Widget>[
        Container(
          margin: Dimens.space16.padding,
          decoration: BoxDecorationExtension.customDecoration(
            color: AppColors.whiteColor,
            borderRadius: Dimens.radius8.borderRadius,
              border: Border.all(color: MainConfig.appColors.lightGreyColor,width: Dimens.borderWidth05),

        ),
          child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: widget.paymentMethods.length,
            itemBuilder: (BuildContext context, int index) {
              final PaymentMethodResponse paymentMethod = widget.paymentMethods[index];
              return Padding(
                padding: const EdgeInsets.only(left: Dimens.space8),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: Dimens.space16,

                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(right: Dimens.space16),
                        child: SelectableIconRadio(

                          textStyle: context.textTheme.displayMedium?.copyWith(
                            fontSize: Dimens.fontSize14,
                            fontWeight: FontWeight.w600,
                            height: Dimens.lineHeight18.toLineHeight(Dimens.fontSize14),
                          ),
                          alignToStart: false,
                          radioPosition: RadioPosition.right,
                          value: paymentMethod.id.toString(),
                          label: paymentMethod.name ?? '',
                          groupValue: widget.selectedPaymentMethod?.id.toString(),
                          onChanged: (String? value) {
                            // Find the payment method by ID and select it
                            final PaymentMethodResponse selectedMethod = widget.paymentMethods.firstWhere(
                              (PaymentMethodResponse method) => method.id.toString() == value,
                            );
                            widget.onPaymentMethodSelected(selectedMethod);
                            
                            // Close the bottom sheet after selection
                            if (widget.onBottomSheetClose != null) {
                              widget.onBottomSheetClose!();
                            }
                          },
                          size: Dimens.size16,
                        ),
                      ),
                    ),
                    if (index != widget.paymentMethods.length - 1)
                    CustomDivider(
                      color: MainConfig.appColors.lightGreyColor,
                      height: Dimens.sizePoint5,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: Dimens.space16,)
      ],
    );
  }
}
