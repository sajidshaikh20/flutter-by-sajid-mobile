import 'exports.dart';

/// Utility class for address-related helper functions
class AddressUtils {
  /// Private constructor to prevent instantiation
  AddressUtils._();
  /// Gets the address icon based on address type
  static SvgGenImage getAddressIcon(String? addressType) {
    switch (addressType?.toLowerCase()) {
      case AppConstant.home:
        return Assets.svgs.icHomeLocation;
      case AppConstant.work:
      case AppConstant.office:
        return Assets.svgs.icOfficeLocation;
      default:
        return Assets.svgs.icOtherLocation;
    }
  }
  /// Formats the address for display

}
