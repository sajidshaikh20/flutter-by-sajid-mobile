import '../../../utils/exports.dart';

/// Home category state. No model types — dynamic only.
class HomeCategoryState extends BaseState {
  HomeCategoryState({
    super.status = BaseStateStatus.initial,
    this.categoryData,
    this.categoriesModel,
    super.msg = '',
    super.redirectRoute,
    this.categoryList = const <dynamic>[],
    this.totalCount = 0,
    this.currentPage = 1,
    this.hasMore = true,
    this.isLoadingMore = false,
    ScrollController? scrollController,
  }) : scrollController = scrollController ?? ScrollController();

  final dynamic categoryData;
  final dynamic categoriesModel;
  final List<dynamic> categoryList;
  final int totalCount;
  final int currentPage;
  final bool hasMore;
  final bool isLoadingMore;
  final ScrollController scrollController;

  HomeCategoryState copyWith({
    BaseStateStatus? status,
    String? msg,
    PageRouteInfo? redirectRoute,
    dynamic categoryData,
    dynamic categoriesModel,
    List<dynamic>? categoryList,
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
