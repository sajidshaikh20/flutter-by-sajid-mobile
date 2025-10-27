import '../../../../utils/exports.dart';

///[StoreReceiptPageWidget] is responsible to show the list of store receipts
///in the store receipt section
class StoreReceiptPageWidget extends StatelessWidget {
  ///[device] is to check the type of device.
  ///
  ///by default its set to [ScreenType.mobile]
  const StoreReceiptPageWidget({super.key, this.device = ScreenType.mobile});

  ///[device] is the screen type (mobile, tablet, or desktop).
  final ScreenType device;

  @override
  Widget build(BuildContext context) {
    SizedBox heightBoxSize = Dimens.size14.heightBox;
    switch (device) {
      case ScreenType.tablet:
        heightBoxSize = Dimens.size18.heightBox;
      default:
        break;
    }

    return BlocListener<StoreReceiptCubit, StoreReceiptState>(
      listenWhen: (StoreReceiptState previous, StoreReceiptState current) =>
          previous.isSnackBarDisplay != current.isSnackBarDisplay,
      listener: (BuildContext context, StoreReceiptState state) async {
        if (state.isSnackBarDisplay) {
          displaySnackBar(state.error, context);
        }
      },
      child: NoInternetWidget(
        childWidget: Scaffold(
          backgroundColor: MainConfig.appColors.backgroundLightPinkColor,
          body: Column(
            children: <Widget>[
              ProductDetailsAppBar(
                titleText: context.appString.storeReceiptKey,
                isLastWidgetDisplay: false,
                titleColors: MainConfig.appColors.textBlackColor,
                prefixIcon: Assets.svgs.icBack.svg(),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left:  Dimens.space16,
                      right:  Dimens.space16,
                      top: Dimens.space16),
                  child: BlocBuilder<StoreReceiptCubit, StoreReceiptState>(
                    builder: (BuildContext context, StoreReceiptState state) {
                      // Show empty state if action indicates no data - check this FIRST
                      if (state.action == StoreReceiptAction.storeReceiptNoData) {
                        return CustomNoDataWidget(
                          key: ValueKey<String>('empty_store_receipts_${state.hashCode}'),
                          message: context.appString.noStoreReceiptAvailableKey,
                          description: context.appString.noStoreReceiptDescKey,
                          buttonText: context.appString.tryAgainKey,
                          asset: Assets.svgs.noStoreFound.svg(),
                          onButtonPressed: () async {
                            await context.read<StoreReceiptCubit>().refreshReceipts();
                          },
                        );
                      }
                      return RefreshIndicator(
                        onRefresh: () async {
                          DebugLog.instance.d('Pull to refresh triggered for store receipts');
                          await context.read<StoreReceiptCubit>().refreshReceipts();
                        },
                        child: SingleChildScrollView(
                          controller: state.scrollController,
                          child: Column(
                            children: <Widget>[
                              // Show shimmer for initial load or pull-to-refresh
                              if ((state.status == BaseStateStatus.loading && state.receiptList.isEmpty) || state.isRefreshing)
                                ...List<Widget>.generate(
                                  AppConstant.limitProduct,
                                  (int index) => const MyOrderItemShimmer(isHideStatus: false),
                                )
                              else
                                // Show receipt items
                                ...state.receiptList.asMap().entries.map<Widget>((MapEntry<int, StoreReceipt> entry) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: Dimens.space16,
                                    ),
                                    child: StoreReceiptItemView(
                                      position: entry.key,
                                      receiptList: state.receiptList,
                                      index: state.indexOfTheTabBar,
                                      device: device,
                                    ),
                                  );
                                }),
                              
                              // Show pagination loader when loading more
                              if (state.isLoadingMore)
                                const CustomPaginationLoaderWidget(),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              heightBoxSize,
            ],
          ),
        ),
      ),
    );
  }
}
