import '../../../utils/exports.dart';

/// Widget that displays a list of selected filters with remove functionality.
class FilterSelectedListWidget extends StatelessWidget {
  /// Creates a filter selected list widget.
  const FilterSelectedListWidget({
    required this.filterSelectedList,
    required this.removeFilterSelectionTap,
    super.key,
    this.device = ScreenType.mobile,
  });

  /// The list of selected filter names to display.
  final List<String> filterSelectedList;

  /// Callback function called when a filter is tapped for removal.
  final Function(int index) removeFilterSelectionTap;

  /// The screen type for responsive design.
  final ScreenType device;

  @override
  Widget build(BuildContext context) {
    double height = Dimens.size50;
    double filterTextFontSize = Dimens.fontSize12;
    double closeIconSize = Dimens.size14;

    switch (device) {
      case ScreenType.tablet:
        height = Dimens.size65;
        filterTextFontSize = Dimens.fontSize17;
        closeIconSize = Dimens.size20;

      case ScreenType.mobile:
      case ScreenType.desktop:
    }

    return Visibility(
      visible: filterSelectedList.isNotEmpty,
      child: Container(
        height: height,
        alignment: isLanguageAlignmentLTR
            ? Alignment.centerLeft
            : Alignment.centerRight,
        decoration:  BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: MainConfig.appColors.shadowBlackColor,
              blurRadius: Dimens.blurRadius1,
              offset: const Offset(Dimens.offset0, Dimens.offset3),
            ),
          ],
          color: MainConfig.appColors.backgroundWhiteSmokeColor,
        ),
        child: Container(
          margin: EdgeInsets.only(
            right: isLanguageAlignmentLTR ? Dimens.zero : Dimens.space15,
            left: isLanguageAlignmentLTR ? Dimens.space15 : Dimens.zero,
            bottom: Dimens.space15,
          ),
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) => Container(
              margin: const EdgeInsets.only(right: Dimens.space4),
              decoration: BoxDecorationExtension.customDecoration(
                color: MainConfig.appColors.backgroundWhiteColor,
                border: Border.all(
                  color: MainConfig.appColors.borderDarkBlueColor,
                ),
                borderRadius: BorderRadius.circular(Dimens.space6),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: (context.width) < AppConstant.width380
                      ? Dimens.space2
                      : Dimens.space4,
                  horizontal: Dimens.space6,
                ),
                child: Row(
                  children: <Widget>[
                    CustomTextLabelWidget(
                      label: filterSelectedList[index],
                      style: context.textTheme.bodySmall?.copyWith(
                        fontSize: filterTextFontSize,
                        color: MainConfig.appColors.textDarkBlueColor,
                      ),
                    ),
                    Dimens.size10.widthBox,
                    InkWell(
                      onTap: () {
                        removeFilterSelectionTap.call(index);
                      },
                      child: Assets.svgs.icChipsClose.svg(
                        height: closeIconSize,
                        width: closeIconSize,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            itemCount: filterSelectedList.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
          ),
        ),
      ),
    );
  }
}
