import '../../../utils/exports.dart';

/// State for managing filter page, including selected filters and options.
class FilterPageState extends BaseState {
  /// Constructor for managing filter page, including selected filters and
  /// options.
  const FilterPageState({
    super.status = BaseStateStatus.initial,
    super.msg = '',
    super.redirectRoute,
    this.filterMainIndex = 0,
    this.filterSubOptionIndex = -1,
    this.filterData,
    this.selectedBrandIds = const <int>[],
    this.selectedCategoryIds = const <int>[],
    this.selectedPriceRange,
    this.mainSelectedFilterList,
  });

  /// Index of the selected main filter option.
  final int? filterMainIndex;

  /// Index of the selected sub-option under the main filter.
  final int? filterSubOptionIndex;

  /// Filter data from API
  final GetFilterData? filterData;

  /// Selected brand IDs
  final List<int> selectedBrandIds;

  /// Selected category IDs
  final List<int> selectedCategoryIds;

  /// Selected price range
  final RangeValues? selectedPriceRange;

  /// List of main filters that have been selected by the user.
  final List<String>? mainSelectedFilterList;

  /// Creates a copy of the current state with optional modifications.
  FilterPageState copyWith({
    BaseStateStatus? status,
    PageRouteInfo? redirectRoute,
    String? msg,
    int? filterMainIndex,
    int? filterSubOptionIndex,
    GetFilterData? filterData,
    List<int>? selectedBrandIds,
    List<int>? selectedCategoryIds,
    RangeValues? selectedPriceRange,
    List<String>? mainSelectedFilterList,
  }) =>
      FilterPageState(
        status: status ?? this.status,
        redirectRoute: redirectRoute ?? this.redirectRoute,
        msg: msg ?? this.msg,
        filterMainIndex: filterMainIndex ?? this.filterMainIndex,
        filterSubOptionIndex: filterSubOptionIndex ?? this.filterSubOptionIndex,
        filterData: filterData ?? this.filterData,
        selectedBrandIds: selectedBrandIds ?? this.selectedBrandIds,
        selectedCategoryIds: selectedCategoryIds ?? this.selectedCategoryIds,
        selectedPriceRange: selectedPriceRange ?? this.selectedPriceRange,
        mainSelectedFilterList:
            mainSelectedFilterList ?? this.mainSelectedFilterList,
      );

  @override
  List<Object?> get props => <Object?>[
        status,
        msg,
        redirectRoute,
        filterMainIndex,
        filterSubOptionIndex,
        filterData,
        selectedBrandIds,
        selectedCategoryIds,
        selectedPriceRange,
        mainSelectedFilterList,
      ];
}
