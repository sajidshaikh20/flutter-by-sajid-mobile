import '../../../../utils/exports.dart';

/// A widget that displays a shimmer effect placeholder for an address list item.
///
/// Typically used while the address data is loading to indicate content is being fetched.
/// The layout can adapt based on the [device] type.
class ShimmerAddressListItemView extends StatelessWidget {
  /// Creates a [ShimmerAddressListItemView] widget.
  ///
  /// The [device] parameter allows adjusting the layout/styling based on the device type,
  /// defaulting to [ScreenType.mobile].
  const ShimmerAddressListItemView({
    super.key,
    this.device = ScreenType.mobile,
  });

  /// The type of device layout to adapt the widget's appearance.
  final ScreenType device;
  @override
  Widget build(BuildContext context) {
    double sizeMobTab14_22=Dimens.size14;
    double sizeMobTab10_15= Dimens.size10;
    double sizeMobTab50_65= Dimens.size50;
    double sizeMobTab100_130= Dimens.size100;
    double sizeMobTab80_100=  Dimens.size80;
    double sizeMobTab60_75=   Dimens.size60;
    double sizeMobTab40_50=   Dimens.size40;
    double sizeMobTab20_30= Dimens.size20;
    double sizeMobTab6_10= Dimens.size6;
    double sizeMobTab5_8= Dimens.size5;
    double sizeMobTab8_12= Dimens.size8;
    double sizeMobTab2_4= Dimens.size2;
    switch(device){

      case ScreenType.tablet:
        sizeMobTab14_22=Dimens.size22;
        sizeMobTab10_15= Dimens.size15;
        sizeMobTab50_65= Dimens.size65;
        sizeMobTab100_130= Dimens.size130;
        sizeMobTab80_100=  Dimens.size100;
        sizeMobTab60_75=   Dimens.size75;
        sizeMobTab40_50=   Dimens.size50;
        sizeMobTab20_30= Dimens.size30;
        sizeMobTab6_10= Dimens.size10;
        sizeMobTab5_8= Dimens.size8;
        sizeMobTab8_12= Dimens.size12;
        sizeMobTab2_4= Dimens.size4;

      default:
        break;
    }
    
    return CommonContainer(
      margin:  EdgeInsets.only(bottom: sizeMobTab10_15),
      padding:  EdgeInsets.only(
        bottom: sizeMobTab8_12,
      ),
      boxDecoration: BoxDecorationExtension.customDecoration(
        borderRadius: Dimens.radius8.borderRadius,
        border: Dimens.borderWidth1
            .borderAll(color: MainConfig.appColors.borderLightWhiteColor),
      ),
      childWidgets: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: sizeMobTab8_12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding:  EdgeInsets.only(top:sizeMobTab8_12),
                        child: Row(
                          children: <Widget>[
                            Padding(
                                padding:  EdgeInsets.only(right: sizeMobTab6_10),
                                child: ShimmerCommonContainer(
                                  height: sizeMobTab14_22,
                                  width: sizeMobTab14_22,
                                )),
                             ShimmerCommonContainer(
                              height: sizeMobTab10_15,
                              width: sizeMobTab50_65,
                            ),
                          ],
                        ),
                      ),
                      sizeMobTab5_8.heightBox,
                       ShimmerCommonContainer(
                        height: sizeMobTab10_15,
                        width: sizeMobTab100_130,
                      ),
                      sizeMobTab2_4.heightBox,
                       ShimmerCommonContainer(
                        height: sizeMobTab10_15,
                        width: sizeMobTab80_100,
                      ),
                      sizeMobTab2_4.heightBox,
                       ShimmerCommonContainer(
                        height: sizeMobTab10_15,
                        width: sizeMobTab60_75,
                      ),
                      sizeMobTab2_4.heightBox,
                       ShimmerCommonContainer(
                        height: sizeMobTab10_15,
                        width: sizeMobTab40_50,
                      ),
                      sizeMobTab2_4.heightBox
                    ],
                  ),
                ),
                 ShimmerCommonContainer(
                  height: sizeMobTab10_15,
                  width: sizeMobTab50_65,
                ),
                sizeMobTab20_30.widthBox,
                 ShimmerCommonContainer(
                  height: sizeMobTab10_15,
                  width:sizeMobTab50_65,
                ),
                sizeMobTab14_22.heightBox,
              ],
            ),
          ),

          // Save this address
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: sizeMobTab8_12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
               sizeMobTab10_15.heightBox,
                 Row(
                  children: <Widget>[
                    ShimmerCommonContainer(
                      height: sizeMobTab10_15,
                      width: sizeMobTab100_130,
                    ),
                    const Spacer(),
                    Expanded(
                      child: ShimmerCommonContainer(
                        height:sizeMobTab20_30,
                        width: sizeMobTab50_65,
                      ),
                    ),
                  ],
                ),
                sizeMobTab6_10.heightBox,
              ],
            ),
          )
        ],
      ),
    );
  }
}
