import '../../../utils/exports.dart';

/// A widget that displays the payment type selection screen.
/// This widget adjusts its layout based on the device type
/// (mobile, tablet, or desktop).
class PaymentTypePage extends StatelessWidget {
  /// Creates a [PaymentTypePage].
  ///
  /// The [paymentMethods] parameter is a list of available payment
  /// methods to be displayed.
  /// The [onChangeValueCallback] is a callback function that is
  /// invoked when the user selects a payment method.
  /// The [device] parameter determines the layout based on the screen size:
  /// - [ScreenType.mobile] for mobile layout
  /// - [ScreenType.tablet] for tablet layout
  /// - [ScreenType.desktop] for desktop layout
  const PaymentTypePage({
    required this.paymentMethods,
    required this.onChangeValueCallback,
    super.key,
    this.device = ScreenType.mobile,
  });

  /// The device type (mobile, tablet, or desktop) to determine the layout.
  ///
  /// This variable allows the widget to adjust
  /// its layout and behavior according to
  /// the screen size or type of device.
  final ScreenType device;

  /// A list of available payment methods to be displayed on the page.
  ///
  /// This list can include different payment methods
  /// such as credit cards, PayPal, etc.
  final List<PaymentMethodResponse>? paymentMethods;

  /// A callback function invoked when a payment method is selected.
  ///
  /// The function receives the index of the selected
  /// payment method in the [paymentMethods] list.
  final Function(int index) onChangeValueCallback;

  @override
  Widget build(BuildContext context) {
    double spaceMobtab1020 = Dimens.space10;
    double padding = Dimens.space12;
    double space_8 = Dimens.space8;
    double spaceMobtab1324 = Dimens.space13;
    double heightMobtab2428 = Dimens.size24;
    double heightboxMobtab3060 = Dimens.size30;
    double widthMobtab2040 = Dimens.size20;
    double widthMobtab3060 = Dimens.size30;

    switch (device) {
      case ScreenType.tablet:
        space_8 = Dimens.space12;
        spaceMobtab1020 = Dimens.space20;
        widthMobtab2040 = Dimens.size40;
        widthMobtab3060 = Dimens.size60;
        heightboxMobtab3060 = Dimens.size60;
        padding = Dimens.space22;
        spaceMobtab1324 = Dimens.space18;
        heightMobtab2428 = Dimens.size28;

      case ScreenType.mobile:
      case ScreenType.desktop:
    }

    return Visibility(
      visible: paymentMethods?.isNotEmpty ?? false,
      replacement: ShimmerEffect(
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) => Column(
            children: <Widget>[
              CommonContainer(
                padding: EdgeInsets.zero,
                height: widthMobtab3060,
                width: double.maxFinite,
                backgroundColor: MainConfig.appColors.backgroundWhiteColor,
              ),
              widthMobtab2040.heightBox,
            ],
          ),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: Dimens.maxLines03,
        ),
      ),
      child: ListView.builder(
        itemCount: paymentMethods?.length ?? Dimens.digit0,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) => InkWell(
          splashFactory: NoSplash.splashFactory,
          splashColor: MainConfig.appColors.transparent,
          highlightColor: MainConfig.appColors.transparent,
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          onTap: () {
            onChangeValueCallback.call(index);
          },
          child: CommonContainer(
            padding: EdgeInsets.zero,
            margin: EdgeInsets.only(bottom: space_8),
            boxDecoration: BoxDecorationExtension.customDecoration(
              color: MainConfig.appColors.backgroundWhiteColor,
              borderRadius: Dimens.space5.borderRadius,
              border: Dimens.borderWidth1.borderAll(
                color: MainConfig.appColors.dukkanborderGreyLightColor,
              ),
            ),
            childWidgets: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: padding,
                vertical: spaceMobtab1324,
              ),
              child: Row(
                children: <Widget>[
                  Radio<int>(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: const VisualDensity(
                      horizontal: VisualDensity.minimumDensity,
                      vertical: VisualDensity.minimumDensity,
                    ),
                    fillColor: WidgetStateProperty.resolveWith(
                        (Set<WidgetState> states) {
                      if (states.contains(WidgetState.selected)) {
                        return MainConfig.appColors.radioFillDarkBlackColor;
                      }
                      return MainConfig.appColors.radioFillBlack;
                    }),
                    value: index,
                    groupValue: -1,
                    onChanged: (int? value) {
                      onChangeValueCallback.call(value ?? Dimens.digit0);
                    },
                  ),
                  Dimens.space11.widthBox,
                  SizedBox(
                    height: heightMobtab2428,
                    width: heightboxMobtab3060,
                    child: CustomNetworkImageWidget(
                      imageUrl:  '',
                      fit: BoxFit.scaleDown,
                      placeHolderImage: Assets.svgs.icPlaceHolderDukkan.svg(),
                    ),
                  ),
                  spaceMobtab1020.widthBox,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
