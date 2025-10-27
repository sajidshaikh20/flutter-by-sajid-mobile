import '../../../../utils/exports.dart';


/// A widget to display sub-categories within a filter.
class FilterSubCategory extends StatelessWidget {
  /// Creates a [FilterSubCategory] widget.
  ///
  /// [device] determines the screen type, which can affect the UI layout and text sizes.
  const FilterSubCategory({super.key, this.device = ScreenType.mobile});

  /// The type of device, which affects UI elements like text size.
  final ScreenType device;

  @override
  Widget build(BuildContext context) {
    double filterTextSize = Dimens.fontSize14;
    switch (device) {
      case ScreenType.tablet:
        filterTextSize = Dimens.fontSize20;

      default:
        break;
    }

    return BlocBuilder<FilterPageCubit, FilterPageState>(
      builder: (BuildContext context, FilterPageState state) {
        final GetFilterData? filterData = state.filterData;
        final int mainIndex = state.filterMainIndex ?? 0;

        // Get available filter categories from cubit
        final List<String> filterCategories = context.read<FilterPageCubit>().getAvailableFilterCategories();

        if (mainIndex >= filterCategories.length) {
          return const SizedBox.shrink();
        }

        final String currentCategory = filterCategories[mainIndex];

        return SizedBox(
          width: (context.width / Dimens.space2) + Dimens.space50,
          child: currentCategory == 'price'
              ? BlocBuilder<FilterPageCubit, FilterPageState>(
                  builder: (BuildContext context, FilterPageState state) {
                    final GetFilterData? filterData = state.filterData;
                    final double? minValue = filterData?.price?.minPrice;
                    final double? maxValue = filterData?.price?.maxPrice;

                    return InteractiveRangeSlider(
                      minValue: minValue,
                      maxValue: maxValue,
                    );
                  },
                )
              : ListView.builder(
                  padding: EdgeInsets.zero,
                  itemBuilder: (BuildContext context, int index) {
                    // Get the appropriate data based on category
                    late final FilterBrand? item;
                    if (currentCategory == 'brand') {
                      item = filterData?.brand?[index];
                    } else if (currentCategory == 'category') {
                      item = filterData?.category?[index];
                    }

                    if (item == null) return const SizedBox.shrink();

                    return GestureDetector(
                      onTap: () {
                        // Make the entire row clickable
                        if (currentCategory == 'brand') {
                          context.read<FilterPageCubit>().toggleBrandOption(index);
                        } else if (currentCategory == 'category') {
                          context.read<FilterPageCubit>().toggleCategoryOption(index);
                        }
                      },
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(
                                left: Dimens.space14, right: Dimens.space16),
                            height: Dimens.size40,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: CustomTextLabelWidget(
                                    maxLines: Dimens.maxLines01,
                                    overflow: TextOverflow.ellipsis,
                                    label: item.name ?? '',
                                    textAlign: isLanguageAlignmentLTR
                                        ? TextAlign.left
                                        : TextAlign.right,
                                    style: context.textTheme.titleMedium
                                        ?.copyWith(
                                            color: AppColors.blackColor,
                                            height: Dimens.lineHeight18
                                                .toLineHeight(filterTextSize),
                                            fontSize: filterTextSize),
                                  ),
                                ),
                                CustomTextLabelWidget(
                                  label: item.count?.toString() ?? '0',
                                  textAlign: isLanguageAlignmentLTR
                                      ? TextAlign.left
                                      : TextAlign.right,
                                  style: context.textTheme.titleMedium
                                      ?.copyWith(
                                          color: MainConfig.appColors.greyTextColor,
                                          height: Dimens.lineHeight18
                                              .toLineHeight(filterTextSize),
                                          fontSize: filterTextSize),
                                ),
                                const SizedBox(
                                  width: Dimens.size12,
                                ),
                                CustomCheckbox(
                                  isChecked: (currentCategory == 'brand' && context.read<FilterPageCubit>().isBrandSelected(index)) ||
                                      (currentCategory == 'category' && context.read<FilterPageCubit>().isCategorySelected(index)),
                                  onChanged: (bool value) {
                                    if (currentCategory == 'brand') {
                                      context.read<FilterPageCubit>().toggleBrandOption(index);
                                    } else if (currentCategory == 'category') {
                                      context.read<FilterPageCubit>().toggleCategoryOption(index);
                                    }
                                  },
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: currentCategory == 'brand'
                      ? (filterData?.brand?.length ?? 0)
                      : currentCategory == 'category'
                          ? (filterData?.category?.length ?? 0)
                          : 0,
                ));
      },
      buildWhen: (FilterPageState previous, FilterPageState current) {
        return previous.filterData != current.filterData ||
            previous.filterMainIndex != current.filterMainIndex ||
            previous.selectedBrandIds != current.selectedBrandIds ||
            previous.selectedCategoryIds != current.selectedCategoryIds ||
            previous.selectedPriceRange != current.selectedPriceRange;
      },
    );
  }
}


