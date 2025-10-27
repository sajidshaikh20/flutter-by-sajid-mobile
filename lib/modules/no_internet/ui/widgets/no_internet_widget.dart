import '../../../../utils/exports.dart';

/// Widget that displays a no internet connection screen with retry functionality.
class NoInternetWidget extends StatelessWidget {
  /// Creates a no internet widget.
  const NoInternetWidget({
    required this.childWidget,
    super.key,
    this.onTryAgain, // Initialize callback in the constructor
    this.device = ScreenType.mobile,
  });

  /// Callback function called when the try again button is pressed.
  final Function()? onTryAgain;

  /// The screen type for responsive design.
  final ScreenType device;

  /// The child widget to display when internet is connected.
  final Widget childWidget;

  @override
  Widget build(BuildContext context) {
    const double padding = Dimens.space16;
    const double tryAgainFontSize = Dimens.fontSize16;
    const double noInternetFontSize = Dimens.fontSize18;
    const double errorInternetFontSize = Dimens.fontSize14;
    const double sizeMobTab14_22 = Dimens.size14;
    const double sizeMobTab9_13 = Dimens.size9;
    const double sizeMobTab23_35 = Dimens.size23;
    deviceDimens(
      tryAgainFontSize,
      noInternetFontSize,
      errorInternetFontSize,
      padding,
      sizeMobTab14_22,
      sizeMobTab9_13,
      sizeMobTab23_35,
    );

    return BlocConsumer<InternetCubit, NoInternetState>(
      builder: (BuildContext context, NoInternetState state) => (!state.isInternetConnected)
          ? ColoredBox(
              color: MainConfig.appColors.backgroundLightPinkColor,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Assets.svgs.icInternetTower.svg(),
                    Dimens.space22.heightBox,
                    CustomTextLabelWidget(
                      label: context.appString.noInternetConnectionKey,
                      style: context.textTheme.headlineMedium?.copyWith(
                        fontSize: noInternetFontSize,
                        fontWeight: FontWeight.w600,
                        height: Dimens.lineHeight20
                            .toLineHeight(noInternetFontSize),
                        color: MainConfig.appColors.textDarkBlackColor,
                      ),
                    ),
                    Dimens.space9.heightBox,
                    CustomTextLabelWidget(
                      label: context.appString.pleaseCheckYourNetworkConnectionKey,
                      style: context.textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w400,
                        height: Dimens.lineHeight16
                            .toLineHeight(errorInternetFontSize),
                        color: MainConfig.appColors.textDarkBlackColor,
                        fontSize: errorInternetFontSize,
                      ),
                    ),
                    Dimens.space30.heightBox,
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimens.space65),
                      child: CustomGradientButtonWidget(
                        title: context.appString.tryAgainKey,
                        titleTextStyle:
                            context.textTheme.headlineSmall?.copyWith(
                          fontSize: tryAgainFontSize,
                          fontWeight: FontWeight.w700,
                          height: Dimens.lineHeight24
                              .toLineHeight(tryAgainFontSize),
                          color: MainConfig.appColors.textWhiteColor,
                        ),
                        onTap: () async {
                          if (await context
                              .read<InternetCubit>()
                              .checkConnectivity()) {
                            onTryAgain?.call();
                          }
                        }, // Invoke the callback on button press
                      ),
                    ),
                  ],
                ),
              ),
            )
          : childWidget,
      buildWhen: (NoInternetState previous, NoInternetState current) =>
          previous.isInternetConnected != current.isInternetConnected,
      listener: (BuildContext context, NoInternetState state) {
        if (state.isInternetConnected) {
          onTryAgain?.call();
        }
      },
      listenWhen: (NoInternetState previous, NoInternetState current) =>
          previous.isInternetConnected != current.isInternetConnected,
    );
  }

  /// Adjusts dimensions based on the device type for responsive design.
  void deviceDimens(
    double tryAgainFontSize,
    double noInternetFontSize,
    double errorInternetFontSize,
    double padding,
    double sizeMobTab14_22,
    double sizeMobTab9_13,
    double sizeMobTab23_35,
  ) {
    switch (device) {
      case ScreenType.tablet:
        tryAgainFontSize = Dimens.fontSize20;
        noInternetFontSize = Dimens.fontSize22;
        errorInternetFontSize = Dimens.fontSize18;
        padding = Dimens.space26;
        sizeMobTab14_22 = Dimens.size22;
        sizeMobTab9_13 = Dimens.size13;
        sizeMobTab23_35 = Dimens.size35;

      case ScreenType.mobile:
      case ScreenType.desktop:
    }
  }
}
