import '../../../../utils/exports.dart';

/// A widget that displays the discount and loyalty points section
/// within the cart page.
///
/// This widget can be used to show any available discounts, coupons,
/// or loyalty point rewards that apply to the current cart items.
class DiscountLoyaltyCartWidget extends StatelessWidget {
  /// Creates a [DiscountLoyaltyCartWidget] instance.
  const DiscountLoyaltyCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Dimens.size8.heightBox,
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Dimens.space8,
          ),
          child: CartDiscountTextField(),
        ),
        // Padding(
        //   padding: const EdgeInsets.only(
        //       left: Dimens.space8, right: Dimens.space18, top: Dimens.space19),
        //   child: Row(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: <Widget>[
        //       CustomCheckbox(
        //         isChecked: true,
        //         onChanged: (bool value) {},
        //       ),
        //       const SizedBox(width: Dimens.space8),
        //       // Add spacing between checkbox and text
        //       Expanded(
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: <Widget>[
        //             CustomTextLabelWidget(
        //               label: context.appString.loyaltyPointsKey,
        //               style: context.textTheme.headlineMedium?.copyWith(
        //                 fontWeight: FontWeight.w700,
        //                 color: MainConfig.appColors.textBlackColor,
        //                 height:
        //                     Dimens.lineHeight16.toLineHeight(Dimens.fontSize14),
        //                 fontSize: Dimens.fontSize14,
        //               ),
        //             ),
        //             const SizedBox(height: Dimens.size4),
        //             // Add spacing between title and text
        //             RichText(
        //               text: TextSpan(
        //                 text: '${context.appString.redeemPointsMessageKey} ', // Regular text
        //                 style: context.textTheme.headlineMedium?.copyWith(
        //                   fontWeight: FontWeight.w400,
        //                   color: MainConfig.appColors.textBlackColor,
        //                   height: Dimens.lineHeight18
        //                       .toLineHeight(Dimens.fontSize14),
        //                   fontSize: Dimens.fontSize14,
        //                 ),
        //                 children: <InlineSpan>[
        //                   TextSpan(
        //                     text: AppConstant.dummyProductPrice3, // Text to make bold
        //                     style: context.textTheme.headlineMedium?.copyWith(
        //                       fontWeight: FontWeight.bold,
        //                       color: MainConfig.appColors.textBlackColor,
        //                       height: Dimens.lineHeight18
        //                           .toLineHeight(Dimens.fontSize14),
        //                       fontSize: Dimens.fontSize14,
        //                     ),
        //                   ),
        //                   TextSpan(
        //                     text: ' ${context.appString.discountOnOrderTotalKey}',
        //                     style: context.textTheme.headlineMedium?.copyWith(
        //                       fontWeight: FontWeight.w400,
        //                       color: MainConfig.appColors.textBlackColor,
        //                       height: Dimens.lineHeight18
        //                           .toLineHeight(Dimens.fontSize14),
        //                       fontSize: Dimens.fontSize14,
        //                     ), // Remaining regular text
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        Dimens.size8.heightBox,
        // As per discussion with shubham joshi he told me please remove this wallet section
    /*    Padding(
          padding: const EdgeInsets.only(
              left: Dimens.space8,
              right: Dimens.space18,
              top: Dimens.space13,
              bottom: Dimens.space7),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CustomCheckbox(
                isChecked: false,
                onChanged: (bool value) {},
              ),
              const SizedBox(width: Dimens.space8),
              // Add spacing between checkbox and text
              *//*Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CustomTextLabelWidget(
                      label: context.appString.walletKey,
                      style: context.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: MainConfig.appColors.textBlackColor,
                        height:
                            Dimens.lineHeight16.toLineHeight(Dimens.fontSize14),
                        fontSize: Dimens.fontSize14,
                      ),
                    ),
                    const SizedBox(height: Dimens.size4),
                    // Add spacing between title and text
                    RichText(
                      text: TextSpan(
                        text: context.appString.availableBalanceKey, // Regular text
                        style: context.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: MainConfig.appColors.textBlackColor,
                          height: Dimens.lineHeight18
                              .toLineHeight(Dimens.fontSize14),
                          fontSize: Dimens.fontSize14,
                        ),
                        children: <InlineSpan>[
                          TextSpan(
                            text: ' ${AppConstant.dummyProductPrice}', // Text to make bold
                            style: context.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: MainConfig.appColors.textBlackColor,
                              height: Dimens.lineHeight18
                                  .toLineHeight(Dimens.fontSize14),
                              fontSize: Dimens.fontSize14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),*//*
            ],
          ),
        ),*/
      ],
    );
  }
}
