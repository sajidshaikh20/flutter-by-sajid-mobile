import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/exports.dart';
import '../state/home_category_state.dart';
import '../../home/repo/home_repository.dart';

/// Notifier for managing home category state (Riverpod version).
class HomeCategoryNotifier extends StateNotifier<HomeCategoryState> {
  /// Creates a home category notifier.
  HomeCategoryNotifier({required this.homeRepository})
      : super(HomeCategoryState()) {
    _initializeScrollListener();
  }

  /// Repository for fetching home category data.
  final HomeRepository homeRepository;

  /// Initialize scroll listener for infinite scroll pagination
  void _initializeScrollListener() {
    state.scrollController.addListener(_onScroll);
  }

  /// Handle scroll events for infinite scroll pagination
  void _onScroll() {
    if (state.scrollController.position.pixels >= 
        state.scrollController.position.maxScrollExtent - 200) {
      if (state.hasMore && !state.isLoadingMore) {
        unawaited(loadMoreCategories());
      }
    }
  }

  /// API call for the home categories
  Future<void> callHomeCategory({
    int? limit,
    int? offset,
  }) async {
    state = state.copyWith(status: BaseStateStatus.loading);

    final UserProfileService userProfileService = getIt<UserProfileService>();
    final LanguageService languageService = getIt<LanguageService>();
    final MainConfig mainConfig = getIt<MainConfig>();

    final int finalLimit = limit ?? AppConstant.limitCategoryList;
    final int finalOffset = offset ?? 0;

    final CategoryRequestModel categoryRequest = CategoryRequestModel(
        languageId: int.tryParse(languageService.languageId) ?? 1,
        customerToken: userProfileService.customerToken,
        platform: getPlatformName(),
        version: mainConfig.packageInfo.version,
        currency: languageService.defaultCurrency,
        storeId: 2,
        limit: finalLimit,
        offset: finalOffset);

    final ResponseHandler<BaseResponse<List<CategoryResponseModel>>> response =
        await homeRepository.getHomeCategoryList(categoryRequest);

    if (response.isSuccess()) {
      final OnSuccessResponse<BaseResponse<List<CategoryResponseModel>>>?
          successInstance = response.getSuccessInstance();

      if (successInstance != null) {
        final BaseResponse<List<CategoryResponseModel>> saveResponse =
            successInstance.response;
        if (saveResponse.success) {
          final List<CategoryResponseModel> newCategories = saveResponse.data ?? <CategoryResponseModel>[];
          final List<CategoryResponseModel> existingCategories = state.categoryList;
          final List<CategoryResponseModel> updatedCategories = 
              <CategoryResponseModel>[...existingCategories, ...newCategories];
          
          state = state.copyWith(
            categoryList: updatedCategories,
            hasMore: newCategories.length >= finalLimit,
            status: BaseStateStatus.success,
            isLoadingMore: false,
          );
        } else {
          state = state.copyWith(
            status: BaseStateStatus.failure,
            msg: saveResponse.message,
            isLoadingMore: false,
          );
        }
      }
    } else {
      state = state.copyWith(
        status: BaseStateStatus.failure,
        msg: response.getFailureInstance()?.error?.errorMessage ?? '',
        isLoadingMore: false,
      );
    }
  }

  /// Load more categories for pagination
  Future<void> loadMoreCategories() async {
    if (state.isLoadingMore || !state.hasMore) return;
    
    state = state.copyWith(isLoadingMore: true);
    await callHomeCategory(
      limit: AppConstant.limitCategoryList,
      offset: state.categoryList.length,
    );
  }

  @override
  void dispose() {
    state.scrollController.dispose();
    super.dispose();
  }
}

/// Provider for HomeRepository.
final Provider<HomeRepository> homeCategoryRepositoryProvider =
    Provider<HomeRepository>((Ref ref) {
  return HomeRepositoryImpl();
});

/// Provider for HomeCategoryNotifier.
final AutoDisposeStateNotifierProvider<HomeCategoryNotifier, HomeCategoryState> homeCategoryNotifierProvider =
    StateNotifierProvider.autoDispose<HomeCategoryNotifier, HomeCategoryState>(
  (AutoDisposeStateNotifierProviderRef<HomeCategoryNotifier, HomeCategoryState> ref) {
    final HomeRepository repository = ref.watch(homeCategoryRepositoryProvider);
    return HomeCategoryNotifier(homeRepository: repository);
  },
);

