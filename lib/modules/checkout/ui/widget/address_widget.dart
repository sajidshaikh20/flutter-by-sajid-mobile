import '../../../../utils/exports.dart';

/// A widget that displays the address section in the checkout screen.
/// It shows a shimmer effect when the address data is loading and displays
/// the selected address once available.
class AddressWidget extends StatelessWidget {
  /// Constructor for creating an `AddressWidget` widget.
  /// [device] determines the screen type (mobile, tablet, desktop).
  const AddressWidget({
    super.key,
    this.device = ScreenType.mobile,
  });

  /// The type of screen for adjusting the layout. Defaults to mobile.
  final ScreenType device;

  @override
  Widget build(BuildContext context) {
    EdgeInsetsGeometry outerMargin = Dimens.space10.padding;
    double heightMobTab10_16 = Dimens.size10;

    switch (device) {
      case ScreenType.tablet:
        heightMobTab10_16 = Dimens.size16;
        outerMargin = Dimens.space20.padding;
      case ScreenType.mobile:
      case ScreenType.desktop:
        break;
    }

    return BlocBuilder<CheckOutCubit, CheckOutState>(
      builder: (BuildContext context, CheckOutState state) => Visibility(
        visible:
            state.addressShimmer == false && state.startShowingShimmer == false,
        replacement: AddressShimmerShimmer(
          device: device,
        ),
        child: Container(
          margin: outerMargin,
          child: Column(
            children: <Widget>[
              // Decorated box for the address container
              DecoratedBox(
                decoration: BoxDecorationExtension.customDecoration(
                  borderRadius: state.selectedAddress == null
                      ? Dimens.radius8.borderRadius
                      : Dimens.radius8.borderRadiusTopLeftTopRight,
                  border: Border.all(
                    color: MainConfig.appColors.dukkanborderGreyLightColor,
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    heightMobTab10_16.heightBox,
                    AddressSubWidget(
                      state: state,
                      device: device,
                    ),
                    heightMobTab10_16.heightBox,
                  ],
                ),
              ),
              // Second decorated box to show selected address
              DecoratedBox(
                decoration: state.selectedAddress == null
                    ? const BoxDecoration()
                    : BoxDecorationExtension.customDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(Dimens.radius10),
                          bottomRight: Radius.circular(Dimens.radius10),
                        ),
                        border:  Border(
                          left: BorderSide(
                            color: MainConfig.appColors.borderLightGreyColor,
                          ),
                          right: BorderSide(
                            color: MainConfig.appColors.borderLightGreyColor,
                          ),
                          bottom: BorderSide(
                            color: MainConfig.appColors.borderLightGreyColor,
                          ),
                        ),
                      ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: Dimens.space10,
                    left: Dimens.space10,
                    right: Dimens.space10,
                  ),
                  child: Visibility(
                    visible: state.selectedAddress != null,
                    replacement: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: Dimens.space10),
                        child: CustomTextLabelWidget(
                          label: MainConfig.dynamicString(
                            JsonServiceString.keyNoDataAvailable,
                          ),
                          style: context.textTheme.headlineSmall?.copyWith(
                            color: MainConfig.appColors.textLabelGreyColor,
                            fontSize: Dimens.fontSize18,
                          ),
                        ),
                      ),
                    ),
                    child: AddressListItemView(
                      device: device,
                      addressModel: state.selectedAddress ?? BillingAddress(),
                      isForCheckOut: true,
                      isForList: false,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // Determines when to rebuild the widget based on changes in shimmer state
      buildWhen: (CheckOutState previous, CheckOutState current) =>
          (previous.addressShimmer != current.addressShimmer) ||
          (previous.startShowingShimmer != current.startShowingShimmer),
    );
  }
}
