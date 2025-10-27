import '../../../../utils/exports.dart';

/// A widget that displays a summary of order details, including subtotal,
/// shipping, tax, and grand total. It can be used in both order detail
/// and cart screens.
///
/// ## Usage Examples:
///
/// ### For Order Details (existing usage):
/// ```dart
/// OrderDetailSummaryView(
///   isFromCartScreen: false,
///   onItemTap: () {},
///   totalOrderSummaryModel: TotalsData(...),
///   totalDiscountString: "You saved KD 10.00",
///   device: ScreenType.mobile,
/// )
/// ```
///
/// ### For Cart Details (new usage):
/// ```dart
/// OrderDetailSummaryView.cartDetails(
///   isFromCartScreen: true,
///   onItemTap: () {},
///   cartDetailsModel: CartDetailsListingResponseModel(
///     subTotal: 100.0,
///     deliveryCharge: 5.0,
///     loyaltyPointsApplied: 10.0,
///     walletApplied: 5.0,
///     couponCodeApplied: 15.0,
///     finalTotal: 75.0,
///     totalSaved: 30.0,
///   ),
///   device: ScreenType.mobile,
/// )
/// ```
class OrderDetailSummaryView extends StatelessWidget {
  /// Creates an [OrderDetailSummaryView] widget.
  ///
  /// [onItemTap] is a callback function that is called when the user taps on
  /// the summary. [orderSummary] contains the data for the order summary.
  /// [totalDiscountString] is the discount that can be applied, and
  /// [isFromCartScreen] is a flag to differentiate between the order detail and
  /// cart screen. [device] specifies the screen type, which affects the
  /// layout.
  const OrderDetailSummaryView({
    super.key,
    required this.onItemTap,
    required this.totalDiscountString,
    required this.isFromCartScreen,
    this.device = ScreenType.mobile, 
    this.cartDetailsModel,
    this.orderSummary,
  });

  /// Creates an [OrderDetailSummaryView] widget for cart details.
  ///
  /// [onItemTap] is a callback function that is called when the user taps on
  /// the summary. [cartDetailsModel] contains the cart summary data.
  /// [isFromCartScreen] is a flag to differentiate between the order detail and
  /// cart screen. [device] specifies the screen type, which affects the
  /// layout.


  /// Callback function to be executed when an item is tapped.
  final Function() onItemTap;

  /// Data model containing the totals for the order summary.

  /// Data model containing the cart details for the summary.
  final CartDetailsListingResponseModel? cartDetailsModel;

  /// Data model containing the order summary for the summary.
  final OrderSummary? orderSummary;

  /// String representing the total discount.
  final String totalDiscountString;

  /// Flag indicating whether the summary is displayed on the cart screen.
  final bool isFromCartScreen;

  /// The type of device screen (e.g., mobile, tablet).
  final ScreenType device;


