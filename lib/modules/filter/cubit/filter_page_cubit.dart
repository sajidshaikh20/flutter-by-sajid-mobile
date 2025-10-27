import '../../../utils/exports.dart';

/// Cubit for managing filter page state and options.
class FilterPageCubit extends BaseCubit<FilterPageState> {
  /// Optionally accepts filter data and selected filters to restore state.
  FilterPageCubit({
    GetFilterData? filterData,
    List<Map<String, dynamic>>? selectedFilters,
  }) : super(
          FilterPageState(
            filterData: filterData,
          ),
        ) {
    // Restore selected filters if provided
    if (selectedFilters != null && selectedFilters.isNotEmpty) {
      _restoreSelectedFilters(selectedFilters);
    }
  }

  /// Factory method to create an instance of FilterPageCubit.
  factory FilterPageCubit.instance({
    GetFilterData? filterData,
    List<Map<String, dynamic>>? selectedFilters,
  }) =>
      FilterPageCubit(
        filterData: filterData,
        selectedFilters: selectedFilters,
      );

  /// Restores previously selected filters from stored state
  void _restoreSelectedFilters(List<Map<String, dynamic>> filters) {
    for (final Map<String, dynamic> filter in filters) {
      final String code = filter['code'] as String;

      if (code == 'price') {
        // Restore price range
        final double minPrice = (filter['min_price'] as num).toDouble();
        final double maxPrice = (filter['max_price'] as num).toDouble();
        emit(state.copyWith(selectedPriceRange: RangeValues(minPrice, maxPrice)));

      } else if (code == 'brand' && filter['options'] != null) {
        // Restore brand selections
        final List<dynamic> options = filter['options'] as List<dynamic>;
        final List<int> brandIds = <int>[];

        for (final dynamic option in options) {
          if (option is Map<String, dynamic>) {
            final String? idString = option['id'] as String?;
            if (idString != null) {
              final int? id = int.tryParse(idString);
              if (id != null) {
                brandIds.add(id);
              }
            }
          }
        }

        final List<int> updatedSelectedBrandIds = List<int>.from(state.selectedBrandIds)
        ..addAll(brandIds);
        emit(state.copyWith(selectedBrandIds: updatedSelectedBrandIds));

      } else if (code == 'category' && filter['options'] != null) {
        // Restore category selections
        final List<dynamic> options = filter['options'] as List<dynamic>;
        final List<int> categoryIds = <int>[];

        for (final dynamic option in options) {
          if (option is Map<String, dynamic>) {
            final String? idString = option['id'] as String?;
            if (idString != null) {
              final int? id = int.tryParse(idString);
              if (id != null) {
                categoryIds.add(id);
              }
            }
          }
        }
        final List<int> updatedSelectedCategoryIds = List<int>.from(state.selectedCategoryIds)
        ..addAll(categoryIds);
        emit(state.copyWith(selectedCategoryIds: updatedSelectedCategoryIds));
      }
    }
  }

  /// Resets the error state.
  @override
  FilterPageState getResetErrorState() => state.copyWith(msg: '');

  /// Resets the redirection state.
  @override
  FilterPageState getResetRedirectionState() => state.copyWith();

  /// Selects a main filter category by index
  void selectMainFilter(int index) {
    emit(state.copyWith(filterMainIndex: index));
  }

  /// Toggles the selection of a brand option
  void toggleBrandOption(int optionIndex) {
    final GetFilterData? currentFilterData = state.filterData;
    if (currentFilterData == null || currentFilterData.brand == null || optionIndex >= currentFilterData.brand!.length) return;

    final FilterBrand selectedBrand = currentFilterData.brand![optionIndex];
    final int brandId = selectedBrand.id ?? 0;

    // Toggle selection
    final List<int> updatedSelectedBrandIds = List<int>.from(state.selectedBrandIds);
    if (updatedSelectedBrandIds.contains(brandId)) {
      updatedSelectedBrandIds.remove(brandId);
      DebugLog.instance.i('Brand deselected: ${selectedBrand.name} (ID: $brandId)');
    } else {
      updatedSelectedBrandIds.add(brandId);
      DebugLog.instance.i('Brand selected: ${selectedBrand.name} (ID: $brandId)');
    }

    emit(state.copyWith(selectedBrandIds: updatedSelectedBrandIds));
  }

