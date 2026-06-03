import '../../../../utils/exports.dart';

/// A custom button widget that can be configured with various styles and properties.
class CustomButtonWidget extends StatelessWidget {
  /// The title text to display on the button.
  ///
  /// This is a required parameter.
  final String title;

  /// Optional text style for the button's title.
  ///
  /// If null, a default text style will be applied.
  final TextStyle? titleTextStyle;

  /// Callback function to be executed when the button is tapped.
  ///
  /// This is a required parameter.
  final Function() onTap;

  /// The color of the button when it is disabled.
  ///
  /// If this is null, the button will use a default disabled color.
  final Color? disabledColor;

  /// Whether the button has a border.
  ///
  /// Defaults to `false`.
  final bool hasBorder;

  /// The width of the button's border.
  ///
  /// Defaults to [Dimens.borderWidth1].
  final double borderWidth;

  /// The border radius of the button.
  ///
  /// Defaults to [Dimens.radius6].
  final double borderRadius;

  /// Whether the button is enabled.
  ///
  /// If `false`, the button will be displayed in a disabled state.
  /// Defaults to `true`.
  final bool isButtonEnabled;

  /// The height of the button.
  ///
  /// Defaults to [Dimens.size48].
  final double height;

  /// The width of the button.
  ///
  /// Defaults to [double.infinity].
  final double width;

  /// Whether the button is a primary button.
  ///
  /// If `true`, the button will be displayed as a primary button.
  /// Defaults to `true`.
  final bool isPrimaryButton;

  /// The background color of the button.
  ///
  /// Defaults to `Colors.red`.
  final Color? backgroundColor;

  /// The border color of the button.
  ///
  /// Defaults to `MainConfig.appColors.borderSecondaryColor`.
  final Color borderColor;

  /// An optional icon to display within the button.
  final Widget? icon;

  /// The type of device the button is being displayed on.
  ///
  /// Defaults to `ScreenType.mobile`.
  final ScreenType device;

  /// The text direction for the button's text.
  final TextDirection? textDirection;

  /// If true, draws the border using the inner Container's BoxDecoration
  /// instead of relying on TextButton shape side. Useful when parent styles
  /// might visually hide the shape border.
  final bool drawBorderInDecoration;

  /// Whether the button is styled as an outline button.
  final bool isOutline;

  /// Whether the button is styled as a ghost button (transparent with soft bg).
  final bool isGhost;

  /// Optional fully custom child content.
  ///
  /// When provided, this is rendered as-is and internal title/icon layout
  /// is skipped.
  final Widget? childWidget;

  /// Creates a custom button widget.
  CustomButtonWidget({
    super.key,
    required this.title,
    this.titleTextStyle,
    required this.onTap,
    Color? disabledColor,
    Color? borderColor,
    this.backgroundColor = Colors.red,
    this.hasBorder = false,
    this.borderWidth = Dimens.borderWidth1,
    this.borderRadius = Dimens.radius6,
    this.isButtonEnabled = true,
    this.height = Dimens.size48,
    this.width = double.infinity,
    this.isPrimaryButton = true,
    this.icon,
    this.textDirection,
    this.device = ScreenType.mobile,
    this.drawBorderInDecoration = false,
    this.isOutline = false,
    this.isGhost = false,
    this.childWidget,
  }) : disabledColor = disabledColor ?? MainConfig.appColors.labelGrey,
       borderColor = borderColor ?? MainConfig.appColors.borderSecondaryColor;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final bool isLTR = isLanguageAlignmentLTR;

    // 1. Configure styles and color properties for block buttons
    Color resolvedBgColor = Colors.transparent;
    Color? resolvedTextColor;
    Gradient? backgroundGradient;
    Gradient? borderGradient;
    Color? resolvedBorderColor;
    List<BoxShadow>? resolvedBoxShadow;

