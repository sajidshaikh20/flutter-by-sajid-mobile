import '../../../../utils/exports.dart';

/// [StickBottomButtonView] is a custom widget that displays a row of buttons
/// at the bottom of the screen. It can display one or two buttons depending on
/// the [isOnlyOneButtonShow] flag.
class StickBottomButtonView extends StatelessWidget {
  ///myOrderDetailResponseModel
  final MyOrderDetailResponseModel? myOrderDetailResponseModel;
  /// [isOnlyOneButtonShow] determines whether to show only one button or two.
  final bool isOnlyOneButtonShow;

  /// [singleTitle] is the text displayed on the single button. If [isOnlyOneButtonShow]
  /// is true, this will be the title of the displayed button. If [isOnlyOneButtonShow]
  /// is false and this is null, the second button's title will default to "Reorder".
  final String? singleTitle;

  /// [singleButtonClick] is the callback function that is executed when the single
  /// button is pressed. If [isOnlyOneButtonShow] is false, this callback will be
  /// executed when the second button is pressed.
  final VoidCallback? singleButtonClick;

  /// [isOnlyOneButtonEnabled] determines whether the single button is enabled or disabled.
  /// If [isOnlyOneButtonShow] is false, this flag will affect the second button.
  final bool isOnlyOneButtonEnabled;
///
  const StickBottomButtonView(
      {super.key,
      this.isOnlyOneButtonShow = false,
      this.singleTitle,
      this.myOrderDetailResponseModel,
      this.isOnlyOneButtonEnabled = true,
      this.singleButtonClick});

  @override
  Widget build(BuildContext context) {
    EdgeInsets commonContainerPadding = const EdgeInsets.symmetric(
      vertical: Dimens.space6,
      horizontal: Dimens.space16,
    );
    return Container(
      height: Dimens.size88,
      padding: commonContainerPadding,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: Dimens.opacity025),
            // Shadow color with opacity
            offset: const Offset(1, 0),
            // x: 1, y: 0
            blurRadius: Dimens.blurRadius4, // Blur radius
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (!isOnlyOneButtonShow)
            Expanded(
              child: CustomGradientButtonWidget(
                titleTextStyle: context.textTheme.headlineMedium?.copyWith(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.w700,
                  height: Dimens.lineHeight24.toLineHeight(Dimens.fontSize16),
                  fontSize: Dimens.fontSize16,
                ),
                title: context.appString.trackOrderKey,
                onTap: () async {
                  await context.router.push(TrackOrderRoute(
                      orderDetailsResponse : myOrderDetailResponseModel));
                },
              ),
            ),
          Dimens.space7.widthBox,
          Expanded(
            child: CustomGradientButtonWidget(
              isButtonEnabled: isOnlyOneButtonEnabled,
              titleTextStyle: context.textTheme.headlineMedium?.copyWith(
                color: AppColors.whiteColor,
                fontWeight: FontWeight.w700,
                height: Dimens.lineHeight24.toLineHeight(Dimens.fontSize16),
                fontSize: Dimens.fontSize16,
              ),
              title: singleTitle ?? context.appString.reOrderKey,
              onTap: singleButtonClick ?? () {},
            ),
          ),
        ],
      ),
    );
  }
}
