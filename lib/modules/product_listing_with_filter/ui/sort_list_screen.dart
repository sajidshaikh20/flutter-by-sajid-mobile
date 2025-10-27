import '../../../../utils/exports.dart';

/// Widget that displays a list of sorting options for product listing.
class SortListScreen extends StatelessWidget {
  /// Creates a sort list screen widget.
  const SortListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductListingWithFilterCubit, ProductListingWithFilterState>(
      builder: (BuildContext context, ProductListingWithFilterState state) {

        return Container(
          color: MainConfig.appColors.backgroundWhite,
          padding: const EdgeInsets.only(bottom: Dimens.space20),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: AppConstant.sortOptions.length,
            itemBuilder: (BuildContext context, int index) {
              final SortOptionModel sortOption = AppConstant.sortOptions[index];
              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: Dimens.space11,
                      horizontal: Dimens.space16,
                    ),
                    child: SelectableIconRadio(
                      value: sortOption.id,
                      label: isLanguageAlignmentLTR ? sortOption.label: sortOption.arabicLabel,
                      groupValue: state.selectedSortOption?.id,
                      onChanged: (String? value) {
                        // Call the cubit to update sort option and refresh products
                        unawaited(context.read<ProductListingWithFilterCubit>().onSortOptionSelected(sortOption));
                        goBack(context);
                      },
                    ),
                  ),
                  CustomDivider(
                    color: MainConfig.appColors.dividerGreyColor,
                    height: Dimens.sizePoint5,
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
