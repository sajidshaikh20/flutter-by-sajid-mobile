import '../../../../utils/exports.dart';

/// A widget that displays a shimmer effect for loading order details.
class ShimmerOrderDetail extends StatelessWidget {
  /// Initializes the shimmer widget with a device type for responsive layout.
  const ShimmerOrderDetail({
    super.key,
    this.device = ScreenType.mobile,
  });

  /// The device type (e.g., mobile, tablet) for responsive layout.
  final ScreenType device;

  @override
  Widget build(BuildContext context) {
    const double height = Dimens.space10;
    const double widthMobTab16_32 = Dimens.size16;
    SizedBox widthBoxMobTab20_40 = Dimens.size20.widthBox;
    SizedBox heightBoxMobTab8_16 = Dimens.size8.heightBox;
    SizedBox heightBoxMobTab4_8 = Dimens.size4.heightBox;
    SizedBox heightBoxMobTab12_24 = Dimens.size12.heightBox;
    SizedBox heightBoxMobTab15_30 = Dimens.size15.heightBox;

    const double widthMobTab14_28 = Dimens.size14;
    const double bottomPadding = Dimens.space8;
    const double topPadding = Dimens.space4;
    const double width = Dimens.size50;
    const double widthMobTab100_200 = Dimens.size100;
    const double widthMobTab80_160 = Dimens.size80;
    SizedBox widthBoxMobTab8_16 = Dimens.size8.widthBox;
    SizedBox widthBoxMobTab12_24 = Dimens.size12.widthBox;

    deviceDimens(
      height,
      widthMobTab16_32,
      widthBoxMobTab20_40,
      heightBoxMobTab8_16,
      heightBoxMobTab4_8,
      heightBoxMobTab12_24,
      heightBoxMobTab15_30,
      widthMobTab14_28,
      bottomPadding,
      topPadding,
      width,
      widthMobTab100_200,
      widthMobTab80_160,
      widthBoxMobTab8_16,
      widthBoxMobTab12_24,
    );

    return ShimmerEffect(
      child: Padding(
        padding: height.padding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CommonContainer(
                padding: const EdgeInsets.only(
                  left: height,
                  right: height,
                  bottom: bottomPadding,
                  top: topPadding,
                ),
                boxDecoration: BoxDecorationExtension.customDecoration(
                  // color: MainConfig.appColors.backgroundExtraLightBlueColor,
                  borderRadius: Dimens.radius5.borderRadius,
                  border: Dimens.borderWidth1.borderAll(
                    color: MainConfig.appColors.borderLightWhiteColor,
                  ),
                ),
                childWidgets: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          CommonContainer(
                            margin: const EdgeInsets.symmetric(
                              vertical: height,
                            ),
                            height: height,
                            width: width,
                            backgroundColor:
                                MainConfig.appColors.backgroundWhiteColor,
                          ),
                          Dimens.size3.heightBox,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const ShimmerSubOrderDetailWidget(
                                height: height,
                                width: widthMobTab16_32,
                              ),
                              widthBoxMobTab20_40,
                              const ShimmerSubOrderDetailWidget(
                                height: height,
                                width: widthMobTab14_28,
                              ),
                            ],
                          ),
                          heightBoxMobTab8_16,
                          CustomDivider(
                            height: Dimens.size1,
                            color:
                                MainConfig.appColors.dividerWhiteOfWhisperColor,
                          ),
                          heightBoxMobTab4_8,
                           Row(
                            children: <Widget>[
                              Flexible(
                                child: CommonContainer(
                                  height: height,
                                  backgroundColor:
                                      MainConfig.appColors.backgroundWhiteColor,
                                ),
                              ),
                              const Spacer(),
                              Expanded(
                                child: CommonContainer(
                                  height: height,
                                  backgroundColor:
                                      MainConfig.appColors.backgroundWhiteColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    height.widthBox,
                    const Padding(
                      padding: EdgeInsets.only(top: bottomPadding),
                      child: ShimmerCommonContainer(
                        height: widthMobTab80_160,
                        width: widthMobTab80_160,
                      ),
                    ),
                  ],
                ),
              ),
              heightBoxMobTab12_24,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const ShimmerCommonContainer(
                    height: height,
                    width: Dimens.size70,
                  ),
                  heightBoxMobTab15_30,
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) => Container(
                      margin: const EdgeInsets.only(
                        bottom: height,
                      ),
                      padding: Dimens.space12.padding,
                      decoration: BoxDecorationExtension.customDecoration(
                        borderRadius: Dimens.radius5.borderRadius,
                        border: Dimens.borderWidth1.borderAll(
                          color: MainConfig.appColors.borderLightWhiteColor,
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const ShimmerCommonContainer(
                                height: widthMobTab80_160,
                                width: widthMobTab80_160,
                              ),
                              widthBoxMobTab8_16,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          const ShimmerCommonContainer(
                                            height: height,
                                            width: widthMobTab100_200,
                                          ),
                                          Dimens.size10.heightBox,
                                          const ShimmerCommonContainer(
                                            height: height,
                                            width: widthMobTab80_160,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Dimens.size8.heightBox,
                                    Row(
                                      children: <Widget>[
                                        const ShimmerCommonContainer(
                                          height: height,
                                          width: width,
                                        ),
                                        widthBoxMobTab12_24,
                                        const ShimmerCommonContainer(
                                          height: height,
                                          width: width,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Dimens.size8.heightBox,
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: height,
                                ),
                                child: ShimmerCommonContainer(
                                  height: height,
                                  width: Dimens.size60,
                                ),
                              ),
                              Spacer(),
                              ShimmerCommonContainer(
                                height: height,
                                width: Dimens.size60,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    itemCount: Dimens.itemCount5,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///dimens for the tablet
  void deviceDimens(
    double height,
    double widthMobTab16_32,
    SizedBox widthBoxMobTab20_40,
    SizedBox heightBoxMobTab8_16,
    SizedBox heightBoxMobTab4_8,
    SizedBox heightBoxMobTab12_24,
    SizedBox heightBoxMobTab15_30,
    double widthMobTab14_28,
    double bottomPadding,
    double topPadding,
    double width,
    double widthMobTab100_200,
    double widthMobTab80_160,
    SizedBox widthBoxMobTab8_16,
    SizedBox widthBoxMobTab12_24,
  ) {
    switch (device) {
      case ScreenType.tablet:
        height = Dimens.space32;
        bottomPadding = Dimens.space16;
        topPadding = Dimens.space8;
        width = Dimens.size100;
        widthMobTab100_200 = Dimens.size200;
        widthMobTab80_160 = Dimens.size160;
        widthMobTab16_32 = Dimens.size32;
        widthMobTab14_28 = Dimens.size28;
        widthBoxMobTab20_40 = Dimens.size40.widthBox;
        heightBoxMobTab8_16 = Dimens.size16.heightBox;
        heightBoxMobTab4_8 = Dimens.size8.heightBox;
        heightBoxMobTab15_30 = Dimens.size30.heightBox;
        heightBoxMobTab12_24 = Dimens.size24.heightBox;
        widthBoxMobTab8_16 = Dimens.size16.widthBox;
        widthBoxMobTab12_24 = Dimens.size24.widthBox;

      case ScreenType.mobile:
      case ScreenType.desktop:
    }
  }
}
