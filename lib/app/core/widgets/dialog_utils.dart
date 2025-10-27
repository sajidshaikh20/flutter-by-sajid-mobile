import '../../../utils/exports.dart';

/// A reusable customizable dialog widget.
///
/// Can display a title, message, optional content widget, and up to two buttons.
/// Designed to adapt spacing and sizing for different [ScreenType] devices.
class DialogUtils extends StatelessWidget {
  /// The main message shown in the dialog.
  final String message;

  /// Optional title text displayed above the message.
  final String? title;

  /// Optional text for the OK/confirm button.
  final String? okBtnTitle;

  /// Optional text for the Cancel button.
  final String? cancelBtnTitle;

  /// Called when the OK button is tapped.
  final VoidCallback? onOkClicked;

  /// Called when the Cancel button is tapped.
  final VoidCallback? onCancelClicked;

  /// Optional style for the title text.
  final TextStyle? titleStyle;

  /// Optional style for the OK button text.
  final TextStyle? okBtnTitleStyle;

  /// Whether to hide the dialog automatically when a button is tapped.
  final bool isDialogHideOnClick;

  /// Optional custom widget to display in place of the message.
  final Widget? contentWidget;

  /// Determines sizing and spacing rules.
  final ScreenType device;

  /// Alignment for the [message] text.
  final TextAlign? textAlign;

  ///DialogUtils
  const DialogUtils({
    required this.message,
    this.title,
    this.okBtnTitle,
    this.cancelBtnTitle,
    this.onOkClicked,
    this.onCancelClicked,
    this.isDialogHideOnClick = true,
    super.key,
    this.titleStyle,
    this.okBtnTitleStyle,
    this.contentWidget,
    this.device = ScreenType.mobile,
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    // Spacing defaults for mobile
    double space8_16 = Dimens.space8;
    double space10_22 = Dimens.space10;
    double space16_32 = Dimens.space20;

    double maxWidth = Dimens.space400;

    // Adjust for tablet
    if (device == ScreenType.tablet) {
      space8_16 = Dimens.space16;
      space10_22 = Dimens.space22;
      space16_32 = Dimens.space32;
      maxWidth = Dimens.space600;
    }

    return Dialog(
      elevation: Dimens.elevation4,
      backgroundColor: MainConfig.appColors.backgroundWhiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: Dimens.radius16.borderRadius,
      ),
      child: Container(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Title
            if (title.isNotNullOrBlank)
              Padding(
                padding: const EdgeInsets.only(top: Dimens.size16),
                child: Directionality(
                  textDirection: isRTLText(title ?? '')
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                  child: CustomTextLabelWidget(
                    label: title ?? '',
                    style: titleStyle ??
                        context.textTheme.titleLarge?.copyWith(
                          height: Dimens.lineHeight24
                              .toLineHeight(Dimens.fontSize16),
                          fontWeight: FontWeight.w700,
                          fontSize: Dimens.fontSize16,
                        ),
                  ),
                ),
              ),
            if (title.isNotNullOrBlank) SizedBox(height: space8_16),

            // Content widget
            if (contentWidget != null) contentWidget!,

            // Message
            if (message.isNotBlank)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimens.size22,
                  vertical: Dimens.space8,
                ),
                child: Directionality(
                  textDirection: isRTLText(message)
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                  child: CustomTextLabelWidget(
                    label: message,
                    overflow: TextOverflow.clip,
                    style: context.textTheme.titleLarge?.copyWith(
                      height: Dimens.lineHeight18
                          .toLineHeight(Dimens.fontSize14),
                      fontWeight: FontWeight.w400,
                      fontSize: Dimens.fontSize14,
                    ),
                    textAlign: textAlign,
                  ),
                ),
              ),

            // Bottom actions (optional)
            if (okBtnTitle.isNotBlank || cancelBtnTitle.isNotBlank) ...<Widget>[
              SizedBox(height: space16_32),
              const CustomDivider(
                height: 1,
                color: AppColors.deviderBorderColor,
              ),
              if (okBtnTitle.isNotBlank && cancelBtnTitle.isNotBlank)
                _buildTwoButtonRow(context, space10_22)
              else if (okBtnTitle.isNotBlank)
                _buildSingleButton(context),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTwoButtonRow(BuildContext context, double space) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: space),
            child: CustomTextLabelWidget(
              label: cancelBtnTitle ?? "",
              style: context.textTheme.titleLarge?.copyWith(
                height: Dimens.lineHeight30
                    .toLineHeight(Dimens.fontSize16),
                fontWeight: FontWeight.w600,
                color: MainConfig.appColors.mainColor,
                fontSize: Dimens.fontSize16,
              ),
              onTap: () {
                if (isDialogHideOnClick) goBack(context);
                onCancelClicked?.call();
              },
            ),
          ),
        ),
        const SizedBox(
          height: Dimens.size50,
          child: VerticalDivider(
            color: AppColors.deviderBorderColor,
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: space),
            child: CustomTextLabelWidget(
              label: okBtnTitle ?? "",
              style: okBtnTitleStyle ??
                  context.textTheme.titleLarge?.copyWith(
                    height: Dimens.lineHeight30
                        .toLineHeight(Dimens.fontSize16),
                    color: MainConfig.appColors.mainColor,
                    fontWeight: FontWeight.w600,
                    fontSize: Dimens.fontSize16,
                  ),
              onTap: () {
                if (isDialogHideOnClick) goBack(context);
                onOkClicked?.call();
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSingleButton(BuildContext context) {
    return Padding(
      padding:  const EdgeInsets.symmetric(vertical: Dimens.space10),
      child: CustomTextLabelWidget(
        label: okBtnTitle ?? "",
        style: okBtnTitleStyle ??
            context.textTheme.titleLarge?.copyWith(
              height: Dimens.lineHeight30
                  .toLineHeight(Dimens.fontSize16),
              fontWeight: FontWeight.w600,
              color: MainConfig.appColors.mainColor,
              fontSize: Dimens.fontSize16,
            ),
        onTap: () {
          if (isDialogHideOnClick) goBack(context);
          onOkClicked?.call();
        },
      ),
    );
  }
}

/// Shows a [DialogUtils] with the given parameters.
void showCustomDialog(
    String message, {
      String? title,
      String? okBtnTitle,
      String? cancelBtnTitle,
      VoidCallback? onOkClicked,
      VoidCallback? onCancelClicked,
      Function(dynamic)? onBack,
      Key? key,
      bool? isDialogHideOnClick,
      TextStyle? titleStyle,
      TextStyle? okBtnTitleStyle,
      Widget? contentWidget,
      bool barrierDismissible = true,
      ScreenType device = ScreenType.mobile,
      TextAlign? textAlign,
    }) {
  unawaited(showDialog(
    context: MainConfig.context,
    barrierDismissible: barrierDismissible,
    builder: (BuildContext context) {
      return DialogUtils(
        contentWidget: contentWidget,
        message: message,
        okBtnTitle: okBtnTitle,
        cancelBtnTitle: cancelBtnTitle,
        onOkClicked: onOkClicked,
        isDialogHideOnClick: isDialogHideOnClick ?? false,
        onCancelClicked: onCancelClicked,
        title: title,
        titleStyle: titleStyle,
        okBtnTitleStyle: okBtnTitleStyle,
        key: key,
        device: device,
        textAlign: textAlign,
      );
    },
  ).then((dynamic value) => onBack?.call(value)));
}