    if (!isButtonEnabled) {
      // Disabled state
      resolvedBgColor = isDark
          ? const Color(0xFF1C1B2A)
          : const Color(0xFFF7F7FC);
      resolvedTextColor = isDark
          ? const Color(0xFF4E4B66)
          : const Color(0xFFD6D6E7);
    } else if (isPrimaryButton) {
      // Primary button styles
      if (isOutline || hasBorder) {
        resolvedBgColor = Colors.transparent;
        borderGradient = AppColors.primaryButtonGradient;
      } else if (isGhost) {
        resolvedBgColor = isDark
            ? AppColors.primaryPurple.withValues(alpha: 0.15)
            : AppColors.primaryPurple.withValues(alpha: 0.08);
        resolvedTextColor = AppColors.primaryPurple;
      } else {
        backgroundGradient = AppColors.primaryButtonGradient;
        resolvedTextColor = Colors.white;
      }
    } else {
      // Secondary button styles
      if (isOutline || hasBorder || (!isGhost && !isDark)) {
        resolvedBgColor = Colors.transparent;
        resolvedBorderColor = AppColors.primaryPurple;
        resolvedTextColor = AppColors.primaryPurple;
      } else if (isGhost) {
        resolvedBgColor = isDark
            ? AppColors.primaryPurple.withValues(alpha: 0.12)
            : AppColors.primaryPurple.withValues(alpha: 0.08);
        resolvedTextColor = AppColors.primaryPurple;
      } else {
        resolvedBgColor = AppColors.primaryPurple;
        resolvedTextColor = Colors.white;
      }
    }

    final double textFontSize = Dimens.fontSize16;

    // 2. Build inner label text
    Widget labelWidget = CustomTextLabelWidget(
      textDirection: textDirection,
      maxLines: Dimens.maxLines01,
      label: title,
      overflow: TextOverflow.ellipsis,
      style:
          titleTextStyle ??
          context.textTheme.headlineMedium?.copyWith(
            fontSize: textFontSize,
            fontWeight: FontWeight.w600,
            color: resolvedTextColor ?? Colors.white,
          ),
    );

    // Apply linear gradient to text if it's Primary Outline (and enabled)
    if (isButtonEnabled && isPrimaryButton && (isOutline || hasBorder)) {
      labelWidget = ShaderMask(
        shaderCallback: (Rect bounds) {
          return AppColors.primaryButtonGradient.createShader(
            Offset.zero & bounds.size,
          );
        },
        child: CustomTextLabelWidget(
          textDirection: textDirection,
          maxLines: Dimens.maxLines01,
          label: title,
          overflow: TextOverflow.ellipsis,
          style: (titleTextStyle ?? context.textTheme.headlineMedium)?.copyWith(
            fontSize: textFontSize,
            fontWeight: FontWeight.w600,
            color: Colors.white, // White color lets shader show through
          ),
        ),
      );
    }

    // 3. Build button content
    final Widget content =
        childWidget ??
        Row(
          children: <Widget>[
            if (icon != null)
              Padding(
                padding: EdgeInsets.only(
                  left: isLTR ? Dimens.space16 : Dimens.space0,
                  right: isLTR ? Dimens.space0 : Dimens.space16,
                ),
                child: icon ?? const SizedBox(),
              ),
            Expanded(child: Center(child: labelWidget)),
            if (icon != null) Dimens.size32.widthBox,
          ],
        );




    // 4. Build outer Container
    Widget container = Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),

        // Show gradient for primary buttons
        gradient: backgroundGradient,

        // Use color only when gradient is null
        color: backgroundGradient == null ? resolvedBgColor : null,

        boxShadow: resolvedBoxShadow,

        border: resolvedBorderColor != null
            ? Border.all(
          color: resolvedBorderColor,
          width: borderWidth,
        )
            : null,
      ),
      child: content,
    );

    // Handle primary outline button gradient border drawing
    if (isButtonEnabled && isPrimaryButton &&
        (isOutline || hasBorder) &&
        borderGradient != null) {
      container = CustomPaint(
        painter: GradientBorderPainter(
          gradient: borderGradient,
          strokeWidth: borderWidth,
          borderRadius: borderRadius,
        ),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: resolvedBgColor,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: content,
        ),
      );
    }

    return TextButton(
      style: TextButton.styleFrom(
        splashFactory: NoSplash.splashFactory,
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      onPressed: () {
        hideKeyboard();
        if (isButtonEnabled) onTap.call();
      },
      child: container,
    );
  }
}

/// Custom painter to draw a gradient border.
class GradientBorderPainter extends CustomPainter {
  /// The gradient to use for the border.
  final Gradient gradient;

  /// The width of the border stroke.
  final double strokeWidth;

  /// The border radius.
  final double borderRadius;

  /// Creates a GradientBorderPainter.
  GradientBorderPainter({
    required this.gradient,
    required this.strokeWidth,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final Paint paint = Paint()
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..shader = gradient.createShader(rect);

    final RRect rrect = RRect.fromRectAndRadius(
      rect.deflate(strokeWidth / 2),
      Radius.circular(borderRadius),
    );

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant GradientBorderPainter oldDelegate) {
    return oldDelegate.gradient != gradient ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.borderRadius != borderRadius;
  }
}
