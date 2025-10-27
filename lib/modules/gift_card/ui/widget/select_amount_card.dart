import '../../../../utils/exports.dart';

/// A widget that displays a card for selecting an amount.
///
/// This card can be used in forms or payment interfaces where users need to
/// choose or input a specific amount.
class SelectAmountCard extends StatelessWidget {
  /// The text label displaying the amount (e.g., "120 KD").
  final String? amountLabel;

  /// Whether this card is currently selected.
  final bool isSelect;

  /// Callback function when the card is tapped.
  final VoidCallback? onTap;

  ///
  const SelectAmountCard({
    super.key,
    this.amountLabel,
    this.isSelect = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Trigger the callback when the container is tapped
      child: Container(
        height: Dimens.size58,

        decoration: BoxDecoration(
          border: Border.all(
            color: isSelect ? MainConfig.appColors.mainColor : MainConfig.appColors.lightGreyColor,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(Dimens.space8)),
          color: isSelect ? MainConfig.appColors.iceBlueColor : AppColors.whiteColor,
        ),
        child: Center(
          child: CustomTextLabelWidget(
textDirection: TextDirection.ltr,
            label: amountLabel ?? "",
            style: isSelect? context.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: Dimens.fontSize16,
              color: MainConfig.appColors.mainColor,

            ):context.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.normal,
              fontSize: Dimens.fontSize16,
              color: MainConfig.appColors.labelGrey,

            ),
          ),
        ),
      ),
    );
  }
}
