import '../../../../utils/exports.dart';

/// A widget that displays a shimmer effect placeholder for a list of addresses.
///
/// Typically used while address data is loading to indicate content is being fetched.
/// The layout and styling can adapt based on the [device] type.
class ShimmerAddressWidget extends StatelessWidget {
  /// Creates a [ShimmerAddressWidget].
  ///
  /// The [device] parameter allows adjusting the layout/styling based on the device type,
  /// defaulting to [ScreenType.mobile].
  const ShimmerAddressWidget({
    super.key,
    this.device = ScreenType.mobile,
  });

  /// The type of device layout to adapt the widget's appearance.
  final ScreenType device;
  @override
  Widget build(BuildContext context) {
    double horizontalPadding=Dimens.space16;
    double commonContainerHeight=Dimens.size50;
    double heightMobTab16_26=Dimens.size16;
    double simmerCommonContainerHeight=Dimens.size10;
    double simmerCommonContainerWidth=Dimens.size50;
  double heightMobTab6_10=  Dimens.size6;
    switch(device){

      case ScreenType.tablet:
        horizontalPadding=Dimens.space32;
        commonContainerHeight=Dimens.size65;
        heightMobTab16_26=Dimens.size26;
         simmerCommonContainerHeight=Dimens.size15;
         simmerCommonContainerWidth=Dimens.size65;
        heightMobTab6_10=  Dimens.size10;

      default:
        break;
    }
    
    return ShimmerEffect(
      child: ListView(
        children: <Widget>[
          Dimens.size15.heightBox,
          //Add Address Button
          CommonContainer(
            width: context.width,
            height: commonContainerHeight,
            margin:  EdgeInsets.symmetric(horizontal: horizontalPadding),
            padding: const EdgeInsets.symmetric(
                vertical: Dimens.space10, horizontal: Dimens.space6),
            boxDecoration: BoxDecorationExtension.customDecoration(
              borderRadius: Dimens.radius6.borderRadius,
              boxShadow:  <BoxShadow>[
                BoxShadow(
                  color: MainConfig.appColors.shadowBlackColor,
                  blurRadius: Dimens.radius6,
                )
              ],
              color: MainConfig.appColors.backgroundWhiteColor,
            ),
            childWidgets:  ShimmerCommonContainer(
              height: simmerCommonContainerHeight,
              width: simmerCommonContainerWidth,
            ),
          ),
          heightMobTab16_26.heightBox,
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //Shipping Address
                 ShimmerCommonAddressView(device: device,),

                //Billing Address
                 ShimmerCommonAddressView(device: device,),

                // List of my address
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                     ShimmerCommonContainer(
                      height: simmerCommonContainerHeight,
                      width: simmerCommonContainerWidth,
                    ),
                    heightMobTab6_10.heightBox,
                    ListView.builder(
                        itemCount: Dimens.itemCount5,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) =>
                             ShimmerAddressListItemView(device: device,)),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
