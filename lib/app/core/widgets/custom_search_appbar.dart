import '../../../utils/exports.dart';

/// A custom [PreferredSizeWidget] AppBar widget designed to include
/// a back button, an optional logo, and a search bar.
///
/// This widget can adapt its layout for mobile and tablet devices
/// using the [device] parameter.
///
/// Example usage:
/// ```dart
/// CustomSearchAppBar(
///   title: "Home",
///   onTap: () => print("Back tapped"),
///   isSearchTabVisible: true,
///   device: ScreenType.mobile,
/// )
/// ```
class CustomSearchAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  /// The title text to display on the app bar.
  final String? title;

  /// Callback triggered when the back icon is tapped.
  final Function()? onTap;

  /// Callback triggered when the search view is tapped.
  final Function()? onSearchViewClicked;

  /// Whether the logo is visible in the app bar.
  final bool? isLogoVisible;

  /// Whether the back icon is visible in the app bar.
  final bool? isBackIconVisible;

  /// Whether the search tab is visible in the app bar.
  final bool isSearchTabVisible;

  /// The type of device (mobile or tablet) to adjust layout accordingly.
  final ScreenType device;

  /// The preferred size of the app bar.
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  /// Creates a [CustomSearchAppBar].
  ///
  /// The [isSearchTabVisible] defaults to `true`.
  /// The [isBackIconVisible] defaults to `false`.
  /// The [device] defaults to [ScreenType.mobile].
  const CustomSearchAppBar({
    super.key,
    this.title = "",
    this.onTap,
    this.onSearchViewClicked,
    this.isLogoVisible,
    this.isSearchTabVisible = true,
    this.isBackIconVisible = false,
    this.device = ScreenType.mobile,
  });

  @override
  Widget build(BuildContext context) {
    double fontSize = Dimens.fontSize13;
    double spaceMobTab8 = Dimens.space8;
    double customPadding = Dimens.space16;
    double customLeftPadding = Dimens.space12;
    double customTopPadding = Dimens.space8;
    double customBottomPadding = Dimens.space5;
    double constraintsMaxHeight = Dimens.size32;
    double constraintsMinHeight = Dimens.size22;

    switch (device) {
      case ScreenType.tablet:
        fontSize = Dimens.fontSize20;
        spaceMobTab8 = Dimens.space8;
        customPadding = Dimens.space32;
        customLeftPadding = Dimens.space24;
        customTopPadding = Dimens.space20;
        customBottomPadding = Dimens.space10;
        constraintsMaxHeight = Dimens.size38;
        constraintsMinHeight = Dimens.size30;
      default:
        break;
    }

    return ColoredBox(
      color: MainConfig.appColors.mainColor,
      child: Padding(
        padding: EdgeInsets.only(
          left: customLeftPadding,
          right: customPadding,
          bottom: customBottomPadding,
        ),
        child: Row(
          mainAxisAlignment: isSearchTabVisible
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
          children: <Widget>[
            Visibility(
              visible: isBackIconVisible ?? false,
              child: Padding(
                padding: EdgeInsets.only(top: spaceMobTab8, right: spaceMobTab8),
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: onTap ??
                          () {
                        context.router.removeLast();
                      },
                  child: RotatedIcon(
                    isLanguageAlignmentLTR: isLanguageAlignmentLTR,
                    iconWidget:
                    SvgPicture.asset(Assets.svgs.icBackArrow.path),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: isSearchTabVisible
                  ? device == ScreenType.mobile
                  ? Dimens.space27
                  : Dimens.size100
                  : Dimens.space0,
            ),
            Visibility(
              visible: isSearchTabVisible,
              child: Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: spaceMobTab8),
                  child: InkWell(
                    splashFactory: NoSplash.splashFactory,
                    splashColor: MainConfig.appColors.transparent,
                    highlightColor: MainConfig.appColors.transparent,
                    overlayColor:
                    WidgetStateProperty.all(Colors.transparent),
                    onTap: () async {
                    //  await context.router.push(const SearchRoute());
                    },
                    child: CustomTextFormFieldWidget(
                      decoration: InputDecoration(
                        disabledBorder: OutlineInputBorder(
                          borderRadius: Dimens.radius6.borderRadius,
                          borderSide:
                          const BorderSide(color: Colors.white),
                        ),
                        filled: true,
                        isDense: true,
                        fillColor: Colors.white,
                        hintText: context.appString.searchProductKey,
                        contentPadding: EdgeInsets.only(
                          right: isLanguageAlignmentLTR
                              ? 0
                              : customTopPadding,
                          left: isLanguageAlignmentLTR
                              ? customTopPadding
                              : 0,
                        ),
                        hintStyle: context.textTheme.bodySmall?.copyWith(
                          fontSize: fontSize,
                          color: MainConfig.appColors.textGreyMediumColor,
                        ),
                        suffixIconConstraints: BoxConstraints(
                          maxHeight: constraintsMaxHeight,
                          maxWidth: constraintsMaxHeight,
                          minHeight: constraintsMinHeight,
                          minWidth: constraintsMinHeight,
                        ),
                        suffixIcon: Padding(
                          padding: customBottomPadding.padding,
                          child: Assets.svgs.icSearch.svg(
                            height: Dimens.size22,
                            width: Dimens.size22,
                          ),
                        ),
                      ),
                      isEditable: false,
                      controller: TextEditingController(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
