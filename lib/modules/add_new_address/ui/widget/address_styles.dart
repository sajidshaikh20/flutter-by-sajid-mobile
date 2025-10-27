import '../../../../utils/exports.dart';

/// Comprehensive style utilities for address module
class AddressStyles {
  ///AddressStyles
  const AddressStyles();

  /// Common text field style used across all address form fields
  TextStyle getTextFieldStyle(BuildContext context) {
    return context.textTheme.titleLarge?.copyWith(
      height: Dimens.lineHeight30.toLineHeight(Dimens.fontSize16),
      fontWeight: FontWeight.w600,
      color: AppColors.blackColor,
      fontSize: Dimens.fontSize16,
    ) ?? const TextStyle();
  }

  /// Label style for address form fields
  TextStyle getLabelStyle(BuildContext context) {
    return context.textTheme.titleMedium?.copyWith(
      fontWeight: FontWeight.w500,
      color: AppColors.blackColor,
      fontSize: Dimens.fontSize14,
    ) ?? const TextStyle();
  }

  /// Error message style for address form fields
  TextStyle getErrorStyle(BuildContext context) {
    return context.textTheme.bodySmall?.copyWith(
      color: Colors.red,
      fontSize: Dimens.fontSize12,
    ) ?? const TextStyle();
  }

  /// Header style for address sections
  TextStyle getHeaderStyle(BuildContext context) {
    return context.textTheme.headlineSmall?.copyWith(
      fontWeight: FontWeight.w700,
      color: AppColors.blackColor,
      fontSize: Dimens.fontSize18,
    ) ?? const TextStyle();
  }

  /// Subtitle style for address sections
  TextStyle getSubtitleStyle(BuildContext context) {
    return context.textTheme.bodyMedium?.copyWith(
      fontWeight: FontWeight.w400,
      color: AppColors.greyColor,
      fontSize: Dimens.fontSize14,
    ) ?? const TextStyle();
  }

  /// Button text style for address actions
  TextStyle getButtonTextStyle(BuildContext context) {
    return context.textTheme.titleMedium?.copyWith(
      fontWeight: FontWeight.w600,
      color: AppColors.whiteColor,
      fontSize: Dimens.fontSize16,
    ) ?? const TextStyle();
  }

  /// Common padding for address form fields
  EdgeInsets getFieldPadding() {
    return const EdgeInsets.only(top: Dimens.fontSize16);
  }

  /// Common padding for address sections
  EdgeInsets getSectionPadding() {
    return const EdgeInsets.symmetric(
      horizontal: Dimens.size16,
      vertical: Dimens.size12,
    );
  }

  /// Common border radius for address form elements
  BorderRadius getBorderRadius() {
    return BorderRadius.circular(Dimens.radius8);
  }

  /// Common decoration for address form fields
  InputDecoration getInputDecoration(BuildContext context, String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: getBorderRadius(),
        borderSide: const BorderSide(color: AppColors.greyColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: getBorderRadius(),
        borderSide: const BorderSide(color: AppColors.greyColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: getBorderRadius(),
        borderSide: const BorderSide(color: Colors.blue),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: getBorderRadius(),
        borderSide: const BorderSide(color: Colors.red),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: Dimens.size12,
        vertical: Dimens.size8,
      ),
    );
  }

  /// Common box decoration for address containers
  BoxDecoration getContainerDecoration() {
    return BoxDecoration(
      color: AppColors.whiteColor,
      borderRadius: getBorderRadius(),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: AppColors.blackColor.withValues(alpha:0.1),
          blurRadius: Dimens.blurRadius4,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }
}

