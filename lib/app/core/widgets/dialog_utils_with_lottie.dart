import '../../../utils/exports.dart';

/// A utility widget that shows a dialog with a Lottie animation or image,
/// along with optional titles, message text, and action buttons.
///
/// This dialog supports three separate titles (`title1`, `title2`, `title3`),
/// an optional custom child widget, and styling for each title.
/// It can be dismissed by tapping outside or by pressing the OK button,
/// depending on the configuration.
class DialogUtilsWithLottie extends StatefulWidget {
  /// The main message to display inside the dialog.
  final String message;

  /// The first title line shown in the dialog.
  final String? title1;

  /// The second title line shown below [title1].
  final String? title2;

  /// The third title line shown below [title2].
  final String? title3;

  /// The text for the OK button.
  final String? okBtnTitle;

  /// The text for the Cancel button.
  final String? cancelBtnTitle;

  /// Callback when the OK button is tapped.
  final Function()? onOkClicked;

  /// Callback when the Cancel button is tapped.
  final Function()? onCancelClicked;

  /// Custom text style for [title1] or [title2].
  final TextStyle? titleStyle;

  /// Custom text style for [title3].
  final TextStyle? titleStyle3;

  /// Custom text style for the OK button.
  final TextStyle? okBtnTitleStyle;

  /// If `true`, the dialog will close automatically when a button is tapped.
  final bool isDialogHideOnClick;

  /// A custom widget to display in the dialog's content area.
  final Widget? contentWidget;

  /// The screen type (mobile, tablet) to adjust spacing and layout.
  final ScreenType device;

  /// Text alignment for message text.
  final TextAlign? textAlign;

  /// An optional child widget to display below the titles.
  final Widget? child;

  /// The file path to the Lottie animation or image.
  final String lottieAnimationFilePath;

  /// Creates a dialog with a Lottie animation or static image and customizable content.
  const DialogUtilsWithLottie({
    required this.message,
    this.title1,
    this.title2,
    this.title3,
    this.okBtnTitle,
    this.cancelBtnTitle,
    this.onOkClicked,
    this.isDialogHideOnClick = true,
    this.onCancelClicked,
    super.key,
    this.titleStyle,
    this.okBtnTitleStyle,
    this.contentWidget,
    this.device = ScreenType.mobile,
    this.textAlign = TextAlign.center,
    this.titleStyle3,
    this.child,
    required this.lottieAnimationFilePath,
  });

  @override
  State<DialogUtilsWithLottie> createState() => _DialogUtilsWithLottieState();
}

class _DialogUtilsWithLottieState extends State<DialogUtilsWithLottie> {
  bool _isProcessingTap = false;

