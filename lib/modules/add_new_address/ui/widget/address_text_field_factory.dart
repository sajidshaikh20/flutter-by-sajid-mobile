import '../../../../utils/exports.dart';

/// Factory class for creating AddressTextField widgets from configuration.
/// 
/// This factory provides a static method to create AddressTextField instances
/// based on configuration objects, ensuring consistent field creation.
class AddressTextFieldFactory {
  /// Private constructor to prevent instantiation.
  AddressTextFieldFactory._();

  /// Creates an AddressTextField from the provided configuration.
  /// 
  /// Takes an [AddressFieldConfig] object and returns a configured
  /// [AddressTextField] widget with all the specified properties.
  static AddressTextField fromConfig(AddressFieldConfig config) {
    return AddressTextField(
      controller: config.controller,
      label: config.label,
      errorMsg: config.errorMsg,
      focusNode: config.focusNode,
      nextFocusNode: config.nextFocusNode,
      maxLength: config.maxLength,
      inputAction: config.inputAction,
      textInputType: config.textInputType,
      inputFormatters: config.inputFormatters,
      readOnly: config.readOnly,
      validationType: config.validationType,
      onValidation: config.onValidation,
      onNextField: config.onNextField,
    );
  }
}

