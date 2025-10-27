import '../../../utils/exports.dart';

/// A custom app bar widget for the application.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// The title of the app bar.
  final String? title;

  /// Callback function to be executed when the back button is tapped.
  final Function()? onTap;

  /// Callback function to be executed when the end button is clicked.
  final Function()? onEndButtonClick;

  /// Whether the logo should be visible.
  final bool? isLogoVisible;

  /// Whether the start logo should be visible.
  final bool? isStartLogoVisible;

  /// Whether the back icon should be visible.
  final bool isBackIconVisible;

  /// The text to be displayed on the end button.
  final String? endText;

  /// The text style for the end button text.
  final TextStyle? endTextStyle;

  /// The device screen type.
  final ScreenType device;

  @override
  Size get preferredSize => const Size.fromHeight(Dimens.size100);

  /// Creates a custom app bar widget.
  ///
  /// This widget provides a customizable app bar with options for a title,
  /// back button, end button, and logo visibility.
  const CustomAppBar({
    super.key,
    this.title = "",
    this.onTap,
    this.onEndButtonClick,
    this.isLogoVisible,
    this.isStartLogoVisible,
    this.isBackIconVisible = true,
    this.endText = "",
    this.endTextStyle,
    this.device = ScreenType.mobile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecorationExtension.customDecoration(
        color: AppColors.whiteColor,
        boxShadow: <BoxShadow>[
          const BoxShadow(
            color: AppColors.showdowGrey, // Shadow color with opacity
            blurRadius: Dimens.blurRadius10, // Softness of the shadow
            offset: Offset(0, Dimens.offset2), // Only bottom shadow
          ),
        ],
      ),
      height: Dimens.size100,
      child: Padding(
        padding: const EdgeInsets.only(
          left: Dimens.space10,
          right: Dimens.space16,
          bottom: Dimens.space10,
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            /// Back button (left)
            if (isBackIconVisible)
              Align(
                alignment: isLanguageAlignmentLTR ? Alignment.bottomLeft: Alignment.bottomRight,
                child: GestureDetector(
                  onTap: onTap ?? context.router.back,
                  child: RotatedIcon(
                    isLanguageAlignmentLTR: isLanguageAlignmentLTR,
                    iconWidget:
                    Assets.svgs.icBack.svg(
                      colorFilter: const ColorFilter.mode(
                        AppColors.blackColor,
                        BlendMode.srcIn,
                      ),
                    )
                  ),
                ),
              ),

            /// Title (centered)
            if (!(title?.isEmpty ?? true))
              CustomTextLabelWidget(
                label: title ?? '',
                style: context.textTheme.titleMedium?.copyWith(
                  height:
                  Dimens.lineHeight24.toLineHeight(Dimens.fontSize16),
                  fontSize: Dimens.fontSize16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),

            /// End button (right)
            if (!(endText?.isEmpty ?? true))
              Align(
                alignment: isLanguageAlignmentLTR ? Alignment.bottomRight : Alignment.bottomLeft,
                child: InkWell(
                  onTap: onEndButtonClick,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimens.space12,
                      vertical: Dimens.space5,
                    ),
                    decoration: const BoxDecoration(
                      borderRadius:
                      BorderRadius.all(Radius.circular(Dimens.space24)),
                      color: AppColors.whiteBlueColor,
                    ),
                    child: CustomTextLabelWidget(
                      label: endText ?? '',
                      style: endTextStyle ??
                          TextStyle(
                            fontSize: Dimens.fontSize16,
                            fontWeight: FontWeight.bold,
                            color: MainConfig.appColors.textWhiteColor,
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
