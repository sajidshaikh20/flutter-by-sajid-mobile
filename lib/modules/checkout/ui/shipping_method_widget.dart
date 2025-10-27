import '../../../utils/exports.dart';

/// A widget that displays the shipping method selection for checkout.
/// This widget adjusts its layout based on the device type
/// (mobile, tablet, or desktop)
class ShippingMethodWidget extends StatelessWidget {
  /// Creates a [ShippingMethodWidget].
  ///
  /// The [state] parameter holds the current state of the checkout process,
  /// which includes the available shipping methods and the selected shipping
  /// method.
  /// The [device] parameter determines the layout based on the screen size:
  /// - [ScreenType.mobile] for mobile layout
  /// - [ScreenType.tablet] for tablet layout
  /// - [ScreenType.desktop] for desktop layout
  const ShippingMethodWidget({
    required this.state,
    super.key,
    this.device = ScreenType.mobile,
  });

  /// The current state of the checkout process.
  ///
  /// This state contains the available
  /// shipping methods and any other relevant
  /// checkout data, such as selected shipping methods.
  final CheckOutState state;

  /// The device type (mobile, tablet, or desktop) to determine the layout.
  ///
  /// This variable allows the widget to
  /// adjust its layout and behavior according to
  /// the screen size or type of device.
  final ScreenType device;

  @override
  Widget build(BuildContext context) {
    double horizontalPaddingMobTab8_20 = Dimens.space8;
    double spaceMobTab9_20 = Dimens.space9;
    double shippingMethodFontSize = Dimens.fontSize17;
    double radioBtnTextSize = Dimens.fontSize14;
    switch (device) {
      case ScreenType.tablet:
        horizontalPaddingMobTab8_20 = Dimens.space20;
        spaceMobTab9_20 = Dimens.space20;
        shippingMethodFontSize = Dimens.fontSize22;
        radioBtnTextSize = Dimens.fontSize18;

      case ScreenType.desktop:
      case ScreenType.mobile:
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Visibility(
          visible: state.shippingMethodsList.isNotEmpty,
          replacement: (state.startShowingShimmer ?? false)
              ? ShimmerEffect(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: Dimens.space9,
                      right: Dimens.space9,
                      top: Dimens.space10,
                    ),
                    child: CommonContainer(
                      padding: EdgeInsets.zero,
                      height: Dimens.size25,
                      width: Dimens.space140,
                      backgroundColor: MainConfig.appColors.backgroundWhiteColor,
                    ),
                  ),
                )
              : const SizedBox(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: spaceMobTab9_20),
            child: CustomTextLabelWidget(
              label: MainConfig.dynamicString(
                JsonServiceString.keyShippingMethod,
              ),
              textAlign: TextAlign.start,
              style: context.textTheme.titleMedium?.copyWith(
                fontSize: shippingMethodFontSize,
                color: MainConfig.appColors.textDarkBlackColor,
              ),
            ),
          ),
        ),
        Visibility(
          visible: state.shippingMethodsList.isNotEmpty,
          replacement: (state.startShowingShimmer ?? false)
              ? ShimmerEffect(
                  child: spaceMobTab9_20.heightBox,
                )
              : const SizedBox(),
          child: Dimens.size7.heightBox,
        ),
        Visibility(
          visible: state.shippingMethodsList.isNotEmpty,
          replacement: (state.startShowingShimmer ?? false)
              ? ShimmerEffect(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimens.space12),
                    child: CommonContainer(
                      padding: EdgeInsets.zero,
                      height: Dimens.size25,
                      width: double.maxFinite,
                      backgroundColor: MainConfig.appColors.backgroundWhiteColor,
                    ),
                  ),
                )
              : const SizedBox(),
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: horizontalPaddingMobTab8_20),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: state.shippingMethodsList.length,
              itemBuilder: (
                BuildContext context,
                int index,
              ) =>
                  CustomRadioButtonWidget(
                device: device,
                isDense: true,
                borderColor: MainConfig.appColors.dukkanborderGreyLightColor,
                label:
                    "${state.shippingMethodsList[index].method?.first.label
                        ?? ''}"
                    " ${state.shippingMethodsList[index].method?.first.price
                        ?? ''}",
                value: index,
                labelStyle: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: radioBtnTextSize,
                  color: MainConfig.appColors.textDarkBlackColor,
                ),
                onChange: (void value) {
                  context.instance<CheckOutCubit>().selectShippingMethod(index);
                },

                groupValue:
                    (state.shippingMethodsList[index].isSelected ?? false)
                        ? index
                        : -1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
