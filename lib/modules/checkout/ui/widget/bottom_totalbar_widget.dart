import '../../../../utils/exports.dart';

/// A widget representing a bottom total bar, typically displayed in the
/// checkout
/// section. It shows the total label, total value, and a continue button.
class BottomTotalBar extends StatelessWidget {
  /// Constructor for creating a `BottomTotalBar` widget.
  /// [totalLabel] is the label for the total amount.
  /// [totalValue] is the actual total amount to be displayed.
  /// [onContinueTap] is the callback function when the continue button is
  /// tapped.
  /// [btnTitle] is an optional title for the continue button.
  /// [device] determines the screen type (mobile, tablet, desktop).
  const BottomTotalBar({
    required this.totalLabel,
    required this.totalValue,
    required this.onContinueTap,
    super.key,
    this.btnTitle,
    this.device = ScreenType.mobile,
  });

  /// The label text for the total amount.
  final String totalLabel;

  /// The value text for the total amount.
  final String totalValue;

  /// The callback function when the continue button is tapped.
  final VoidCallback onContinueTap;

  /// The optional title for the continue button.
  final String? btnTitle;

  /// The type of screen for adjusting the layout. Defaults to mobile.
  final ScreenType device;

  @override
  Widget build(BuildContext context) {
    double widthMobTab100_150 = Dimens.size100;
    double totalValueFontSize = Dimens.fontSize17;
    double continueFontSize = Dimens.fontSize16;
    double totalLabelFontSize = Dimens.fontSize14;
    double btnHeight = Dimens.size44;
    double btnWidth = Dimens.size140;

    EdgeInsets padding = const EdgeInsets.symmetric(
      horizontal: Dimens.space16,
      vertical: Dimens.space10,
    );

    switch (device) {
      case ScreenType.tablet:
        totalLabelFontSize = Dimens.fontSize18;
        continueFontSize = Dimens.fontSize24;
        totalValueFontSize = Dimens.fontSize21;
        widthMobTab100_150 = Dimens.size150;
        padding = const EdgeInsets.symmetric(
          horizontal: Dimens.space24,
          vertical: Dimens.space20,
        );
        btnHeight = Dimens.size87;
        btnWidth = Dimens.size220;
      case ScreenType.mobile:
      case ScreenType.desktop:
        break;
    }

    return BlocBuilder<CheckOutCubit, CheckOutState>(
      builder: (BuildContext context, CheckOutState state) => Visibility(
        visible: state.startShowingShimmer == false,
        replacement: const BottomShimmerWidget(),
        child: CommonContainer(
          padding: padding,
          backgroundColor: MainConfig.appColors.backgroundGreyColor,
          childWidgets: Row(
            children: <Widget>[
              // Column showing total label and value
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CustomTextLabelWidget(
                      label: totalLabel,
                      style: context.textTheme.titleLarge?.copyWith(
                        color: MainConfig.appColors.textColorGreyBlack,
                        fontSize: totalLabelFontSize,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Dimens.size4.heightBox,
                    CustomTextLabelWidget(
                      label: totalValue,
                      style: context.textTheme.titleLarge?.copyWith(
                        color: MainConfig.appColors.textDarkBlackColor,
                        fontSize: totalValueFontSize,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              widthMobTab100_150.widthBox,
              // Button to continue to the next step
              CustomButtonWidget(
                height: btnHeight,
                width: btnWidth,
                device: device,
                backgroundColor: MainConfig.appColors.mainColor,
                title: btnTitle ??
                    MainConfig.dynamicString(
                      JsonServiceString.keyContinueUpper,
                    ),
                isPrimaryButton: false,
                titleTextStyle: context.textTheme.titleMedium?.copyWith(
                  fontSize: continueFontSize,
                  color: MainConfig.appColors.textWhiteColor,
                ),
                onTap: onContinueTap,
              ),
            ],
          ),
        ),
      ),
      // Rebuilds when the shimmer state changes
      buildWhen: (CheckOutState previous, CheckOutState current) =>
          previous.startShowingShimmer != current.startShowingShimmer,
    );
  }
}
