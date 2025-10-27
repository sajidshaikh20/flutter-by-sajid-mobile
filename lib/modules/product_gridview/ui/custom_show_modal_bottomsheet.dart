import '../../../utils/exports.dart';

/// Shows a custom modal bottom sheet with configurable options.
/// 
/// Displays a bottom sheet with optional close icon, padding, and fullscreen mode.
Future<void> showCustomBottomSheetView(
    {required BuildContext context,
    required Widget child,
    required String title,
    TextStyle? titleStyle,
    bool? showPadding = true,
    bool bothExtremeEnd = false,
    bool isFullScreenBottomSheet = false,
    bool isCloseIconVisible = false,
    Color backgroundColor = AppColors.whiteColor}) async {
  return showModalBottomSheet(

      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      // Make the background transparent
      builder: (BuildContext context) {
        final double screenHeight = context.height;
        final double height =
            screenHeight - Dimens.size44; // Subtract 44 pixels from the top

        Widget bottomSheetContent = isFullScreenBottomSheet
            ? SizedBox(
                height: height,
                child: bottomSheetWidget(
                    isCloseIconVisible: isCloseIconVisible,
                    backgroundColor: backgroundColor,
                    title: title,
                    context: context,
                    bothExtremeEnd: bothExtremeEnd,
                    child: child,
                    isFullScreenBottomSheet: isFullScreenBottomSheet,
                    titleStyle: titleStyle),
              )
            : bottomSheetWidget(
                isCloseIconVisible: isCloseIconVisible,
                backgroundColor: backgroundColor,
                title: title,
                context: context,
                bothExtremeEnd: bothExtremeEnd,
                child: child,
                isFullScreenBottomSheet: isFullScreenBottomSheet,
                titleStyle: titleStyle);
        return SafeArea(
            child: AnimatedBottomSheetContent(child: bottomSheetContent));
      });
}
///bottomSheetWidget
Widget bottomSheetWidget(
    {required bool isCloseIconVisible,
    required Color backgroundColor,
    required String title,
    required BuildContext context,
    required bool bothExtremeEnd,
    required Widget child,
    required bool isFullScreenBottomSheet,
    TextStyle? titleStyle}) {
  return isFullScreenBottomSheet
      ? Column(
          children: <Widget>[
            commonContainerForHeader(
              backgroundColor,
              title,
              titleStyle,
              context,
              null,
              isCloseIconVisible: isCloseIconVisible,
              bothExtremeEnd: bothExtremeEnd,
            ),
            Expanded(child: ColoredBox(color: backgroundColor, child: child))
          ],
        )
      : Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (isCloseIconVisible)
              GestureDetector(
                onTap: () {
                  context.router.popForced();
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: Dimens.space14),
                  decoration: BoxDecorationExtension.customDecoration(
                      shape: BoxShape.circle, color: AppColors.blackColor),
                  height: Dimens.size40,
                  width: Dimens.size40,
                  padding: Dimens.space9.padding,
                  child: Assets.svgs.icCloseWhite.svg(
                      height: Dimens.size22,
                      width: Dimens.size22,
                      colorFilter: const ColorFilter.mode(
                        AppColors.whiteColor,
                        BlendMode.srcATop,
                      )),
                ),
              ),
            commonContainerForHeader(
              backgroundColor,
              title,
              titleStyle,
              context,
              child,
              isCloseIconVisible: isCloseIconVisible,
              bothExtremeEnd: bothExtremeEnd,
            )
          ],
        );
}
///commonContainerForHeader
Widget commonContainerForHeader(
    Color backgroundColor,
    String title,
    TextStyle? titleStyle,
    BuildContext context,
    Widget? child, {
    bool isCloseIconVisible = false,
    bool bothExtremeEnd = false,
  }) {
  return Container(
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: Dimens.radius16.borderRadiusTopLeftTopRight,
    ),
    width: double.maxFinite,
    padding: isCloseIconVisible
        ? const EdgeInsets.symmetric(
            horizontal: Dimens.space16, vertical: Dimens.space24)
        : null,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        isCloseIconVisible
            ? CustomTextLabelWidget(
                textAlign: TextAlign.start,
                label: title,
                style: titleStyle ??
                    context.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.blackColor,
                        fontSize: Dimens.fontSize18,
                        height: Dimens.lineHeight22
                            .toLineHeight(Dimens.fontSize18)),
              )
            : Padding(
                padding: bothExtremeEnd
                    ? const EdgeInsets.only(
                        left: Dimens.space16,
                        right: Dimens.space10,
                        top: Dimens.space10,
                      )
                    : const EdgeInsets.only(
                        left: Dimens.space16,
                        right: Dimens.space16,
                        top: Dimens.space13,
                      ),
                child: bothExtremeEnd
                    ? Row(
                        children: <Widget>[
                          CustomTextLabelWidget(
                            label: title,
                            style: titleStyle ??
                                context.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.blackColor,
                                  fontSize: Dimens.fontSize16,
                                  height: Dimens.lineHeight24
                                      .toLineHeight(Dimens.fontSize16),
                                ),
                          ),
                          const Spacer(),
                          GestureDetector(
                              onTap: () {
                                context.router.popForced();
                              },
                              child: Assets.svgs.icCloseIcon.svg())
                        ],
                      )
                    : Row(
                        // Ensure spacing
                        children: <Widget>[
                          // Cancel button
                          CustomTextLabelWidget(
                            onTap: () {
                              context.router.popForced();
                            },
                            label: context.appString.cancelKey,
                            style: context.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: MainConfig.appColors.mainColor,
                              fontSize: Dimens.fontSize16,
                              height: Dimens.lineHeight30
                                  .toLineHeight(Dimens.fontSize16),
                            ),
                          ),
                          // Sort By text (centered explicitly using Expanded)
                          const Spacer(),
                          CustomTextLabelWidget(
                            label: title,
                            style: titleStyle ??
                                context.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.blackColor,
                                  fontSize: Dimens.fontSize16,
                                  height: Dimens.lineHeight24
                                      .toLineHeight(Dimens.fontSize16),
                                ),
                          ),
                         const Spacer(),
                          // this widget is not visible it for maintainting center value
                          Visibility(
                            maintainSize: true,
                            maintainAnimation: true,
                            maintainState: true,
                            visible: false,
                            child: CustomTextLabelWidget(
                              textAlign: TextAlign.start,
                              label: context.appString.cancelKey,
                              style: context.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: MainConfig.appColors.mainColor,
                                fontSize: Dimens.fontSize16,
                                height: Dimens.lineHeight30
                                    .toLineHeight(Dimens.fontSize16),
                              ),
                            ),
                          )
                          // Spacer to balance out the layout
                          // Empty space to balance Cancel
                        ],
                      ),
              ),
        child ?? const SizedBox.shrink()
      ],
    ),
  );
}
