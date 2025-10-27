import '../../../../utils/exports.dart';

/// Widget to display the main categories for filtering items.
///
/// [device] determines the layout based on screen type (mobile, tablet, desktop).
class FilterMainCategory extends StatelessWidget {
  /// Device type for responsive layout
  final ScreenType device;
///FilterMainCategory
  const FilterMainCategory({super.key, this.device = ScreenType.mobile});


  @override
  Widget build(BuildContext context) {
    double filterTextSize = Dimens.fontSize14;
    switch (device) {
      case ScreenType.tablet:
        filterTextSize = Dimens.fontSize18;

      default:
        break;
    }
    return BlocBuilder<FilterPageCubit, FilterPageState>(
      builder: (BuildContext context, FilterPageState state) {
        // Get available filter categories from cubit
        final List<String> availableCategories = context.read<FilterPageCubit>().getAvailableFilterCategories();

        // Convert to display names using localized strings
        final List<String> filterCategories = availableCategories.map((String category) {
          switch (category) {
            case 'brand':
              return context.appString.brandFilterKey;
            case 'category':
              return context.appString.categoryFilterKey;
            case 'price':
              return context.appString.priceFilterKey;
            default:
              return category;
          }
        }).toList();

        return Container(
          color: AppColors.whiteColor,
          width: (MediaQuery.of(context).size.width / Dimens.space2) -
              Dimens.space50,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemBuilder: (BuildContext context, int index) {
              final String categoryName = filterCategories[index];
              return GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  context.read<FilterPageCubit>().selectMainFilter(index);
                },
                child: ColoredBox(
                  color: state.filterMainIndex == index
                      ? MainConfig.appColors.backGroundForFilterColor
                      : AppColors.whiteColor,
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: Dimens.size40,
                        width: Dimens.space5,
                        decoration: state.filterMainIndex == index
                            ? BoxDecorationExtension.customDecoration(
                                color: MainConfig.appColors.mainColor,
                          borderRadius: BorderRadius.only(
                              topRight: context.isEnglishLanguage
                                  ? Dimens.radius8.circularRadius
                                  : Radius.zero,
                              bottomRight: context.isEnglishLanguage
                                  ? Dimens.radius8.circularRadius
                                  : Radius.zero,
                              bottomLeft: context.isEnglishLanguage
                                  ? Radius.zero
                                  : Dimens.radius8.circularRadius,
                              topLeft: context.isEnglishLanguage
                                  ? Radius.zero
                                  : Dimens.radius8.circularRadius),
                              )
                            : null,
                      ),
                      Dimens.space11.widthBox,
                      CustomTextLabelWidget(
                        label: categoryName,
                        style: context.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            height: Dimens.lineHeight16
                                .toLineHeight(filterTextSize),
                            color: state.filterMainIndex == index
                                ? MainConfig.appColors.mainColor
                                : AppColors.blackColor,
                            fontSize: filterTextSize),
                      )
                    ],
                  ),
                ),
              );
            },
            itemCount: filterCategories.length,
          ),
        );
      },
    );
  }
}
