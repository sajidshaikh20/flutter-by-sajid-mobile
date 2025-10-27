
import '../../../../utils/exports.dart';

/// Widget that displays the middle section of an order item with product image and details.
class MyOrderMiddleView extends StatelessWidget {
  /// Creates a my order middle view.
  const MyOrderMiddleView({super.key,
    this.isPastOrder=false,
    required this.thumbUrl,
    required this.noOfItems,
    required this.orderFinalAmount,
    required this.orderId, });

  /// Whether this is a past order.
  final bool isPastOrder;

  /// The thumbnail URL of the product image.
  final String? thumbUrl;

  /// The order ID.
  final String? orderId;

  /// The number of items in the order.
  final String? noOfItems;

  /// The final amount of the order.
  final String? orderFinalAmount;


  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          height: Dimens.size42,
          width: Dimens.size42,
          decoration: BoxDecorationExtension.customDecoration(
            color: MainConfig.appColors.backgroundWhite, // Background color
          ),
          child:
          FastCachedCustomNetwork(
            imageUrl: thumbUrl ?? "",
            fit: BoxFit.fill,
            placeHolderImage: Assets.svgs.icPlaceHolderDukkan.svg(),
            isShowPlaceHolder: true,
          ),

          // Assets.png.icProductDetails.image(),
        ),
        const SizedBox(
          width: Dimens.size12,
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: keyValueText(
                        context: context,
                        label: context.appString.orderIDKey),
                  ),
                  SizedBox(
                      width: Dimens.size70,
                      child: keyValueText(
                          context: context,
                          label: context.appString.noOfItemsKey)),
                  Expanded(
                    child: keyValueText(
                        context: context,
                        label: context.appString.totalAmountKey,
                        isStart: false),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: keyValueText(
                        context: context,
                        label: orderId ?? '',
                        style: context.textTheme.displayMedium
                            ?.copyWith(
                            color: MainConfig.appColors.textBlackColor,
                            fontWeight: FontWeight.w600,
                            fontSize: Dimens.fontSize14,
                            height: Dimens.lineHeight18
                                .toLineHeight(Dimens.fontSize14))),
                  ),
                  SizedBox(
                    width: Dimens.size70,
                    child: keyValueText(
                        context: context,
                        label: noOfItems ?? '0',
                        style: context.textTheme.displayMedium
                            ?.copyWith(
                            color: MainConfig.appColors.textBlackColor,
                            fontWeight: FontWeight.w600,
                            fontSize: Dimens.fontSize14,
                            height: Dimens.lineHeight18
                                .toLineHeight(Dimens.fontSize14))),
                  ),
                  Expanded(
                    child: keyValueText(
                      textDirection: TextDirection.ltr,
                        context: context,
                        label:  orderFinalAmount ?? '',
                        isStart: !context.isEnglishLanguage,
                        style: context.textTheme.displayMedium
                            ?.copyWith(

                            color: MainConfig.appColors.textBlackColor,
                            fontWeight: FontWeight.bold,
                            fontSize: Dimens.fontSize14,
                            height: Dimens.lineHeight18
                                .toLineHeight(Dimens.fontSize14))),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
/// Creates a text widget with configurable alignment and styling.
Widget keyValueText(
    {required BuildContext context,
      required String label,
      TextStyle? style,
       TextDirection? textDirection,
      bool isStart = true}) {
  return CustomTextLabelWidget(
    textDirection:textDirection,
    textAlign: isStart ? TextAlign.start : TextAlign.end,
    label: label,
    style: style ??
        context.textTheme.displayMedium?.copyWith(
            color: MainConfig.appColors.creyColor,
            fontWeight: FontWeight.w500,
            fontSize: Dimens.fontSize10,
            height: Dimens.lineHeight12.toLineHeight(Dimens.fontSize10)),
  );
}
