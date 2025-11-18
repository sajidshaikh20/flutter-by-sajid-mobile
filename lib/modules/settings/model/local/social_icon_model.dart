import '../../../../utils/exports.dart';

/// Model class for social media icon data.
class SocialIconModel {
  /// The SVG image for the social media icon.
  SvgGenImage? itemImage;

  /// The URL to navigate to when the icon is tapped.
  String url;

  /// Creates an instance of [SocialIconModel].
  SocialIconModel({
    required this.itemImage,
    required this.url,
  });
}
