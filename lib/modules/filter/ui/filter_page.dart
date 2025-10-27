import '../../../utils/exports.dart';

/// Page to display filter options and handle filter selection.
///
/// [filterData] contains all available filter data from API.
/// [selectedFilters] contains previously selected filters to restore state.
@RoutePage()
class FilterPage extends BaseResponsiveView {
  /// Filter data from API
  final GetFilterData? filterData;

  /// Previously selected filters to restore state
  final List<Map<String, dynamic>>? selectedFilters;


  ///Constructor filter page
  const FilterPage({
    super.key,
    this.filterData,
    this.selectedFilters,
  });

  @override
  Widget buildDesktopWidget(BuildContext context) {
    return _buildViews(context,ScreenType.desktop);
  }

  @override
  Widget buildMobileWidget(BuildContext context) {
    return _buildViews(context,ScreenType.mobile);
  }

  @override
  Widget buildTabletWidget(BuildContext context) {
    return _buildViews(context,ScreenType.tablet);
  }

  Widget _buildViews(BuildContext context,ScreenType device) {
    return BlocProvider<FilterPageCubit>(
      create: (BuildContext context) => FilterPageCubit.instance(
          filterData: filterData,
          selectedFilters: selectedFilters),
      child: EditFilterPage(filterData: filterData, device: device,),
    );
  }
}
