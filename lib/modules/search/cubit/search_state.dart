import '../../../../utils/exports.dart';

/// State for the search feature including input, validation, and results.
class SearchState extends BaseState {
  /// Creates a new instance of [SearchState].
  const SearchState({
    required super.status,
    required this.searchController,
    required this.formKey,
    super.msg = '',
    super.redirectRoute,
    this.showDefaultErrMsg = false,
    this.productListingResponse,
    this.isLoading,
    this.errorMessage,
    this.typeId,
    this.type,
    this.searchText = '',
  });

  /// The response containing the list of product search results.
  final BaseResponse<List<ProductListingResponse>>? productListingResponse;

  /// Whether the search is currently loading.
  final bool? isLoading;

  /// Error message to display if search fails.
  final String? errorMessage;

  /// The type ID for filtering search results.
  final int? typeId;

  /// The type name for filtering search results.
  final String? type;

  /// Controller for the search text field.
  final TextEditingController searchController;

  /// Form key to validate the search form.
  final GlobalKey<FormState> formKey;

  /// Current search text content for state tracking
  final String searchText;

  /// Last response returned by the search API.
  // final SearchResponseModel? response;
  /// Whether to show a default error message on failure.
  final bool? showDefaultErrMsg;

  @override
  List<Object?> get props => <Object?>[
        showDefaultErrMsg,
        productListingResponse,
        isLoading,
        errorMessage,
        typeId,
        type,
        searchText,
        ...super.props,
      ];

  /// Returns a copy with updated fields.
  SearchState copyWith({
    required BaseStateStatus? status,
    GlobalKey<FormState>? formKey,
    String? msg,
    PageRouteInfo? redirectRoute,
    String? successMsg,
    bool? showDefaultErrMsg,
    bool? isLoading,
    String? errorMessage,
    String? type,
    int? typeId,
    String? searchText,
    BaseResponse<List<ProductListingResponse>>? productListingResponse,
  }) {
    return SearchState(
      status: status ?? this.status,
      type: type,
      typeId: typeId,
      isLoading: isLoading,
      errorMessage: errorMessage,
      formKey: formKey ?? this.formKey,
      msg: msg,
      redirectRoute: redirectRoute,
      searchController: searchController,
      searchText: searchText ?? this.searchText,
      productListingResponse: productListingResponse ?? this.productListingResponse,
      showDefaultErrMsg: showDefaultErrMsg ?? this.showDefaultErrMsg,
    );
  }
}
