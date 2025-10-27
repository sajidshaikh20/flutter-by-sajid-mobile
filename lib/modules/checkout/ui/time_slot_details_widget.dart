import '../../../utils/exports.dart';

/// A widget that displays the time slot details for checkout.
/// This widget adjusts its layout based on the device type
/// (mobile, tablet, or desktop).
class TimeSlotDetailsWidget extends StatelessWidget {
  /// Creates a [TimeSlotDetailsWidget].
  ///
  /// The [state] parameter holds the current state of the checkout process,
  /// which includes the available time slots and the selected time slot.
  /// about the items in the cart, which might be used to calculate available
  /// time slots.
  /// The [device] parameter determines the layout based on the screen size:
  /// - [ScreenType.mobile] for mobile layout
  /// - [ScreenType.tablet] for tablet layout
  /// - [ScreenType.desktop] for desktop layout
  const TimeSlotDetailsWidget({
    required this.state,
    super.key,
    this.device = ScreenType.mobile,
  });

  /// The current state of the checkout process.
  ///
  /// This state contains available time slots and any other relevant checkout
  /// data, such as selected time slots.
  final CheckOutState state;

  /// The cart list response model containing details about
  /// the items in the cart.
  ///
  /// This is an optional parameter, which might be used to display available
  /// time slots or adjust the layout based on cart content.

  /// The device type (mobile, tablet, or desktop) to determine the layout.
  ///
  /// This variable allows the widget to adjust its layout and
  /// behavior according to
  /// the screen size or type of device.
  final ScreenType device;

