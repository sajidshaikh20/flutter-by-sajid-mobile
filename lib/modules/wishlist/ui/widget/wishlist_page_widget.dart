import '../../../../utils/exports.dart';

/// Widget that displays the wishlist page with products grid.
class WishlistPageWidget extends StatelessWidget {
  /// Creates a wishlist page widget.
  const WishlistPageWidget({super.key, this.device = ScreenType.mobile});

  /// The screen type for responsive design.
  final ScreenType device;

  @override
  Widget build(BuildContext context) {
    double crossAxisSpacing = Dimens.space11;
    final double itemWidth =
        (context.width - crossAxisSpacing - (Dimens.space10 * 2)) /
            2; // Width of each item
    final double itemHeight =
        itemWidth + Dimens.heightOfTheBottomContentWithOutImagePadding;
    return MultiBlocListener(
      listeners: <BlocListener<dynamic, dynamic>>[
        BlocListener<WishListCubit, WishListState>(
          listenWhen: (WishListState previous, WishListState current) {
            // Listen for cart operation messages (when message changes and is not empty)
            return previous.message != current.message &&
                (current.message.isNotEmpty) &&
                current.cartOperationStatus != BaseStateStatus.initial;
          },
          listener: (BuildContext context, WishListState state) {
            if (state.message.isNotEmpty) {
              displaySnackBar(state.message, context);
              context.read<WishListCubit>().clearMessage();
            }
          },
        ),
        BlocListener<WishListCubit, WishListState>(
          listenWhen: (WishListState previous, WishListState current) {
            // Listen for specific wishlist actions
            return previous.action != current.action;
          },
          listener: (BuildContext context, WishListState state) {
            switch (state.action) {
              case WishListAction.wishListDeletedSuccessfully:
                if (state.message.isNotEmpty) {
                  displaySnackBar(state.message, context);
                  context.read<WishListCubit>().clearMessage();
                }
              case WishListAction.wishListNoData:
                if (state.message.isNotEmpty) {
                  displaySnackBar(state.message, context);
                  context.read<WishListCubit>().clearMessage();
                }
              case WishListAction.wishListAddToCardProduct:
             //   displaySnackBar(state.addToCartModel?.message.toString() ?? "", context);
                context.read<WishListCubit>().clearMessage();
              case WishListAction.wishListUpdateCardProduct:
               // displaySnackBar(state.addToCartModel?.message.toString() ?? "", context);
                context.read<WishListCubit>().clearMessage();
              case WishListAction.wishListUpdateCardProductFailed:
                displaySnackBar(state.error.toString(), context);
                context.read<WishListCubit>().clearMessage();
              default:
                break;
            }
          },
        ),
      ],
      child: BlocBuilder<WishListCubit, WishListState>(
        builder: (BuildContext context, WishListState state) {
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
                          await context.read<WishListCubit>().refreshWishlist();
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
                )),
          );
        },
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
          await context.read<WishListCubit>().refreshWishlist();
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
          await context.read<WishListCubit>().refreshWishlist();
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
