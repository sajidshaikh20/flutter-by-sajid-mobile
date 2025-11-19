import '../../../utils/exports.dart';

/// A custom widget for mobile number input with country code selection.
///
/// This widget provides a styled input field for mobile numbers along with a
/// dropdown to select the country code. It supports various customizations
/// such as read-only mode, custom error messages, and input validation.
class CustomMobileInputWidget extends StatelessWidget {
  /// Creates a [CustomMobileInputWidget].
  ///
  /// The [mobileNumberController] and [initialCountryCode] arguments must not be null.
  ///
  /// [mobileNumberController] : controls the mobile number input
  ///
  /// [initialCountryCode] : represent the country code.
  ///
  /// [isReadOnly] : make the widget readOnly true/false
  ///
  const CustomMobileInputWidget(
      {super.key,
      required this.mobileNumberController,
      required this.initialCountryCode,
      this.onCountryCodeChanged,
      this.focusNode,
      this.isReadOnly = false,
      this.textInputType,
      this.errorMessage,
      this.onChange,
      this.device = ScreenType.mobile});

  /// Controller for the mobile number input field.
  final TextEditingController mobileNumberController;

  /// Initial country code to display.
  final String initialCountryCode;

  /// Callback function when the country code changes.
  final Function(String?)? onCountryCodeChanged;

  /// Determines if the input field is read-only.
  final bool? isReadOnly;

  /// Focus node for the input field.
  final FocusNode? focusNode;

  /// Type of keyboard to display for the input field.
  final TextInputAction? textInputType;

  /// Error message to display if validation fails.
  final String? errorMessage;

  /// Callback function when the text field value changes.
  ///
  /// This callback is invoked whenever the text in the input field changes.
  /// It provides the new text as a parameter.
  ///
  ///
  final ValueChanged<String>? onChange;
/// Determines the screen type for the widget.
  final ScreenType device;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildMobileNumberInput(context),
      ],
    );
  }

  Widget _buildMobileNumberInput(BuildContext context) {
    return Flexible(
      flex: Dimens.flex3,
      child: CommonTextFormFieldWidget(
        prefixIcon: CustomTextLabelWidget(
          textDirection: TextDirection.ltr,
          label: context.appString.kuwaitCountryCodeKey,
          style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              height: Dimens.lineHeight24.toLineHeight(Dimens.fontSize16),
              fontSize: Dimens.fontSize16),
        ),
        device: device,
        errorMsg: errorMessage,

        prefixIconConstraints: const BoxConstraints(
          minWidth: Dimens.size12,
          minHeight: Dimens.size24,
          maxWidth: Dimens.size62,
          maxHeight: Dimens.size50,
        ),
        onChange: onChange,
        readOnly: isReadOnly ?? false,
        focusNode: focusNode,
        controller: mobileNumberController,
        label: context.appString.mobileNumberKey ,
        textInputType: TextInputType.number,
        input: TextInputAction.next,
        maxLength: Dimens.maxLength8,
        onTextSubmit: (String value) {
          //FocusScope.of(context).requestFocus(context.instance<RequestCallbackCubit>().state.writeAMessageFocusNode);
        },
        inputFormatters: <TextInputFormatter>[
          LengthLimitingTextInputFormatter(Dimens.size8.toInt()),
          FilteringTextInputFormatter.digitsOnly
        ],
        validator: (dynamic value) {
          return value.toString().validateMobileField(
            emptyErrorMessage: "Enter valid number",
            lengthErrorMessage: "Please Enter Minimum 8 And Maximum 14 Digit Mobile Number",
          );
        },
        textCapitalization: TextCapitalization.none,
      ),
    );
  }
}
