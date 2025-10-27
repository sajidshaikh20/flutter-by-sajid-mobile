import '../../../../utils/exports.dart';

/// A widget that displays the "Proceed" section in the cart or checkout page.
///
/// Typically contains buttons or actions for proceeding with the order,
/// such as "Proceed to Payment" or "Checkout".
class ProceedViewWidget extends StatelessWidget {
  /// The device type to adjust UI layout (mobile, tablet, desktop).
  final ScreenType device;
  
  /// The selected product unit to display pricing information
  final ProductListingResponse? selectedUnit;

  /// Creates a [ProceedViewWidget] instance.
  const ProceedViewWidget({
    super.key,
    this.device = ScreenType.mobile,
    this.selectedUnit,
  });


  @override
  Widget build(BuildContext context) {


    double orderSummaryFontSize = Dimens.fontSize14;
    double totalDiscountFOntSize = Dimens.fontSize14;
    switch (device) {
      case ScreenType.tablet:

        orderSummaryFontSize = Dimens.fontSize24;
        totalDiscountFOntSize = Dimens.fontSize19;

      default:
        break;
    }
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Dimens.size2.heightBox,
          Flexible(
            child: CustomTextLabelWidget(
              textDirection: TextDirection.ltr,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              maxLines: Dimens.maxLines01,
              label: selectedUnit?.uom??"",
              style: context.textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: Dimens.fontSize10,
                height: Dimens.lineHeight10.toLineHeight(Dimens.fontSize10),
                color: MainConfig.appColors.creyColor,
              ),
            ),
          ),
          Flexible(
            child: CustomTextLabelWidget(
              textDirection: TextDirection.ltr,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              maxLines: Dimens.maxLines01,
               label: selectedUnit?.price.toString() ?? "",
              style: context.textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: Dimens.fontSize16,
                height: Dimens.lineHeight24.toLineHeight(Dimens.fontSize16),
                color: AppColors.blackColor,
              ),
            ),
          ),
          Row(
            children: <Widget>[
              if (selectedUnit?.finalPrice != null &&
                  selectedUnit!.finalPrice != selectedUnit?.price)
                CustomTextLabelWidget(
                  textDirection: TextDirection.ltr,
                  maxLines: Dimens.maxLines01,
                  overflow: TextOverflow.ellipsis,
                 label: selectedUnit?.finalPrice.toString() ??"",
                  style: context.textTheme.headlineMedium?.copyWith(
                    fontSize: orderSummaryFontSize,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.lineThrough,
                    height:
                        Dimens.lineHeight20.toLineHeight(orderSummaryFontSize),
                    color: MainConfig.appColors.creyColor,
                  ),
                ),
              Dimens.size4.widthBox,
              if (selectedUnit?.percentOff != null && selectedUnit!.percentOff!.isNotEmpty)
                Flexible(
                  child: CustomTextLabelWidget(
                    maxLines: Dimens.maxLines01,
                    overflow: TextOverflow.ellipsis,
                    label:"${selectedUnit!.percentOff} % ${context.appString.oFFKey}",
                    style: context.textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: totalDiscountFOntSize,
                        color: MainConfig.appColors.greenColor),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
