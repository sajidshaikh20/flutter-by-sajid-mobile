import '../../../../utils/exports.dart';

/// [EditFilterPage] is a StatelessWidget that displays the edit filter page.
class EditFilterPage extends StatelessWidget {
  /// Creates a [EditFilterPage].
  const EditFilterPage(
      {super.key, this.filterData, this.device = ScreenType.mobile});

  /// [filterData] contains the filter data from API.
  final GetFilterData? filterData;

  /// [device] is the device type, it can be mobile or tablet.
  final ScreenType device;

  /// Check if any filters are currently selected
  bool _hasAnyFiltersSelected(FilterPageState state) {
    // Check if any brands are selected
    if (state.selectedBrandIds.isNotEmpty) {
      return true;
    }

    // Check if any categories are selected
    if (state.selectedCategoryIds.isNotEmpty) {
      return true;
    }

    // Check if price range is different from backend defaults
    if (state.selectedPriceRange != null && state.filterData?.price != null) {
      final double backendMin = state.filterData!.price!.minPrice ?? 0;
      final double backendMax = state.filterData!.price!.maxPrice ?? 0;

      // If price range is different from backend defaults, consider it selected
      if (state.selectedPriceRange!.start != backendMin ||
          state.selectedPriceRange!.end != backendMax) {
        return true;
      }
    }

    // No filters selected
    return false;
  }

  @override
  Widget build(BuildContext context) {
    double btnContainerHeight = Dimens.size88;
    double oopsFontSize = Dimens.fontSize20;
    double noDataFontSize = Dimens.fontSize16;
    switch (device) {
      case ScreenType.tablet:
        btnContainerHeight = Dimens.size90;
        oopsFontSize = Dimens.fontSize24;
        noDataFontSize = Dimens.fontSize20;
      default:
        break;
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ProductDetailsAppBar(
            onTap: () async {
              // Clear all filters
              context.read<FilterPageCubit>().clearAllFilters();

              // Navigate back to PLP with empty filter data
              DebugLog.instance.i('Clear All tapped - navigating back to PLP with empty filters');
             /* await context.router.maybePop(<String, dynamic>{
                'filterData': <Map<String, dynamic>>[], // Empty filter data
              });*/
            },
            titleText: context.appString.filterKey,
            isLastWidgetClearAll: true,
            prefixIcon: Assets.svgs.icCloseIcon
                .svg(height: Dimens.size24, width: Dimens.size24),
          ),
          const SizedBox(
            height: Dimens.size1,
          ),
          Expanded(
            child: Column(children: <Widget>[
              Visibility(
                visible: filterData != null &&
                    ((filterData!.brand?.isNotEmpty ?? false) ||
                        (filterData!.category?.isNotEmpty ?? false) ||
                        (filterData!.price != null)),
                replacement: Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        CommonLottieAnimation(
                          assetPath: Assets.json.noOffer,
                          repeat: false,
                          height: Dimens.size130,
                          width: Dimens.size130,
                        ),
                        CustomTextLabelWidget(
                          label: MainConfig.dynamicString(
                              JsonServiceString.keyOops),
                          style: context.textTheme.titleLarge?.copyWith(
                              color: MainConfig.appColors.textBlackColor,
                              fontSize: oopsFontSize),
                        ),
                        CustomTextLabelWidget(
                          label: MainConfig.dynamicString(
                              JsonServiceString.keyNoFiltersAvailable),
                          style: context.textTheme.bodyLarge?.copyWith(
                              color: AppColors.greyMediumColor,
                              fontSize: noDataFontSize),
                        ),
                      ],
                    ),
                  ),
                ),
                child: Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FilterMainCategory(
                        device: device,
                      ),
                      FilterSubCategory(
                        device: device,
                      ),
                    ],
                  ),
                ),
              )
            ]),
          ),
          Visibility(
            visible: filterData != null &&
                ((filterData!.brand?.isNotEmpty ?? false) ||
                    (filterData!.category?.isNotEmpty ?? false) ||
                    (filterData!.price != null)),
            child: Container(
              alignment: Alignment.topCenter,
              decoration: BoxDecorationExtension.customDecoration(
                  color: AppColors.whiteColor,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: AppColors.blackColor.withValues(alpha: Dimens.opacity02),
                      offset: const Offset(Dimens.offset1, Dimens.zero),
                      blurRadius: Dimens.blurRadius2,
                    )
                  ]),
              height: btnContainerHeight,
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimens.space16, vertical: Dimens.space5),
              child: BlocBuilder<FilterPageCubit, FilterPageState>(
                builder: (BuildContext context, FilterPageState state) {
                  // Check if any filters are selected
                  final bool hasSelectedFilters = _hasAnyFiltersSelected(state);

                  return CustomGradientButtonWidget(
                    width: double.maxFinite,
                    title: context.appString.applyKey,
                    onTap: hasSelectedFilters ? () async {
                      // Get current filter selections in the required format
                      final List<Map<String, dynamic>> filterSelections = context
                          .read<FilterPageCubit>()
                          .getFilterSelections();

                      DebugLog.instance.i('Applying filters: $filterSelections');
                      // Debug current state before applying
                      // Return the filter selections
                      await context.router.maybePop(<String, dynamic>{
                        'filterData': filterSelections,
                      });
                    } : () {}, // Empty function when disabled
                    isButtonEnabled: hasSelectedFilters, // Enable/disable based on filter selection
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
