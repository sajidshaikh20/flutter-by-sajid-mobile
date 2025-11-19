import '../../../utils/exports.dart';

/// A custom dialog widget for displaying messages with a title and an "OK" action.
class CustomMessageDialog extends StatelessWidget {
  /// The title of the dialog.
  final String title;

  /// The message content of the dialog.
  final String message;

  /// The callback function to be executed when the "OK" button is pressed.
  final VoidCallback onConfirm;

  /// Creates a [CustomMessageDialog] widget.
  ///
  /// [title] is the title of the dialog.
  /// [message] is the message content of the dialog.
  const CustomMessageDialog({
    super.key,
    required this.title,
    required this.message,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(

      ),
      title: Directionality(
        textDirection:
            isRTLText(title) ? TextDirection.rtl : TextDirection.ltr,
        child: CustomTextLabelWidget(
          label: title,
          textAlign: TextAlign.start,
          style: MainConfig.appStyle.textSemiBold.copyWith(
            fontSize: Dimens.fontSize18,
            color: MainConfig.appColors.textMediumDarkBlueColor,
          ),
        ),
      ),
      content: Directionality(
        textDirection:
            isRTLText(message) ? TextDirection.rtl : TextDirection.ltr,
        child: CustomTextLabelWidget(
          label: message,
          textAlign: TextAlign.start,
          style: AppStyles.textMedium.copyWith(
            fontSize: Dimens.fontSize18,
            color: MainConfig.appColors.textMediumDarkBlueColor,
          ),
        ),
      ),
      actions: <Widget>[
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: onConfirm,
          child: CustomTextLabelWidget(
            label: MainConfig.context.appString.okayKey,
            style: AppStyles.textMedium.copyWith(
              fontSize: Dimens.fontSize16,
              color: MainConfig.appColors.textMediumDarkBlueColor,
            ),
          ),
        ),
      ],
    );
  }
}

/// Displays a custom message dialog.
///
/// This function shows a dialog with a customizable message.
///
/// [context] is the [BuildContext] used to show the dialog.
/// [message] is the message to be displayed in the dialog.
/// [barrierDismissible] determines whether the dialog can be dismissed by tapping outside of it.
///
/// Returns a [Future] that completes when the dialog is closed.
Future<void> showCustomMessageDialog(BuildContext context, String message,
    {bool barrierDismissible = true}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (BuildContext context) {
      return CustomMessageDialog(
        title: "Base Structure",
        message: message,
        onConfirm: () async {
          await context.router.maybePop();
        },
      );
    },
  );
}
