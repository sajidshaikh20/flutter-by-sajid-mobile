import '../../../../utils/exports.dart';

///[MyOrderListingPageWidget] is responsible to show the list of orders
///in the my order section
class MyOrderListingPageWidget extends StatelessWidget {
  ///[device] is to check the type of device.
  ///
  ///by default its set to [ScreenType.mobile]
  const MyOrderListingPageWidget({super.key, this.device = ScreenType.mobile});

  ///[build] is responsible for building the widgets
  ///
  ///here we are handling the ui based on the device.
  final ScreenType device;

  @override
  Widget build(BuildContext context) {
    List<CategoryResponseModel> listCategoryAll = <CategoryResponseModel>[
      CategoryResponseModel(categoryName: context.appString.newKey),
      CategoryResponseModel(categoryName: context.appString.pastKey),
    ];
    SizedBox heightBoxSize = Dimens.size14.heightBox;
    switch (device) {
      case ScreenType.tablet:
        heightBoxSize = Dimens.size18.heightBox;

      default:
        break;
    }
    return BlocConsumer<MyOrderListCubit, MyOrderListState>(
      listener: (BuildContext context, MyOrderListState state) async {
        // Handle success message
        if (state.successMsg.isNotEmpty) {
          displaySnackBar(state.successMsg, context);
        }
        
        // Handle error message
        if (state.msg?.isNotEmpty ?? false) {
          displaySnackBar(state.msg!, context);
        }
        
        if (state.isSnackBarDisplay && state.redirectRoute != null) {
          showSuccessDialog(
            message: state.error.toString(),
            context: context,
            device: device,
            redirectRoute: state.redirectRoute!,
          );
        }
        if (state.status == BaseStateStatus.success) {
          if (state.redirectRoute != null &&
              (state.oderDetailsResponse != null)) {
            if (state.redirectRoute is TrackOrderRoute) {
              await context.router.push(TrackOrderRoute(
                  orderDetailsResponse: state.oderDetailsResponse ??
                      MyOrderDetailResponseModel()));
            }
          }
          
          // Handle cancel order redirect
          if (state.redirectRoute is MyAccountRoute) {
            if (context.mounted) {
              unawaited(context.router.replaceAll(<PageRouteInfo>[state.redirectRoute!]));
            }
          }
          
          // Handle reorder redirect to cart
          if (state.redirectRoute is CartListRoute) {
            if (context.mounted) {
              unawaited(context.router.push(state.redirectRoute!));
            }
          }
        }
      },
      buildWhen: (MyOrderListState previous, MyOrderListState current) {
        return previous.status != current.status ||
               previous.myOrderList != current.myOrderList ||
               previous.isLoadingMore != current.isLoadingMore ||
               previous.indexOfTheTabBar != current.indexOfTheTabBar;
      },
      builder: (BuildContext context, MyOrderListState state) {
        return Scaffold(
          backgroundColor: MainConfig.appColors.backgroundLightPinkColor,
          body: Column(
            children: <Widget>[
              ProductDetailsAppBar(
                isLastWidgetDisplay: false,
                onTapOfTheTabBar: (int value) async {
                  context.read<MyOrderListCubit>().changeIndexOfTheTab(value);
                  await context.read<MyOrderListCubit>().callMyOrderListApi(limit: 8, offset: 0);
                },
                tabLabels: listCategoryAll,
                titleText: context.appString.myOrdersKey,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: Dimens.space16),
                  child: _buildOrderListContent(context, state),
                ),
              ),
              heightBoxSize,
            ],
          ),
        );
      },
    );
  }

  /// Builds the order list content based on the current state
  Widget _buildOrderListContent(BuildContext context, MyOrderListState state) {
    // Show loading shimmer when API is loading
    if (state.status == BaseStateStatus.loading) {
      return CustomListView(
        isPadding: true,
        itemCount: AppConstant.limitProduct,
        itemBuilder: (BuildContext context, int index) {
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimens.space16),
            child: MyOrderItemShimmer(),
          );
        },
      );
    }

    // Show empty state when no orders found and API call was successful
    if (state.myOrderList.isEmpty /* && state.status == BaseStateStatus.success*/) {
      return CustomNoDataWidget(
        key: ValueKey<String>('empty_orders_${state.hashCode}'),
        message: context.appString.noOrdersFoundKey,
        description: context.appString.noOrdersFoundDescKey,
        buttonText: context.appString.tryAgainKey,
        onButtonPressed: () async {
          await context.read<MyOrderListCubit>().callMyOrderListApi(limit: 8, offset: 0);
        },
      );
    }

    // Show order list when orders are available
    return RefreshIndicator(
      onRefresh: () async {
        await context.read<MyOrderListCubit>().refreshOrders();
      },
      child: ListView.separated(
        controller: state.scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: state.myOrderList.length + (state.isLoadingMore ? 1 : 0),
        itemBuilder: (BuildContext context, int index) {
          // Show pagination loader at the bottom when loading more
          if (index == state.myOrderList.length && state.isLoadingMore) {
            return const Padding(
              padding: EdgeInsets.all(16.0),
              child: CustomPaginationLoaderWidget(),
            );
          }
          
          // Show order item
          return MyOrderListItemView(
            position: index,
            myOrder: state.myOrderList[index],
            index: index,
            isApiLoading: state.isApiLoading,
            device: device,
            isPastOrder: state.indexOfTheTabBar == 1,
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox.shrink(); // No separators needed
        },
      ),
    );
  }
}
