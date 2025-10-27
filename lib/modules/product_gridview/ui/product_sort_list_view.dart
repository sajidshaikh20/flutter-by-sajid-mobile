import '../../../utils/exports.dart';

/// Widget that displays a list of sorting options for products.
class ProductSortListView extends StatelessWidget {
  /// Creates a product sort list view widget.
  const ProductSortListView({
    required this.sortList,
    super.key,
    this.callBackFunction,
    this.selectedIndex = -1,
    this.device = ScreenType.mobile,
  });

  /// The list of sorting options to display.
  final List<SortingData>? sortList;

  /// Callback function called when a sort option is selected.
  final Function(SortingData model, int index)? callBackFunction;

  /// The index of the currently selected sort option.
  final int? selectedIndex;

  /// The screen type for responsive design.
  final ScreenType device;

  @override
  Widget build(BuildContext context) {
    double sortTextSize = Dimens.fontSize16;
    switch (device) {
      case ScreenType.tablet:
        sortTextSize = Dimens.fontSize20;

      case ScreenType.mobile:
      case ScreenType.desktop:
    }
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) => InkWell(
        onTap: () async {
          await context.router.maybePop();
          callBackFunction?.call(sortList?[index] ?? SortingData(), index);
        },
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                left: Dimens.space19,
                right: Dimens.space13,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: Dimens.space10),
                    child: CustomTextLabelWidget(
                      label: sortList?[index].label ?? '',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: MainConfig.appColors.textColorGreyBlack,
                        fontSize: sortTextSize,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: selectedIndex == index,
                    child: Assets.svgs.icTickIcon.svg(),
                  ),
                ],
              ),
            ),
            Divider(
              height: Dimens.space1,
              color: MainConfig.appColors.dividerGreyExtraLight,
            ),
          ],
        ),
      ),
      itemCount: sortList?.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}
