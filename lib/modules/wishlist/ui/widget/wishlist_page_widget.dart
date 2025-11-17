import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../utils/exports.dart';
import '../../../../app/providers/providers.dart';

/// Widget that displays the wishlist page with products grid.
class WishlistPageWidget extends ConsumerWidget {
  /// Creates a wishlist page widget.
  const WishlistPageWidget({super.key, this.device = ScreenType.mobile});

  /// The screen type for responsive design.
  final ScreenType device;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double crossAxisSpacing = Dimens.space11;
    final double itemWidth =
        (context.width - crossAxisSpacing - (Dimens.space10 * 2)) /
            2; // Width of each item
    final double itemHeight =
        itemWidth + Dimens.heightOfTheBottomContentWithOutImagePadding;
    
    // Listen to state changes
    ref.listen<WishListState>(
      wishListNotifierProvider,
      (WishListState? previous, WishListState next) {
        // Listen for cart operation messages (when message changes and is not empty)
        if (previous?.message != next.message &&
            next.message.isNotEmpty &&
            next.cartOperationStatus != BaseStateStatus.initial) {
          displaySnackBar(next.message, context);
          ref.read(wishListNotifierProvider.notifier).clearMessage();
        }
        
        // Listen for specific wishlist actions
        if (previous?.action != next.action) {
          switch (next.action) {
            case WishListAction.wishListDeletedSuccessfully:
              if (next.message.isNotEmpty) {
                displaySnackBar(next.message, context);
                ref.read(wishListNotifierProvider.notifier).clearMessage();
              }
            case WishListAction.wishListNoData:
              if (next.message.isNotEmpty) {
                displaySnackBar(next.message, context);
                ref.read(wishListNotifierProvider.notifier).clearMessage();
              }
            case WishListAction.wishListAddToCardProduct:
             //   displaySnackBar(next.addToCartModel?.message.toString() ?? "", context);
              ref.read(wishListNotifierProvider.notifier).clearMessage();
            case WishListAction.wishListUpdateCardProduct:
               // displaySnackBar(next.addToCartModel?.message.toString() ?? "", context);
              ref.read(wishListNotifierProvider.notifier).clearMessage();
            case WishListAction.wishListUpdateCardProductFailed:
              displaySnackBar(next.error.toString(), context);
              ref.read(wishListNotifierProvider.notifier).clearMessage();
            default:
              break;
          }
        }
      },
    );

    final WishListState state = ref.watch(wishListNotifierProvider);
    
    return NoInternetWidget(
      childWidget: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: <Widget>[
            HomeAppbar(
              isShadowDisplay: true,
              title: context.appString.wishlistKey,
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await ref.read(wishListNotifierProvider.notifier).refreshWishlist();
                },
                child: _buildWishlistContent(
                  context,
                  state,
                  itemWidth,
                  itemHeight,
                  crossAxisSpacing,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWishlistContent(BuildContext context, WishListState state, double itemWidth, double itemHeight, double crossAxisSpacing) {
    // Success state with wishlist items
   // final List<ProductListingResponse> products = state.wishlistModelWithProducts?.products ?? <ProductListingResponse>[];
    if (state.status == BaseStateStatus.failure) {
      return CustomNoDataWidget(
        key: const ValueKey<String>('empty_wishlist'),
        message: context.appString.emptyWishlistKey,
        description: context.appString.emptyWishlistDescKey,
        buttonText: context.appString.tryAgainKey,
        onButtonPressed: () async {
          final ProviderContainer container = ProviderScope.containerOf(context);
          await container.read(wishListNotifierProvider.notifier).refreshWishlist();
        },
      );
    }
    // Show empty state if action indicates no data - check this FIRST
    if (state.action == WishListAction.wishListNoData) {
      return CustomNoDataWidget(
        key: const ValueKey<String>('empty_wishlist'),
        message: context.appString.emptyWishlistKey,
        description: context.appString.emptyWishlistDescKey,
        buttonText: context.appString.tryAgainKey,
        onButtonPressed: () async {
          final ProviderContainer container = ProviderScope.containerOf(context);
          await container.read(wishListNotifierProvider.notifier).refreshWishlist();
        },
      );
    }

    // Show loading state only during initial load when we don't have any data yet
    // Or show shimmer during pull-to-refresh regardless of data presence
    if ((state.status == BaseStateStatus.loading && state.wishlistModelWithProducts == null) || state.isRefreshing) {
      return const ShimmerWishListView();
    }

    return Padding(
      padding: const EdgeInsets.only(left: Dimens.space10, right: Dimens.space10, top: Dimens.space16),
      child: Column(
        children: <Widget>[
          Expanded(
            child: GridView.builder(
              controller: state.scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: 2,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: itemWidth / itemHeight,
                crossAxisCount: AppConstant.crossAxisCount2, // Fixed number of columns
                crossAxisSpacing: crossAxisSpacing,
                mainAxisSpacing: crossAxisSpacing, // Vertical space between items
              ),
              itemBuilder: (BuildContext context, int index) {



                return const SizedBox();


              },
            ),
          ),
          // Show pagination loading indicator
          Visibility(
            visible: state.isLoadingMore,
            child: const CustomPaginationLoaderWidget(),
          ),
        ],
      ),
    );
  }
}
