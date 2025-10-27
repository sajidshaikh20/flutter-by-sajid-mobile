import '../../../../utils/exports.dart';

/// Widget that displays information about a product unit/variant.
class ProductUnitDisplayWidget extends StatelessWidget {
  /// The product variant/unit data to display.
  final ProductVariantDukkan unit;

  /// Creates a product unit display widget.
  const ProductUnitDisplayWidget({
    super.key,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: Dimens.space4),
              Visibility(
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child: Container(
                  height: Dimens.size22,
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimens.space4, vertical: Dimens.space3),
                  decoration: BoxDecorationExtension.customDecoration(
                    color: MainConfig.appColors.iceBlueColor, // Background color
                    borderRadius:
                    Dimens.radius4.borderRadius, // Rounded corners
                  ),
                  child: CustomTextLabelWidget(
                    textDirection: TextDirection.ltr,
                    maxLines: Dimens.maxLines01,
                    overflow: TextOverflow.ellipsis,
                    label: unit.uom ?? "",
                    style: context.textTheme.headlineMedium?.copyWith(
                        height: Dimens.lineHeight16.toLineHeight(Dimens.fontSize12),
                        fontSize: Dimens.fontSize12,
                        color: MainConfig.appColors.mainColor,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Dimens.space7.heightBox,
              Row(
                children: <Widget>[
                  CustomTextLabelWidget(
                    textDirection: TextDirection.ltr,
                    maxLines: Dimens.maxLines01,
                    overflow: TextOverflow.ellipsis,
                    label:'${unit.price} ${getIt<LanguageService>().defaultCurrency}',
                    style: context.textTheme.headlineMedium?.copyWith(
                        height:
                        Dimens.lineHeight24.toLineHeight(Dimens.fontSize14),
                        fontSize: Dimens.fontSize16,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.bold),
                  ),
                  Dimens.size4.widthBox,
                  if (unit.finalPrice != null &&
                      unit.finalPrice! > 0 &&
                      unit.finalPrice != unit.price)
                    CustomTextLabelWidget(
                    textDirection: TextDirection.ltr,
                    maxLines: Dimens.maxLines01,
                    overflow: TextOverflow.ellipsis,
                      label: '${unit.finalPrice} ${getIt<LanguageService>().defaultCurrency}',
                    style: context.textTheme.headlineMedium?.copyWith(
                      height: Dimens.lineHeight20.toLineHeight(Dimens.fontSize14),
                      fontSize: Dimens.fontSize14,
                      decoration: TextDecoration.lineThrough,
                      color: MainConfig.appColors.creyColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (unit.percentOff != null && unit.percentOff!.isNotEmpty)...<Widget>[
                    const SizedBox(width: Dimens.space3),
                    CustomTextLabelWidget(
                      maxLines: Dimens.maxLines01,
                      overflow: TextOverflow.ellipsis,
                      label: '${unit.percentOff} % ${context.appString.oFFKey}',
                      style: context.textTheme.headlineMedium?.copyWith(
                          height: Dimens.lineHeight14
                              .toLineHeight(Dimens.fontSize12),
                          fontSize: Dimens.fontSize12,
                          color: MainConfig.appColors.greenColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ]
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