  /// Toggles the selection of a category option
  void toggleCategoryOption(int optionIndex) {
    final GetFilterData? currentFilterData = state.filterData;
    if (currentFilterData == null || currentFilterData.category == null || optionIndex >= currentFilterData.category!.length) return;

    final FilterBrand selectedCategory = currentFilterData.category![optionIndex];
    final int categoryId = selectedCategory.id ?? 0;

    // Toggle selection
    final List<int> updatedSelectedCategoryIds = List<int>.from(state.selectedCategoryIds);
    if (updatedSelectedCategoryIds.contains(categoryId)) {
      updatedSelectedCategoryIds.remove(categoryId);
      DebugLog.instance.i('Category deselected: ${selectedCategory.name} (ID: $categoryId)');
    } else {
      updatedSelectedCategoryIds.add(categoryId);
      DebugLog.instance.i('Category selected: ${selectedCategory.name} (ID: $categoryId)');
    }

    emit(state.copyWith(selectedCategoryIds: updatedSelectedCategoryIds));
  }

  /// Updates the price range selection
  void updatePriceRange(double minPrice, double maxPrice) {
    // Store the exact values selected by user for persistence
    final RangeValues priceRange = RangeValues(minPrice, maxPrice);
    emit(state.copyWith(selectedPriceRange: priceRange));
  }

  /// Gets the available filter categories based on API data
  List<String> getAvailableFilterCategories() {
    final GetFilterData? filterData = state.filterData;
    if (filterData == null) return <String>[];

    final List<String> categories = <String>[];
    if (filterData.brand != null && filterData.brand!.isNotEmpty) {
      categories.add('brand');
    }
    if (filterData.category != null && filterData.category!.isNotEmpty) {
      categories.add('category');
    }
    if (filterData.price != null) {
      categories.add('price');
    }
    return categories;
  }

  /// Checks if a brand is selected
  bool isBrandSelected(int optionIndex) {
    final GetFilterData? currentFilterData = state.filterData;
    if (currentFilterData == null || currentFilterData.brand == null || optionIndex >= currentFilterData.brand!.length) return false;

    final FilterBrand brand = currentFilterData.brand![optionIndex];
    final int brandId = brand.id ?? 0;
    return state.selectedBrandIds.contains(brandId);
  }

  /// Checks if a category is selected
  bool isCategorySelected(int optionIndex) {
    final GetFilterData? currentFilterData = state.filterData;
    if (currentFilterData == null || currentFilterData.category == null || optionIndex >= currentFilterData.category!.length) return false;

    final FilterBrand category = currentFilterData.category![optionIndex];
    final int categoryId = category.id ?? 0;
    return state.selectedCategoryIds.contains(categoryId);
  }

  /// Clears all selected filters
  void clearAllFilters() {
    DebugLog.instance.i('Clearing all filters');

    // Reset to API default price range if available
    RangeValues? defaultPriceRange;
    if (state.filterData?.price != null) {
      final double minPrice = state.filterData!.price!.minPrice ?? 0.45;
      final double maxPrice = state.filterData!.price!.maxPrice ?? 240.0;
      defaultPriceRange = RangeValues(minPrice, maxPrice);
    }

    emit(state.copyWith(
      selectedBrandIds: <int>[],
      selectedCategoryIds: <int>[],
      selectedPriceRange: defaultPriceRange, // Reset price range to default
    ));
  }

  /// Gets the current filter selections in the required format for API request
  List<Map<String, dynamic>> getFilterSelections() {
    final List<Map<String, dynamic>> filterData = <Map<String, dynamic>>[];

    // Add price filter if selected
    if (state.selectedPriceRange != null) {
      filterData.add(<String, dynamic>{
        'code': 'price',
        'min_price': state.selectedPriceRange!.start,
        'max_price': state.selectedPriceRange!.end,
      });
    }

    // Add brand filter if brands are selected
    if (state.selectedBrandIds.isNotEmpty) {
      final List<Map<String, dynamic>> brandOptions = <Map<String, dynamic>>[];

      // Get the actual brand data from filterData
      if (state.filterData?.brand != null) {
        for (final FilterBrand brand in state.filterData!.brand!) {
          if (state.selectedBrandIds.contains(brand.id)) {
            brandOptions.add(<String, dynamic>{
              'id': brand.id?.toString(),
              'count': brand.count ?? 0,
            });
          }
        }
      }

      if (brandOptions.isNotEmpty) {
        filterData.add(<String, dynamic>{
          'code': 'brand',
          'options': brandOptions,
        });
      }
    }

    // Add category filter if categories are selected
    if (state.selectedCategoryIds.isNotEmpty) {
      final List<Map<String, dynamic>> categoryOptions = <Map<String, dynamic>>[];

      // Get the actual category data from filterData
      if (state.filterData?.category != null) {
        for (final FilterBrand category in state.filterData!.category!) {
          if (state.selectedCategoryIds.contains(category.id)) {
            categoryOptions.add(<String, dynamic>{
              'id': category.id?.toString(),
              'count': category.count ?? 0,
            });
          }
        }
      }

      if (categoryOptions.isNotEmpty) {
        filterData.add(<String, dynamic>{
          'code': 'category',
          'options': categoryOptions,
        });
      }
    }

    return filterData;
  }
}
