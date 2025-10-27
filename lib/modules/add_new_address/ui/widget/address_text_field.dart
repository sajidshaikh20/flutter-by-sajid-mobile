import '../../../../utils/exports.dart';

/// A common text field widget for address forms.
///
/// This widget wraps a [CommonTextFormFieldWidget] and provides additional
/// functionality such as validation, next-field focus, read-only mode,
/// and input formatting. It is typically used in address entry forms.
class AddressTextField extends StatelessWidget {
  /// Controller for managing the text input.
  final TextEditingController controller;

  /// Label text displayed above the text field.
  final String label;

  /// Error message to display when validation fails.
  final String? errorMsg;

  /// Optional focus node for this field.
  final FocusNode? focusNode;

  /// Optional focus node for the next field to focus on after submitting.
  final FocusNode? nextFocusNode;

  /// Maximum number of characters allowed in the field.
  final int maxLength;

  /// The action button to display on the keyboard (e.g., next, done).
  final TextInputAction inputAction;

  /// Optional input type for the keyboard (e.g., text, number, email).
  final TextInputType? textInputType;

  /// Optional input formatters to control or restrict input.
  final List<TextInputFormatter>? inputFormatters;

  /// Whether the text field is read-only.
  ///
  /// Defaults to `false`.
  final bool readOnly;

  /// The type of validation to perform on the input.
  final ValidationType validationType;

  /// Callback invoked whenever the text changes for validation purposes.
  final Function(String) onValidation;

  /// Callback invoked when the user submits and the next field should be focused.
  final VoidCallback? onNextField;

  /// Creates an [AddressTextField] widget.
  ///
  /// [controller], [label], [errorMsg], [maxLength], [inputAction],
  /// [validationType], and [onValidation] are required. Optional parameters
  /// include [focusNode], [nextFocusNode], [textInputType], [inputFormatters],
  /// [readOnly], and [onNextField].
  const AddressTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.errorMsg,
    this.focusNode,
    this.nextFocusNode,
    required this.maxLength,
    required this.inputAction,
    this.textInputType,
    this.inputFormatters,
    this.readOnly = false,
    required this.validationType,
    required this.onValidation,
    this.onNextField,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Dimens.fontSize16),
      child: CommonTextFormFieldWidget(
        style: getIt<AddressStyles>().getTextFieldStyle(context),
        cursorHeight: Dimens.size20,
        controller: controller,
        label: label,
        errorMsg: errorMsg,
        input: inputAction,
        focusNode: focusNode,
        textInputType: textInputType,
        inputFormatters: inputFormatters,
        readOnly: readOnly,
        maxLength: maxLength,
        onTextSubmit: (String value) {
          onNextField?.call();
        },
        onChange: onValidation,
      ),
    );
  }
}
