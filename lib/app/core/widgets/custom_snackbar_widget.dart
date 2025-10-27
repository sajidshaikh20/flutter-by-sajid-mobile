import '../../../utils/exports.dart';

/// A custom widget for displaying snack bar content with an optional icon
/// and message text.
///
/// The widget arranges the icon (if provided) to the left of the message
/// and aligns text accordingly.
class CustomSnackBarWidget extends StatelessWidget {
  /// The message to display inside the snack bar.
  final String message;

  /// Optional SVG icon displayed before the message.
  final SvgGenImage? icon;

  /// Optional button text (currently unused in the UI layout, but available
  /// for future extensions).
  final String? buttonText;

  /// Optional callback invoked when the button (if implemented) is clicked.
  final Function()? onButtonClick;

  /// Creates a [CustomSnackBarWidget].
  ///
  /// The [message] parameter must not be null.
  const CustomSnackBarWidget({
    required this.message,
    this.icon,
    this.buttonText,
    this.onButtonClick,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        icon != null
            ? Padding(
          padding: const EdgeInsets.only(right: Dimens.space8),
          child: icon?.svg(
            height: Dimens.size16,
            width: Dimens.size16,
          ),
        )
            : Container(),
        Flexible(
          child: CustomTextLabelWidget(
            textAlign: icon != null ? TextAlign.left : TextAlign.center,
            maxLines: Dimens.maxLines10,
            label: message,
            style: context.textTheme.titleMedium?.copyWith(
              fontSize: Dimens.fontSize16,
              color: MainConfig.appColors.textWhiteColor,
            ),
          ),
        ),
      ],
    );
  }
}
/// Displays a floating snack bar with optional icon, button text, and custom
/// duration.
///
/// The snack bar uses a [CustomSnackBarWidget] for its content and supports
/// RTL or LTR text direction based on the message.
///
/// Parameters:
/// - [message]: The main text content of the snack bar.
/// - [context]: The [BuildContext] used to show the snack bar.
/// - [icon]: Optional icon to display before the message.
/// - [buttonText]: Optional button text.
/// - [onButtonClick]: Optional callback when the button is tapped.
/// - [duration]: Optional custom display duration for the snack bar.
/// - [isDismissible]: Optional flag for dismissibility.
void displaySnackBar(
    String message,
    BuildContext context, {
      SvgGenImage? icon,
      String buttonText = "",
      Function()? onButtonClick,
      Duration? duration,
      bool? isDismissible,
    }) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      margin: const EdgeInsets.only(
        left: Dimens.space28,
        right: Dimens.space28,
        bottom: Dimens.space28,
      ),
      duration: duration ?? const Duration(seconds: Dimens.duration3),
      shape: RoundedRectangleBorder(
        borderRadius: Dimens.radius10.borderRadius,
      ),
      behavior: SnackBarBehavior.floating,
      content: Directionality(
        textDirection:
        isRTLText(message) ? TextDirection.rtl : TextDirection.ltr,
        child: CustomSnackBarWidget(
          message: message,
          icon: icon,
          buttonText: buttonText,
          onButtonClick: onButtonClick,
        ),
      ),
      backgroundColor: MainConfig.appColors.mainColor,
    ),
  );
}

/// A mixin that provides a method to display a blue snack bar with custom
/// alignment.
///
/// The snack bar text can be aligned either to the left or right depending on
/// the flag.
mixin CustomBlueSnackBar {
  /// Shows a floating snack bar with a blue background.
  ///
  /// Parameters:
  /// - [context]: The [BuildContext] used to show the snack bar.
  /// - [message]: The text content to display.
  /// - [alignLeft]: Whether the text should be aligned to the left
  ///   (defaults to true).
  static void showSnackBar(
      BuildContext context,
      String message, {
        bool alignLeft = true,
      }) {
    final SnackBar snackBar = SnackBar(
      content: Align(
        alignment: alignLeft ? Alignment.centerLeft : Alignment.centerRight,
        child: CustomTextLabelWidget(
          label: message,
          style: context.textTheme.labelSmall?.copyWith(
            color: MainConfig.appColors.textWhiteColor,
            fontSize: Dimens.fontSize16,
          ),
        ),
      ),
      dismissDirection: DismissDirection.up,
      backgroundColor: MainConfig.appColors.backgroundLightBlueColor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: Dimens.radius0.borderRadius,
      ),
      elevation: Dimens.elevation0,
      margin: EdgeInsets.only(
        bottom: context.height * Dimens.ratio085,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
