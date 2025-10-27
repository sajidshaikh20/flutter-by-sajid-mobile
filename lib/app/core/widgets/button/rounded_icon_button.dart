import '../../../../utils/exports.dart';

/// A rounded button that displays an icon with optional custom styling.
class RoundedIconButton extends StatelessWidget {
  /// Creates a [RoundedIconButton].
  ///
  /// - [icon]: The icon to display inside the button.
  /// - [onPress]: Callback invoked when the button is tapped.
  /// - [iconSize]: The size of the icon. If null, a default size is used.
  /// - [color]: Background color of the button. Defaults to the primary color.
  /// - [boxDecoration]: Custom decoration to fully override the default styling.
  const RoundedIconButton(
      {super.key, this.icon, this.onPress, required this.iconSize, this.color, this.boxDecoration});

  /// The icon to display inside the button.
  final IconData? icon;
  /// Callback invoked when the button is tapped.
  final Function()? onPress;
  /// The size of the icon.
  final double? iconSize;
  /// The background color for the button.
  final Color? color;
  /// Optional decoration to override the default rounded styling.
  final BoxDecoration? boxDecoration;

  /// Builds the rounded icon button widget.
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: Dimens.size82,
        decoration: boxDecoration ?? BoxDecoration(
          color: color ?? MainConfig.appColors.mainColor,
          border: Border.all(color: MainConfig.appColors.borderColorWhite, width:  Dimens.borderWidth04),
          borderRadius: Dimens.radius2.borderRadius,
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: iconSize ?? Dimens.size24 ,
        ),
      ),
    );
  }
}