  @override
  Widget build(BuildContext context) {
    double sizeMobTab1_2 = Dimens.space1;
    double timeSlotDateFontSize = Dimens.fontSize13;
    double timeSlotDayFontSize = Dimens.fontSize11;
    EdgeInsetsGeometry paddingMobTab3_5 = Dimens.space3.padding;
    double horizontalpaddingMobTab9_20 = Dimens.space9;
    double spaceMobTab90_110 = Dimens.space90;
    double shimmerHeight = Dimens.size30;
    double shimmerwidth = Dimens.size190;
    EdgeInsets shimmerPadding =
        const EdgeInsets.symmetric(horizontal: Dimens.space9);
    double pickDeliveryFontSize = Dimens.fontSize17;
    double mainAxisExtent = Dimens.space33;
    double mainAxisExtentForTime = Dimens.space33;
    double crossAxisSpacing = Dimens.crossAxisSpacing5;
    double mainAxisSpacing = Dimens.mainAxisSpacing5;
    double heightMobTab50_65 = Dimens.size55;
    switch (device) {
      case ScreenType.tablet:
        sizeMobTab1_2 = Dimens.space2;
        timeSlotDateFontSize = Dimens.fontSize17;
        heightMobTab50_65 = Dimens.size65;
        timeSlotDayFontSize = Dimens.fontSize15;
        paddingMobTab3_5 = Dimens.space5.padding;

        horizontalpaddingMobTab9_20 = Dimens.space20;
        spaceMobTab90_110 = Dimens.space110;
        shimmerHeight = Dimens.size45;
        shimmerwidth = Dimens.size220;
        shimmerPadding = const EdgeInsets.symmetric(horizontal: Dimens.space18);
        pickDeliveryFontSize = Dimens.fontSize22;
        mainAxisExtent = Dimens.space55;
        crossAxisSpacing = Dimens.crossAxisSpacing10;
        mainAxisSpacing = Dimens.mainAxisSpacing10;
        mainAxisExtentForTime = Dimens.space45;
      case ScreenType.mobile:
      case ScreenType.desktop:
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Dimens.size14.heightBox,
        Visibility(
          visible: state.timeSlotResponseModel != null &&
              state.startShowingShimmer == false,
          replacement: (state.startShowingShimmer ?? false)
              ? Padding(
                  padding: shimmerPadding,
                  child: ShimmerEffect(
                    child: CommonContainer(
                      padding: EdgeInsets.zero,
                      height: shimmerHeight,
                      width: shimmerwidth,
                      backgroundColor: MainConfig.appColors.backgroundWhiteColor,
                    ),
                  ),
                )
              : const SizedBox(),
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: horizontalpaddingMobTab9_20),
            child: CustomTextLabelWidget(
              label: MainConfig.dynamicString(
                JsonServiceString.keyPickADeliverySlot,
              ),
              textAlign: TextAlign.start,
              style: context.textTheme.titleMedium?.copyWith(
                fontSize: pickDeliveryFontSize,
                color: MainConfig.appColors.textDarkBlackColor,
              ),
            ),
          ),
        ),
        Visibility(
          visible: state.timeSlotResponseModel != null &&
              state.startShowingShimmer == false,
          replacement: (state.startShowingShimmer ?? false)
              ? ShimmerEffect(child: Dimens.size8.heightBox)
              : const SizedBox(),
          child: Dimens.size6.heightBox,
        ),
        Visibility(
          visible: state.timeSlotResponseModel != null &&
              state.startShowingShimmer == false,
          replacement: (state.startShowingShimmer ?? false)
              ? Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalpaddingMobTab9_20,
                  ),
                  child: SizedBox(
                    height: Dimens.size50,
                    child: ShimmerEffect(
                      child: ListView.builder(
                        itemBuilder: (BuildContext context, int index) => Row(
                          children: <Widget>[
                            CommonContainer(
                              padding: EdgeInsets.zero,
                              height: Dimens.size45,
                              width: Dimens.size80,
                              backgroundColor: MainConfig.appColors.backgroundWhiteColor,
                            ),
                            Dimens.space16.widthBox,
                          ],
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount: Dimens.maxLength4,
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: horizontalpaddingMobTab9_20),
            child: SizedBox(
              height: heightMobTab50_65,
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) => Row(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        context.read<CheckOutCubit>().onTapDate(index);
                      },
                      child: CommonContainer(
                        padding: Dimens.space6.padding,
                        boxDecoration: BoxDecorationExtension.customDecoration(
                          borderRadius: Dimens.radius5.borderRadius,
                          color: state.timeSlotData?[index].isSelected ?? false
                              ? MainConfig.appColors.backgroundPrimaryColor
                              : MainConfig.appColors.backgroundWhiteColor,
                          border: Dimens.borderWidth1.borderAll(
                            color: MainConfig.appColors.borderPrimaryColor,
                          ),
                        ),
                        childWidgets: Column(
                          children: <Widget>[
                            CustomTextLabelWidget(
                              label: state.timeSlotData?[index].date ?? '',
                              style: context.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: state.timeSlotData?[index].isSelected ??
                                        false
                                    ? MainConfig.appColors.textWhiteColor
                                    : MainConfig.appColors.textDarkBlackColor,
                                fontSize: timeSlotDateFontSize,
                              ),
                            ),
                            sizeMobTab1_2.heightBox,
                            CustomTextLabelWidget(
                              label: state.timeSlotData?[index].day ?? '',
                              style: context.textTheme.labelSmall?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: state.timeSlotData?[index].isSelected ??
                                        false
                                    ? MainConfig.appColors.textWhiteColor
                                    : MainConfig.appColors.textGreyDayColor,
                                fontSize: timeSlotDayFontSize,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Dimens.space10.widthBox,
                  ],
                ),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: state.timeSlotData?.length,
              ),
            ),
          ),
        ),
        Dimens.size12.heightBox,
        Visibility(
          visible: state.timeSlotResponseModel != null &&
              state.startShowingShimmer == false,
          replacement: (state.startShowingShimmer ?? false)
              ? Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalpaddingMobTab9_20,
                  ),
                  child: ShimmerEffect(
                    child: CommonGridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: Dimens.crossAxisCount2,
                        crossAxisSpacing: crossAxisSpacing,
                        mainAxisSpacing: mainAxisSpacing,
                        mainAxisExtent: mainAxisExtent,
                      ),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) =>
                          CommonContainer(
                        padding: EdgeInsets.zero,
                        height: shimmerHeight,
                        width: spaceMobTab90_110,
                        backgroundColor: MainConfig.appColors.backgroundWhiteColor,
                      ),
                      itemCount: Dimens.maxLength4,
                    ),
                  ),
                )
              : const SizedBox(),
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: horizontalpaddingMobTab9_20),
            child: CommonGridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: Dimens.crossAxisCount2,
                crossAxisSpacing: crossAxisSpacing,
                mainAxisSpacing: mainAxisSpacing,
                mainAxisExtent: mainAxisExtentForTime,
              ),
              itemBuilder: (BuildContext context, int index) => InkWell(
                onTap: () {
                  context.read<CheckOutCubit>().onTapSlot(index);
                },
                child: CommonContainer(
                  padding: paddingMobTab3_5,
                  boxDecoration: BoxDecorationExtension.customDecoration(
                    borderRadius: Dimens.radius5.borderRadius,
                    border: Dimens.borderWidth1.borderAll(
                      color: MainConfig.appColors.borderPrimaryColor,
                    ),
                    color:
                        state.selectedDateSlotData?[index].isSelected ?? false
                            ? MainConfig.appColors.backgroundPrimaryColor
                            : MainConfig.appColors.backgroundWhiteColor,
                  ),
                  childWidgets: buildCustomTextLabel(
                    context: context,
                    index: index,
                    isLanguageAlignmentLTR: isLanguageAlignmentLTR,
                  ),
                ),
              ),
              itemCount: state.selectedDateSlotData?.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
            ),
          ),
        ),
      ],
    );
  }

  /// Builds a custom text label widget to display the selected time slot
  /// based on the current device type and language alignment.
  ///
  /// The text label displays the time for a specific slot, and the style
  /// changes
  /// depending on whether the slot is selected or not. The font size adjusts
  /// based on
  /// the device type (mobile, tablet, or desktop), and the text direction is
  /// handled
  /// for both LTR (Left-to-Right) and RTL (Right-to-Left) languages.
  Widget buildCustomTextLabel({
    required bool
        isLanguageAlignmentLTR, // Whether the text is aligned left-to-right
    required int index, // The index of the selected date slot
    required BuildContext context, // The context to fetch text theme and styles
  }) {
    // Default font size for the selected date
    double selectedDateFontSize = Dimens.fontSize15;

    // Adjust the font size for tablet screens
    switch (device) {
      case ScreenType.tablet:
        selectedDateFontSize = Dimens.fontSize20;
      case ScreenType.mobile:
      case ScreenType.desktop:
    }

    // Create the text label widget with a dynamic style
    Widget content = CustomTextLabelWidget(
      label: state.selectedDateSlotData?[index].time ?? '',
      // The time for the selected slot
      style: context.textTheme.bodyMedium?.copyWith(
        fontWeight: FontWeight.w600, // Bold text for selected slot
        color: state.selectedDateSlotData?[index].isSelected ?? false
            ? MainConfig.appColors.textWhiteColor // White color if selected
            : MainConfig.appColors.textDarkBlackColor, // Dark black color if not selected
        fontSize: selectedDateFontSize, // Set the font size
      ),
    );

    // Adjust text direction for RTL languages
    if (!isLanguageAlignmentLTR) {
      content = Directionality(
        textDirection: TextDirection.ltr,
        // Force LTR direction for RTL languages
        child: content,
      );
    }

    return content; // Return the custom text label widget
  }
}
