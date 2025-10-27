import '../../../../utils/exports.dart';

/// Represents the model for selected filters in the category listing.
///
/// This model holds data related to filters, including whether an API call
/// is needed, the desired filter array, the list of filter options, and the
/// selected labels for the filters.
class SelectedFilterModel {

  /// Constructor for initializing [SelectedFilterModel] object.
  ///
  /// [doWeNeedToCallApi] - Flag to determine if an API call is required
  /// for updating or fetching filter results.
  /// [desiredArray] - The array representing the desired filters.
  /// [filterOptionList] - List of available filter options for the category.
  /// [selectedLabelsList] - List of selected labels or filters chosen by the user.
  const SelectedFilterModel({
    this.doWeNeedToCallApi,
    this.desiredArray,
    this.filterOptionList,
    this.selectedLabelsList,
  });

  /// Flag to determine if an API call is required for updating or fetching filter results.
  final bool? doWeNeedToCallApi;

  /// The array representing the desired filters selected by the user.
  final String? desiredArray;

  /// List of available filter options for the category.
  final List<LayeredData>? filterOptionList;

  /// List of selected labels or filters chosen by the user.
  final List<String>? selectedLabelsList;
}

/// Extension for the [SelectedFilterModel] to provide a convenient `copyWith`
/// method for creating modified copies of the model.
///
/// This method allows you to update specific fields of an existing
/// [SelectedFilterModel] instance while retaining the unchanged fields.
extension SelectedFilterModelExt on SelectedFilterModel {

  /// Creates a copy of the current [SelectedFilterModel] with optional updates.
  ///
  /// [doWeNeedToCallApi] - A new value for the [doWeNeedToCallApi] field,
  /// or the current value if not provided.
  /// [filterOptionList] - A new value for the [filterOptionList] field,
  /// or the current value if not provided.
  /// [selectedLabelsList] - A new value for the [selectedLabelsList] field,
  /// or the current value if not provided.
  /// [desiredArray] - A new value for the [desiredArray] field, or the
  /// current value if not provided.
  ///
  /// Returns a new instance of [SelectedFilterModel] with updated values.
  SelectedFilterModel copyWith({
    bool? doWeNeedToCallApi,
    List<LayeredData>? filterOptionList,
    List<String>? selectedLabelsList,
    String? desiredArray,
  }) =>
      SelectedFilterModel(
        doWeNeedToCallApi: doWeNeedToCallApi ?? this.doWeNeedToCallApi,
        desiredArray: desiredArray ?? this.desiredArray,
        filterOptionList: filterOptionList ?? this.filterOptionList,
        selectedLabelsList: selectedLabelsList ?? this.selectedLabelsList,
      );
}
