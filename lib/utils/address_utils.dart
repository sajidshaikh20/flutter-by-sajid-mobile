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

  /// Gets the address title based on address type
  static String getAddressTitle(MyAddressListingResponse address) {
    switch (address.addressType?.toLowerCase()) {
      case AppConstant.home:
        return MainConfig.context.appString.navHomeKey;
      case AppConstant.work:
      case AppConstant.office:
        return MainConfig.context.appString.workKey;
      default:
        return MainConfig.context.appString.otherKey;
    }
  }

  /// Formats the address for display
  static String formatAddress(MyAddressListingResponse address, {bool includeMobile = false}) {
    final List<String> addressParts = <String>[];

    // Add street
    if (address.mapAddress?.isNotEmpty ?? false) {
      addressParts.add(address.mapAddress!);
    }
    // Add mobile number if requested
    if (includeMobile && (address.mobileNo?.isNotEmpty ?? false)) {
      addressParts.add(' ${address.mobileNo}');
    }
    // If no parts, return a default message
    if (addressParts.isEmpty) {
      return '';
    }
    return addressParts.join(', ');
  }
}
