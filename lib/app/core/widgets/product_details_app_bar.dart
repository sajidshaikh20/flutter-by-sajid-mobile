import '../../../utils/exports.dart';
import '../../../utils/refresh_helper.dart';

/// A customizable app bar widget for product detail screens.
///
/// This widget provides:
/// - A back button (optional custom icon)
/// - A title
/// - Optional trailing widgets such as "Clear All" or a search/cart widget
/// - An optional tab bar for category navigation
///
/// It supports RTL/LTR alignment automatically based on the current app language.
class ProductDetailsAppBar extends StatelessWidget {
  /// Creates a [ProductDetailsAppBar].
  ///
  /// [titleText] is required and displayed at the center of the app bar.
  const ProductDetailsAppBar({
    super.key,
    required this.titleText,
    this.prefixIcon,
    this.isLastWidgetDisplay = true,
    this.isLastWidgetClearAll = false,
    this.backgroundProductDetails = AppColors.whiteColor,
    this.titleColors = AppColors.blackColor,
    this.isShadowDisplay = true,
    this.onTapOfTheTabBar,
    this.tabLabels,
    this.onTap,
    this.endText,
    this.style,
  });

  /// The title text displayed in the app bar.
  final String titleText;

  /// An optional icon widget displayed before the title.
  ///
  /// Defaults to a back arrow icon if not provided.
  final Widget? prefixIcon;

  /// Whether the last widget (right side) should be displayed.
  final bool isLastWidgetDisplay;

  /// Whether the last widget should display a "Clear All" text instead of the default cart/search.
  final bool isLastWidgetClearAll;

  /// Background color of the app bar.
  final Color? backgroundProductDetails;

  /// Color of the title text.
  final Color? titleColors;

  /// Whether to display a shadow under the app bar.
  final bool isShadowDisplay;

  /// Callback when a tab in the tab bar is tapped.
  ///
  /// Only applies when [tabLabels] is provided.
  final Function(int)? onTapOfTheTabBar;

  /// A list of tab labels for displaying a [TabBar] below the title row.
  ///
  /// If null, no tab bar is displayed.
  /// Can contain either [CategoryResponseModel] or [ChildCategoryModel] objects.
  final List<dynamic>? tabLabels;

  /// Callback when the "Clear All" text or right-side widget is tapped.
  final Function()? onTap;

  /// Custom text for the last widget when [isLastWidgetClearAll] is true.
  ///
  /// Defaults to the localized "Clear All" text.
  final String? endText;

  /// Optional text style for the [endText].
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    bool isLanguageAlignmentLTR = context.isEnglishLanguage;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundProductDetails,
        boxShadow: isShadowDisplay
            ? <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.1
            ),
            offset: const Offset(0, 2),
            blurRadius: Dimens.blurRadius4,
          ),
        ]
            : null,
      ),
      child: Column(
        children: <Widget>[
          const SizedBox(height: Dimens.size66),
          Row(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    InkWell(
                      splashFactory: NoSplash.splashFactory,
                      splashColor: MainConfig.appColors.transparent,
                      highlightColor: MainConfig.appColors.transparent,
                      overlayColor: WidgetStateProperty.all(Colors.transparent),
                      onTap: () {
                        // Trigger home refresh when navigating back from PLP
                        context.refreshHomeData();
                        goBack(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: isLanguageAlignmentLTR ? Dimens.size10 : 0,
                          right: isLanguageAlignmentLTR ? 0 : Dimens.size10,
                        ),
                        child: RotatedIcon(
                          isLanguageAlignmentLTR: isLanguageAlignmentLTR,
                          iconWidget: prefixIcon ?? Assets.svgs.icBack.svg(),
                        ),
                      ),
                    ),
                    Dimens.size16.widthBox,
                    Flexible(
                      child: CustomTextLabelWidget(
                        maxLines: Dimens.maxLines01,
                        overflow: TextOverflow.ellipsis,
                        label: titleText,
                        style: context.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: titleColors,
                          fontSize: Dimens.fontSize16,
                          height: Dimens.lineHeight24.toLineHeight(Dimens.fontSize16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Dimens.size20.widthBox,
              isLastWidgetDisplay
                  ? isLastWidgetClearAll
                  ? InkWell(
                splashFactory: NoSplash.splashFactory,
                splashColor: MainConfig.appColors.transparent,
                highlightColor: MainConfig.appColors.transparent,
                overlayColor: WidgetStateProperty.all(Colors.transparent),
                onTap: onTap,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimens.space16),
                  child: CustomTextLabelWidget(
                    maxLines: Dimens.maxLines01,
                    overflow: TextOverflow.ellipsis,
                    label: endText ?? context.appString.clearAllKey,
                    style: style ??
                        context.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: Dimens.fontSize16,
                          color: MainConfig.appColors.mainColor,
                          height: Dimens.lineHeight30.toLineHeight(Dimens.fontSize16),
                        ),
                  ),
                ),
              )
                  : const CommonItemSearchCart()
                  : const SizedBox.shrink()
            ],
          ),
          tabLabels != null && tabLabels!.isNotEmpty ? Dimens.size24.heightBox : Dimens.size10.heightBox,
          tabLabels != null && tabLabels!.isNotEmpty
              ? DefaultTabController(
            length: tabLabels!.length,
            child: Container(
              decoration: BoxDecorationExtension.customDecoration(
                color: AppColors.whiteColor,
              ),
              height: Dimens.size30,
              child: Align(
                alignment: isLanguageAlignmentLTR ? Alignment.centerLeft : Alignment.centerRight,
                child: TabBar(
                  textScaler: TextScaler.noScaling,
                  onTap: onTapOfTheTabBar,
                  indicator: UnderlineTabIndicator(
                    borderRadius: Dimens.radius8.borderRadiusTopLeftTopRight,
                    borderSide: BorderSide(
                      width: Dimens.size4,
                      color: MainConfig.appColors.mainColor,
                    ),
                  ),
                  padding: const EdgeInsets.only(
                    bottom: Dimens.space1,
                    left: Dimens.space6,
                    right: Dimens.space6,
                  ),
                  unselectedLabelStyle: context.textTheme.headlineMedium?.copyWith(
                    fontSize: Dimens.fontSize14,
                    fontWeight: FontWeight.w600,
                    height: Dimens.lineHeight18.toLineHeight(Dimens.fontSize14),
                  ),
                  labelStyle: context.textTheme.headlineMedium?.copyWith(
                    fontSize: Dimens.fontSize14,
                    fontWeight: FontWeight.w700,
                    color: MainConfig.appColors.mainColor,
                    height: Dimens.lineHeight18.toLineHeight(Dimens.fontSize14),
                  ),
                  tabAlignment: TabAlignment.start,
                  labelPadding: const EdgeInsets.symmetric(horizontal: Dimens.space12),
                  isScrollable: true,
                  indicatorColor: MainConfig.appColors.mainColor,
                  labelColor: MainConfig.appColors.mainColor,
                  unselectedLabelColor: AppColors.blackColor,
                  tabs: tabLabels!
                      .map((dynamic subCategory) => Tab(
                    iconMargin: EdgeInsets.zero,
                    child: Text(subCategory is CategoryResponseModel
                        ? subCategory.categoryName.toString()
                        : subCategory is ChildCategoryModel
                            ? subCategory.categoryName.toString()
                            : 'Unknown'),
                  ))
                      .toList(),
                ),
              ),
            ),
          )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