  @override
  Widget build(BuildContext context) {
    double fontSizeMobTab16_25 = Dimens.fontSize16;
    double height = Dimens.space8;
    double bottomPadding = Dimens.space16;
    double grandTotalFontSize = Dimens.fontSize16;

    return InkWell(
      splashFactory: NoSplash.splashFactory,
      splashColor: MainConfig.appColors.transparent,
      highlightColor: MainConfig.appColors.transparent,
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      onTap: () {
        onItemTap.call();
      },
      child: Container(
        width: double.infinity,
        padding: isFromCartScreen
            ? EdgeInsets.symmetric(horizontal: bottomPadding)
            : height.padding,
        decoration: isFromCartScreen
            ? null
            : BoxDecorationExtension.customDecoration(
                borderRadius: Dimens.radius8.borderRadius,
                border: Border.all(
                    color: MainConfig.appColors.lightGreyColor,
                    width: Dimens.borderWidth05)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (!isFromCartScreen)
              CustomTextLabelWidget(
                label: context.appString.orderSummaryKey,
                style: context.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: MainConfig.appColors.textBlackColor,
                  height: Dimens.lineHeight24.toLineHeight(fontSizeMobTab16_25),
                  fontSize: fontSizeMobTab16_25,
                ),
              ),
            if (!isFromCartScreen)
              Dimens.size17.heightBox,
            // Display cart details if cartDetailsModel is provided
            if (cartDetailsModel != null) ..._buildCartDetailsSummary(context,grandTotalFontSize),
            // Display order details if orderSummary is provided
            if (orderSummary != null && !isFromCartScreen) ..._buildOrderDetailsSummary(context,grandTotalFontSize),

          ],
        ),
      ),
    );
  }

  /// Builds the summary items for cart details
  List<Widget> _buildCartDetailsSummary(BuildContext context, double grandTotalFontSize,) {
    final CartDetailsListingResponseModel? cart = cartDetailsModel;
    final String currency = getIt<LanguageService>().defaultCurrency; // Using the app's currency constant
    
    return <Widget>[
      // Subtotal
      OrderDetailSummaryItemView(
        title: context.appString.subtotalKey,
        price: formatPrice(cart?.subTotal, currency),
        device: device,
      ),
      // Delivery Charge
      if (cart?.deliveryCharge != null && (cart?.deliveryCharge! ?? 0) > 0)
        OrderDetailSummaryItemView(
          title: context.appString.deliveryChargeKey,
          price: formatPrice(cart?.deliveryCharge, currency),
          device: device,
        ),
      // Loyalty Points Applied
      if (cart?.loyaltyPointsApplied != null && (cart?.loyaltyPointsApplied ?? 0) > 0)
        OrderDetailSummaryItemView(
          title: context.appString.loyaltyPointsAppliedKey,
          price: formatPrice(cart?.loyaltyPointsApplied, currency, isDiscount: true),
          device: device,
        ),
      // Wallet Applied
      if (cart?.walletApplied != null && (cart?.walletApplied! ?? 0) > 0)
        OrderDetailSummaryItemView(
          title: context.appString.walletAppliedKey,
          price: formatPrice(cart?.walletApplied, currency, isDiscount: true),
          device: device,
        ),
      // Coupon Code Applied
      if (cart?.couponCodeApplied != null && (cart?.couponCodeApplied! ?? 0) > 0)
        OrderDetailSummaryItemView(
          title: context.appString.couponDiscountAppliedKey,
          price: formatPrice(cart?.couponCodeApplied, currency, isDiscount: true),
          device: device,
        ),
      Dimens.size12.heightBox,
      // Final Total
      OrderDetailSummaryItemView(

        title: context.appString.totalKey,
        price: formatPrice(cart?.finalTotal, currency),
        titleStyle: context.textTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: grandTotalFontSize,
          height: Dimens.lineHeight24.toLineHeight(grandTotalFontSize),
          color: MainConfig.appColors.textColorGreyBlack,
        ),
        priceStyle: context.textTheme.headlineMedium?.copyWith(
          fontSize: grandTotalFontSize,
          fontWeight: FontWeight.bold,
          color: MainConfig.appColors.greyDark,
        ),
        device: device,
      ),
      // Total Saved
      if (cart?.totalSaved != null && (cart?.totalSaved! ?? 0) > 0)
        Container(
          width: double.maxFinite,
          margin: const EdgeInsets.only(top: Dimens.space7),
          padding: const EdgeInsets.only(
            top: Dimens.space12,
            bottom: Dimens.space12,
          ),
          decoration: BoxDecorationExtension.customDecoration(
            color: MainConfig.appColors.lightGreen,
            borderRadius: Dimens.radius8.borderRadius,
          ),
          child: CustomTextLabelWidget(
            label: "${context.appString.youSavedKey} ${formatPrice(cart?.totalSaved, currency)}",
            style: context.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: Dimens.fontSize14,
              color: MainConfig.appColors.darkTextGreen,
            ),
          ),
        ),
    ];
  }

  /// Builds the summary items for order details
  List<Widget> _buildOrderDetailsSummary(BuildContext context, double grandTotalFontSize) {
    final OrderSummary? order = orderSummary;

    return <Widget>[
      // Subtotal
      OrderDetailSummaryItemView(
        title: context.appString.subtotalKey,
        price: '${order?.subTotal} ${getIt<LanguageService>().defaultCurrency}',
        device: device,
      ),
      // Delivery Charge
      // if (order?.deliveryCharge != null && (order?.deliveryCharge ?? 0) > 0)
        OrderDetailSummaryItemView(
          title: context.appString.deliveryChargeKey,
          price: '${order?.deliveryCharge} ${getIt<LanguageService>().defaultCurrency}',
          device: device,
        ),
      // Loyalty Points Applied
      // if (order?.LoyalityPointsApplied != null && (order?.LoyalityPointsApplied?.isNotEmpty ?? false))
      //   OrderDetailSummaryItemView(
      //     title: context.appString.loyaltyPointsAppliedKey,
      //     price: order?.LoyalityPointsApplied ?? '',
      //     device: device,
      //   ),
      // Wallet Applied
      // if (order?.walletApplied != null && (order?.walletApplied?.isNotEmpty ?? false))
        OrderDetailSummaryItemView(
          title: context.appString.walletAppliedKey,
          price: order?.walletApplied ?? '',
          device: device,
        ),
      // Coupon Code Applied
      // if (order?.couponCodeApplied != null && (order?.couponCodeApplied?.isNotEmpty ?? false))
        OrderDetailSummaryItemView(
          title: context.appString.couponDiscountKey,
          price: order?.couponCodeApplied ?? '',
          device: device,
        ),
      Dimens.size12.heightBox,
      // Final Total
      OrderDetailSummaryItemView(
        title: context.appString.totalKey,
        price:  '${order?.finalTotal} ${getIt<LanguageService>().defaultCurrency}',
        titleStyle: context.textTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: grandTotalFontSize,
          height: Dimens.lineHeight24.toLineHeight(grandTotalFontSize),
          color: MainConfig.appColors.textColorGreyBlack,
        ),
        priceStyle: context.textTheme.headlineMedium?.copyWith(
          fontSize: grandTotalFontSize,
          fontWeight: FontWeight.bold,
          color: MainConfig.appColors.greyDark,
        ),
        device: device,
      ),
      // Total Saved
      if (order?.totalSaved != null && (order?.totalSaved?.isNotEmpty ?? false))
        Container(
          width: double.maxFinite,
          margin: const EdgeInsets.only(top: Dimens.space7),
          padding: const EdgeInsets.only(
            top: Dimens.space12,
            bottom: Dimens.space12,
          ),
          decoration: BoxDecorationExtension.customDecoration(
            color: MainConfig.appColors.lightGreen,
            borderRadius: Dimens.radius8.borderRadius,
          ),
          child: CustomTextLabelWidget(
            label: "${context.appString.youSavedKey} ${order?.totalSaved ?? ''}",
            style: context.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: Dimens.fontSize14,
              color: MainConfig.appColors.darkTextGreen,
            ),
          ),
        ),
    ];
  }

}
