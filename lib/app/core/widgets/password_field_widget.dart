import '../../../../utils/exports.dart';

/// A widget that provides a customizable password input field.
class PasswordFieldWidget extends StatelessWidget {
  /// The controller for the text field.
  final TextEditingController controller;
  /// The label text to display above the field.
  final String label;
  /// The action to take when the user is done editing.
  final TextInputAction inputAction;
  /// The focus node for the text field.
  final FocusNode focusNode;
  /// Whether the text should be obscured.
  final bool obscureText;
  /// The next focus node to move to when the user is done editing.
  final FocusNode? nextFocusNode;
  /// A callback to toggle the obscure text state.
  final VoidCallback toggleObscureText;
  /// A callback to be executed when the user submits the text.
  final Function(String)? onTextSubmit;
  /// The type of device the app is running on.
  final ScreenType device;
  /// The error message to display below the field.
  ///
  /// If null, no error message is displayed.
  final String? errorMsg;
  /// A callback to be executed when the text field's value changes.
  ///
  /// The new value is passed to the callback.
  final ValueChanged<String>? onChange;
  ///
  const PasswordFieldWidget(
      {super.key,
        required this.controller,
        required this.label,
        required this.inputAction,
        required this.focusNode,
        required this.obscureText,
        this.nextFocusNode,
        required this.toggleObscureText,
        this.onTextSubmit,
        this.errorMsg,
        this.onChange,
        this.device = ScreenType.mobile});

  @override
  Widget build(BuildContext context) {

    return CommonTextFormFieldWidget(
      device: device,
      controller: controller,
      label: label,
      input: inputAction,
      errorMsg: errorMsg,
      focusNode: focusNode,
      obscureText: obscureText,
      maxLength: Dimens.maxLength15,
      onChange: onChange,
      suffixIconConstraints: const BoxConstraints(
        minWidth: Dimens.size24,
        minHeight: Dimens.size24,
        maxWidth: Dimens.size80,  // Increased from 50 to 80
        maxHeight: Dimens.size50,
      ),
      suffixIcon: InkWell(
        onTap: toggleObscureText,
        borderRadius: BorderRadius.circular(Dimens.space4),
        child: Padding(
          padding: const EdgeInsets.all(Dimens.space8),
          child: CustomTextLabelWidget(
            label:
            obscureText ? context.appString.showKey : context.appString.hideKey,
            style: context.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w400,
                height: Dimens.lineHeight16.toLineHeight(Dimens.fontSize26),
                color: MainConfig.appColors.textLightBlackColor,
                fontSize: Dimens.fontSize12),
          ),
        ),
      ),
    );
  }
}
