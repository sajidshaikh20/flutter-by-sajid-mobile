import '../../../../utils/exports.dart';

/// A widget to display a message when there is no data available.
/// Useful for empty states in lists, screens, or components.
class CustomNoDataWidget extends StatelessWidget {
  /// The message to display as title.
  final String message;

  /// Optional custom text style for title.
  final TextStyle? style;

  /// Text alignment within the widget. Defaults to center.
  final TextAlign textAlign;

  /// Custom asset widget. If null, a default empty-state icon is shown.
  final Widget? asset;

  /// The description message to display below the title.
  final String? description;

  /// Optional button text. If provided, a button will be shown.
  final String? buttonText;

  /// Optional callback for button press.
  final VoidCallback? onButtonPressed;

  /// Whether to show the image/animation. Defaults to true.
  final bool showImage;

  /// Whether to show the button. Defaults to true.
  final bool showButton;

  /// Background color of the widget. Defaults to Light Pink.
  final Color? backgroundColor;

  /// Constructor for [CustomNoDataWidget].
  const CustomNoDataWidget({
    super.key,
    required this.message,
    this.style,
    this.textAlign = TextAlign.center,
    this.asset,
    this.description,
    this.buttonText,
    this.onButtonPressed,
    this.showImage = true,
    this.showButton = true,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: backgroundColor ?? MainConfig.appColors.backgroundLightPinkColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (showImage) ...<Widget>[
              asset ??
                  Icon(
                    Icons.inbox_outlined,
                    size: Dimens.size80,
                    color: MainConfig.appColors.greyTextColor,
                  ),
              Dimens.space20.heightBox,
            ],
            // Title
            if (message.isNotEmpty)
              CustomTextLabelWidget(
                label: message,
                textAlign: textAlign,
                style: style ??
                    context.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: MainConfig.appColors.textLightBlackColor,
                      fontSize: Dimens.fontSize18,
                    ),
                maxLines: Dimens.maxLines03,
                overflow: TextOverflow.visible,
              ),
            // Description
            if (description != null && description!.isNotEmpty) ...<Widget>[
              Dimens.space12.heightBox,
              CustomTextLabelWidget(
                label: description ?? "",
                textAlign: textAlign,
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: MainConfig.appColors.textLightBlackColor,
                  fontSize: Dimens.fontSize14,
                ),
                overflow: TextOverflow.visible,
              ),
            ],
            // Button
            if (showButton) ...<Widget>[
              Dimens.space30.heightBox,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimens.space65),
                child: CustomGradientButtonWidget(
                  onTap: () {
                    onButtonPressed?.call();
                  },
                  title: buttonText ?? context.appString.tryAgainKey,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
