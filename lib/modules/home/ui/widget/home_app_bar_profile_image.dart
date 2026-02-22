import '../../../../utils/exports.dart';

/// Circular profile image or placeholder icon for the home app bar.
class HomeAppBarProfileImage extends StatelessWidget {
  const HomeAppBarProfileImage({
    super.key,
    this.profileImagePath,
    this.textColor,
  });

  final String? profileImagePath;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return _ProfileImageFrame(
      child: _ProfileImageContent(
        profileImagePath: profileImagePath,
        textColor: textColor ?? MainConfig.appColors.textWhiteColor,
      ),
    );
  }
}

/// Sub-widget: rounded container and clip for the profile image.
class _ProfileImageFrame extends StatelessWidget {
  const _ProfileImageFrame({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimens.size50,
      height: Dimens.size50,
      decoration: BoxDecoration(
        borderRadius: Dimens.radius24.borderRadius,
        color: MainConfig.appColors.imageBgColor,
      ),
      child: ClipRRect(
        borderRadius: Dimens.radius24.borderRadius,
        child: child,
      ),
    );
  }
}

/// Sub-widget: asset image or placeholder icon.
class _ProfileImageContent extends StatelessWidget {
  const _ProfileImageContent({
    required this.profileImagePath,
    required this.textColor,
  });

  final String? profileImagePath;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    if (profileImagePath != null) {
      return Image.asset(
        profileImagePath!,
        height: Dimens.size50,
        width: Dimens.size50,
        fit: BoxFit.cover,
      );
    }
    return Icon(
      Icons.person,
      size: Dimens.size34,
      color: textColor,
    );
  }
}
