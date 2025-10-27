import '../../../utils/exports.dart';

/// State for managing home category data and the status of the request.
class HomeCategoryState extends BaseState {
  /// Constructor for managing home category data and the status of the request.
  HomeCategoryState({
    super.status = BaseStateStatus.initial,
    this.categoryData,
    this.categoriesModel,
    super.msg = '',
    super.redirectRoute,
    this.categoryList = const <CategoryResponseModel>[],
    this.totalCount = 0,
    this.currentPage = 1,
    this.hasMore = true,
    this.isLoadingMore = false,
    ScrollController? scrollController,
  }) : scrollController = scrollController ?? ScrollController();

  /// The home category data, if available, after a successful API call.
  final HomeCategoriesModel? categoryData;
  
  /// The categories data from API response
  final BaseResponse<List<CategoryResponseModel>>? categoriesModel;

  /// List of all loaded categories for pagination
  final List<CategoryResponseModel> categoryList;

  /// Total count of categories from API
  final int totalCount;

  /// Current page number for pagination
  final int currentPage;

  /// Whether there are more categories to load
  final bool hasMore;

  /// Whether currently loading more categories
  final bool isLoadingMore;

  /// Scroll controller for pagination
  final ScrollController scrollController;

  /// Creates a copy of the current state with optional modifications.
  HomeCategoryState copyWith({
    BaseStateStatus? status,
    String? msg,
    PageRouteInfo? redirectRoute,
    HomeCategoriesModel? categoryData,
    BaseResponse<List<CategoryResponseModel>>? categoriesModel,
    List<CategoryResponseModel>? categoryList,
    int? totalCount,
    int? currentPage,
    bool? hasMore,
    bool? isLoadingMore,
    ScrollController? scrollController,
  }) =>
      HomeCategoryState(
        status: status ?? this.status,
        redirectRoute: redirectRoute ?? this.redirectRoute,
        msg: msg ?? this.msg,
        categoryData: categoryData ?? this.categoryData,
        categoriesModel: categoriesModel ?? this.categoriesModel,
        categoryList: categoryList ?? this.categoryList,
        totalCount: totalCount ?? this.totalCount,
        currentPage: currentPage ?? this.currentPage,
        hasMore: hasMore ?? this.hasMore,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore,
        scrollController: scrollController ?? this.scrollController,
      );

  @override
  List<Object?> get props => <Object?>[
        status,
        msg,
        redirectRoute,
        categoryData,
        categoriesModel,
        categoryList,
        totalCount,
        currentPage,
        hasMore,
        isLoadingMore,
      ];
}
