import '../../../utils/exports.dart';

/// Widget that displays the order cancellation interface with reason selection and comments.
class MyOrderCancelView extends StatelessWidget {
  /// Creates a my order cancel view.
  const MyOrderCancelView({super.key, this.device = ScreenType.mobile});

  /// The screen type for responsive design.
  final ScreenType device;

  @override
  Widget build(BuildContext context) {
    const EdgeInsets padding = EdgeInsets.symmetric(horizontal: Dimens.space15);
    const double cancelOrderFontSize = Dimens.fontSize16;
    const double btnSubmitFontSize = Dimens.fontSize18;
    const double cancelOrderDecsFontSize = Dimens.fontSize12;
    const double sizeMobTab10_18 = Dimens.size10;
    const double sizeMObTab18_30 = Dimens.size18;
    const double sizeMobTab24_35 = Dimens.size24;
    const double sizeMobTab22_32 = Dimens.size22;
    const double sizeMobTab30_40 = Dimens.size30;
    deviceDimens(
      sizeMobTab22_32,
      sizeMobTab30_40,
      sizeMobTab24_35,
      sizeMObTab18_30,
      sizeMobTab10_18,
      cancelOrderDecsFontSize,
      btnSubmitFontSize,
      cancelOrderFontSize,
      padding,
    );

    return NoInternetWidget(
      device: device,
      childWidget: BlocBuilder<MyOrderCancelCubit, MyOrderCancelState>(
        builder: (BuildContext context, MyOrderCancelState state) => Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: CustomSearchAppBar(
            device: device,
            isBackIconVisible: true,
            onTap: () {
              context.router.removeLast();
            },
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: padding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  sizeMObTab18_30.heightBox,
                  CustomTextLabelWidget(
                    label: MainConfig.dynamicString(
                      JsonServiceString.keyCancelOrderTitle,
                    ),
                    style: context.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: cancelOrderFontSize,
                      color: MainConfig.appColors.textColorGreyBlack,
                    ),
                  ),
                  sizeMobTab24_35.heightBox,
                  MyOrderRadioListView(
                    device: device,
                  ),
                  sizeMobTab10_18.heightBox,
                  MyOrderCancelWriteReviewView(
                    focusNode: FocusNode(),
                    device: device,
                    controller: state.commentEditingController,
                    formKey: state.formKey,
                    isTitleVisible: true,
                  ),
                  sizeMobTab22_32.heightBox,
                  CustomTextLabelWidget(
                    label: MainConfig.dynamicString(
                      JsonServiceString.keyCancelOrderDescription,
                    ),
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: MainConfig.appColors.textColorGreyBlack,
                      fontSize: cancelOrderDecsFontSize,
                    ),
                  ),
                  sizeMobTab30_40.heightBox,
                  CustomButtonWidget(
                    device: device,
                    title:
                        MainConfig.dynamicString(JsonServiceString.keySubmit),
                    onTap: () {},
                    isPrimaryButton: false,
                    backgroundColor: MainConfig.appColors.backgroundMediumDarkBlueColor,
                    titleTextStyle: context.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: MainConfig.appColors.textWhiteColor,
                      fontSize: btnSubmitFontSize,
                    ),
                  ),
                  sizeMObTab18_30.heightBox,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Adjusts dimensions based on the device type for responsive design.
  void deviceDimens(
    double sizeMobTab22_32,
    double sizeMobTab30_40,
    double sizeMobTab24_35,
    double sizeMObTab18_30,
    double sizeMobTab10_18,
    double cancelOrderDecsFontSize,
    double btnSubmitFontSize,
    double cancelOrderFontSize,
    EdgeInsets padding,
  ) {
    switch (device) {
      case ScreenType.tablet:
        sizeMobTab22_32 = Dimens.size32;
        sizeMobTab30_40 = Dimens.size40;
        sizeMobTab24_35 = Dimens.size35;
        sizeMObTab18_30 = Dimens.size30;
        sizeMobTab10_18 = Dimens.size18;
        cancelOrderDecsFontSize = Dimens.fontSize17;
        btnSubmitFontSize = Dimens.fontSize24;
        cancelOrderFontSize = Dimens.fontSize20;
        padding = const EdgeInsets.symmetric(horizontal: Dimens.space32);

      case ScreenType.mobile:
      case ScreenType.desktop:
    }
  }
}
