import '../../../../utils/exports.dart';

/// Configuration class for an individual address form field.
///
/// This class defines the properties required to build and validate a text input
/// field in an address form, including controller, label, validation rules, and focus behavior.
class AddressFieldConfig {
  /// Creates an [AddressFieldConfig].
  ///
  /// [controller] manages the text input.
  /// [label] is the visible label for the input field.
  /// [errorMsg] is the error message to display when validation fails.
  /// [focusNode] manages focus for this field.
  /// [nextFocusNode] is the focus node of the next field, used when moving focus on action.
  /// [maxLength] sets the maximum allowed characters.
  /// [inputAction] sets the keyboard action button (e.g., next, done).
  /// [textInputType] specifies the type of keyboard to show.
  /// [inputFormatters] define input restrictions (e.g., digits only).
  /// [readOnly] indicates whether the field is editable.
  /// [validationType] specifies the kind of validation to apply.
  /// [onValidation] is called whenever validation occurs.
  /// [onNextField] is called when moving to the next field.
  const AddressFieldConfig({
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

  /// Controller that manages the text input value.
  final TextEditingController controller;

  /// Label to display for the input field.
  final String label;

  /// Optional error message to show when validation fails.
  final String? errorMsg;

  /// Focus node for this field.
  final FocusNode? focusNode;

  /// Focus node of the next field for focus traversal.
  final FocusNode? nextFocusNode;

  /// Maximum number of characters allowed in this field.
  final int maxLength;

  /// Keyboard action for the input field (e.g., next, done).
  final TextInputAction inputAction;

  /// Type of keyboard to display for the input field (e.g., text, number).
  final TextInputType? textInputType;

  /// Input formatters to restrict or format user input.
  final List<TextInputFormatter>? inputFormatters;

  /// Whether the field is read-only.
  final bool readOnly;

  /// Type of validation to perform on this field.
  final ValidationType validationType;

  /// Callback invoked when validation occurs with the current text.
  final Function(String) onValidation;

  /// Optional callback to move to the next field or perform an action.
  final VoidCallback? onNextField;
}