  @override
  Widget build(BuildContext context) {
    double spaceMobTab400_600 = Dimens.space400;

    switch (widget.device) {
      case ScreenType.tablet:
        spaceMobTab400_600 = Dimens.space600;
      default:
        break;
    }

    final FileType type = getFileType(widget.lottieAnimationFilePath);
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color dialogBgColor = isDark ? AppColors.surfaceDark : MainConfig.appColors.backgroundWhite;
    final Color dividerColor = isDark ? AppColors.dividerDark : AppColors.deviderBorderColor;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color subtitleColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

    return Dialog(
      backgroundColor: dialogBgColor,
      shape: RoundedRectangleBorder(borderRadius: Dimens.radius16.borderRadius),
      child: Container(
        constraints: BoxConstraints(maxWidth: spaceMobTab400_600),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Dimens.size17.heightBox,
            type == FileType.jsonFile
                ? CommonLottieAnimation(
              repeat: true,
              height: Dimens.size92,
              width: Dimens.size92,
              assetPath: widget.lottieAnimationFilePath,
            )
                : Image.asset(
              widget.lottieAnimationFilePath,
              height: Dimens.size92,
              width: Dimens.size92,
            ),
            Dimens.size2.heightBox,
            Visibility(
              visible: widget.title1.isNotNullOrBlank,
              child: CustomTextLabelWidget(
                style: context.textTheme.titleLarge?.copyWith(
                    height: Dimens.lineHeight24
                        .toLineHeight(Dimens.fontSize16),
                    fontWeight: FontWeight.w700,
                    color: textColor,
                    fontSize: Dimens.fontSize16),
                label: widget.title1 ?? '',
              ),
            ),
            Dimens.size1.heightBox,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.space40),
              child: Visibility(
                visible: widget.title2.isNotNullOrBlank,
                child: Column(
                  children: <Widget>[
                    Directionality(
                      textDirection: isRTLText(widget.title2.toString())
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                      child: CustomTextLabelWidget(
                        label: widget.title2 ?? '',
                        style: context.textTheme.titleLarge?.copyWith(
                            height: Dimens.lineHeight20
                                .toLineHeight(Dimens.fontSize14),
                            fontWeight: FontWeight.w600,
                            color: subtitleColor,
                            fontSize: Dimens.fontSize14),
                      ),
                    ),
                    Dimens.size7.heightBox,
                  ],
                ),
              ),
            ),
            Visibility(
              visible: widget.title3.isNotNullOrBlank,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimens.space21),
                child: Column(
                  children: <Widget>[
                    CustomTextLabelWidget(
                      label: widget.title3 ?? '',
                      style: widget.titleStyle3 ??
                          context.textTheme.titleLarge?.copyWith(
                              color: MainConfig.appColors.greenColor,
                              height: Dimens.lineHeight16
                                  .toLineHeight(Dimens.fontSize14),
                              fontWeight: FontWeight.w700,
                              fontSize: Dimens.fontSize14),
                    ),
                  ],
                ),
              ),
            ),
            widget.child ?? const SizedBox.shrink(),
            Dimens.size14.heightBox,
            Divider(
              height: Dimens.sizePoint5,
              color: dividerColor,
            ),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () async {
                if (_isProcessingTap) {
                  return;
                }
                _isProcessingTap = true;
                try {
                  if (widget.isDialogHideOnClick) {
                    goBack(context);
                  }
                  final Function()? ok = widget.onOkClicked;
                  if (ok != null) {
                    await Future<void>.microtask(ok);
                  }
                } finally {
                  _isProcessingTap = false;
                }
              },
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: Dimens.space13.padding,
                    child: CustomTextLabelWidget(
                      style: widget.okBtnTitleStyle ??
                          context.textTheme.titleLarge?.copyWith(
                              height: Dimens.lineHeight24
                                  .toLineHeight(Dimens.fontSize16),
                              fontWeight: FontWeight.w700,
                              color: MainConfig.appColors.mainColor,
                              fontSize: Dimens.fontSize16),
                      label: widget.okBtnTitle ?? context.appString.okayKey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Displays a [DialogUtilsWithLottie] with the given configuration.
///
/// The [lottieAnimationFilePath] must be provided and can point to either
/// a `.json` Lottie animation file or an image asset.
/// The dialog will be shown using [MainConfig.context] and will optionally
/// call [onBack] when dismissed.
Future<void> showCustomDialogWithLottie(
    String message, {
      String? title1,
      String? title2,
      String? title3,
      String? okBtnTitle,
      String? cancelBtnTitle,
      Function()? onOkClicked,
      Function()? onCancelClicked,
      Function(dynamic)? onBack,
      Key? key,
      bool? isDialogHideOnClick,
      TextStyle? titleStyle,
      TextStyle? titleStyle3,
      TextStyle? okBtnTitleStyle,
      Widget? contentWidget,
      bool barrierDismissible = true,
      ScreenType device = ScreenType.mobile,
      TextAlign? textAlign,
      Widget? child,
      required String lottieAnimationFilePath,
    })
{
  return showDialog(
    context: MainConfig.context,
    barrierDismissible: barrierDismissible,
    builder: (BuildContext context) {
      return DialogUtilsWithLottie(
        lottieAnimationFilePath: lottieAnimationFilePath,
        contentWidget: contentWidget,
        message: message,
        okBtnTitle: okBtnTitle,
        cancelBtnTitle: cancelBtnTitle,
        onOkClicked: onOkClicked,
        isDialogHideOnClick: isDialogHideOnClick ?? false,
        onCancelClicked: onCancelClicked,
        title1: title1,
        title2: title2,
        title3: title3,
        titleStyle: titleStyle,
        titleStyle3: titleStyle3,
        okBtnTitleStyle: okBtnTitleStyle,
        key: key,
        device: device,
        textAlign: textAlign,
        child: child,
      );
    },
  ).then((dynamic value) => onBack?.call(value));
}
