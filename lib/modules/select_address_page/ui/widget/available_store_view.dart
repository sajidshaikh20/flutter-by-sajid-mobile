import '../../../../utils/exports.dart';

/// Widget that displays available stores for the selected address.
class AvailableStoresView extends StatelessWidget {
  /// Creates an available stores view widget.
  const AvailableStoresView({
    super.key,
    required this.addressCubit,
    required this.state,
  });

  /// The address cubit for managing address operations.
  final AddressCubit addressCubit;

  /// The current address state.
  final AddressState state;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectAddressCubit, SelectAddressState>(
      builder: (BuildContext context, SelectAddressState selectAddressState) {
        if (!selectAddressState.locationPermissionGranted) {
          return LocationPermissionView(
            onEnableLocationPressed: () async {
              await context
                  .read<SelectAddressCubit>()
                  .requestLocationPermission();
            },
          );
        }
        return ColoredBox(
          color: MainConfig.appColors.backgroundLightPinkColor,
          child: Column(
            children: <Widget>[
              Expanded(
                child: selectAddressState.apiCallForStore ==
                        BaseStateStatus.loading
                    ? SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: Dimens.size16,
                            vertical: Dimens.size10,
                          ),
                          child: CustomListView(
                            isPadding: true,
                            itemCount: AppConstant.itemCount5,
                            scrollController: ScrollController(),
                            itemBuilder: (BuildContext context, int index) {
                              return const SelectHomeOfficeItemShimmer();
                            },
                          ),
                        ),
                      )
                    : selectAddressState.apiCallForStore ==
                                BaseStateStatus.failure ||
                            selectAddressState.storeList.isEmpty
                        ? Center(
                            child: CustomNoDataWidget(
                              message: context.appString.noStoreFoundKey,
                              showImage: false,
                              asset: Assets.svgs.noStoreFound.svg(),
                              description: context.appString.noStoresAvailableInYourAreaKey,
                            ),
                          )
                        : SingleChildScrollView(
                            controller: selectAddressState.scrollController,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: Dimens.size16,
                                vertical: Dimens.size10,
                              ),
                              child: Column(
                                children: <Widget>[
                                  // Show store items
                                  ...selectAddressState.storeList.asMap().entries.map<Widget>((MapEntry<int, ListOfStoreResponse> entry) {
                                    final int index = entry.key;
                                    final ListOfStoreResponse store = entry.value;
                                    return Column(
                                      children: <Widget>[
                                        SelectAvailableStoreWidget(
                                          storeName: store.storeName ?? '',
                                          address: _buildStoreAddress(store),
                                          distance:
                                              "${store.distance?.toInt().toString() ?? ''} ${context.appString.kmKey}",
                                          itemsNotavailable:
                                              store.itemsNotAvailableNote ??
                                                  '',
                                          isItemsNotAvailable: store
                                                  .itemsNotAvailableNote
                                                  ?.isNotEmpty ??
                                              false,
                                          isSelected: selectAddressState
                                                  .selectedStoreIndex ==
                                              index &&
                                              selectAddressState
                                                  .selectedStoreIndex! >= 0,
                                          onTap: () {
                                            if (selectAddressState
                                                    .selectedStoreIndex ==
                                                index) {
                                              context
                                                  .read<SelectAddressCubit>()
                                                  .deselectStore();
                                            } else {
                                              context
                                                  .read<SelectAddressCubit>()
                                                  .selectStore(index);
                                            }
                                          },
                                        ),
                                        if (index ==
                                            selectAddressState
                                                    .storeList.length -
                                                1)
                                          const SizedBox(
                                              height: Dimens.size72),
                                      ],
                                    );
                                  }),
                                  Visibility(
                                    visible: selectAddressState.isPaginationLoading,
                                    child: const CustomPaginationLoaderWidget(),
                                  ),
                                ],
                              ),
                            ),
                          ),
              ),
              BlocBuilder<SelectAddressCubit, SelectAddressState>(
                buildWhen:
                    (SelectAddressState previous, SelectAddressState current) {
                  // Only rebuild when bottom button related state changes
                  return previous.selectedSegmentIndex !=
                          current.selectedSegmentIndex ||
                      previous.apiCallForStore != current.apiCallForStore ||
                      previous.storeList != current.storeList ||
                      previous.selectedStoreIndex != current.selectedStoreIndex;
                },
                builder: (BuildContext context, SelectAddressState state) {
                  if (state.selectedSegmentIndex == 1) {
                    // Show bottom shimmer during loading
                    if (state.apiCallForStore == BaseStateStatus.loading) {
                      return const StickBottomButtonView(
                        isOnlyOneButtonShow: true,
                        singleTitle: "", // Empty title for shimmer effect
                        isOnlyOneButtonEnabled: false,
                      );
                    }

                    // Show bottom button when stores are available and not loading
                    if (state.apiCallForStore == BaseStateStatus.success &&
                        state.storeList.isNotEmpty) {
                      bool isAnyStoreSelected =
                          state.selectedStoreIndex != null &&
                          state.selectedStoreIndex! >= 0;
                      return StickBottomButtonView(
                        isOnlyOneButtonShow: true,
                        singleTitle: context.appString.startShoppingKey,
                        isOnlyOneButtonEnabled: isAnyStoreSelected,
                        singleButtonClick: () async {
                          // Handle start shopping action
                          if (isAnyStoreSelected) {
                            final SelectAddressCubit cubit = context.read<SelectAddressCubit>();
                            final ListOfStoreResponse? selectedStore = cubit.getSelectedStore();
                            DebugLog.instance.d("Start shopping clicked for store: ${selectedStore?.toJson()}");
                            // Save selected store as address (navigation handled by BlocListener after save completes)
                            final bool saveSuccess = await cubit.saveSelectedStoreAsAddress(context);
                            if (saveSuccess && context.mounted) {
                              DebugLog.instance.d("Start shopping save successful, proceeding with navigation");
                               await context.read<HomeCubit>().loadSavedAddress();
                              if (context.mounted) {
                                // Only go back if not from store selection middleware
                                if (!state.isFromStoreSelection) {
                                  context.read<HomeCubit>().initializeSegmentIndex();
                                  context.read<HomeCubit>().refreshHomeData();
                                  await context.router.maybePop(true);
                                } else {
                                  await context.router.replaceAll(<PageRouteInfo>[const DashboardRoute()]);
                                }
                              }
                            } else {
                              DebugLog.instance.d("Start shopping save failed, aborting navigation");
                            }
                          } else {
                            // No store is selected, show validation message
                            DebugLog.instance.d("No store selected, showing validation message");
                            displaySnackBar(context.appString.pleaseSelectStoreBeforeContinuingKey, context);
                          }
                        },
                      );
                    }
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  /// Builds store address from API response.
  String _buildStoreAddress(ListOfStoreResponse store) {
    final List<String> addressParts = <String>[];

    if (store.street != null &&
        store.street.toString().isNotEmpty &&
        store.street != false) {
      addressParts.add(store.street.toString());
    }

    if (store.district?.isNotEmpty ?? false) {
      addressParts.add(store.district!);
    }

    if (store.city != null &&
        store.city.toString().isNotEmpty &&
        store.city != false) {
      addressParts.add(store.city.toString());
    }

    if (store.country?.isNotEmpty ?? false) {
      addressParts.add(store.country!);
    }

    return addressParts.isEmpty ? '' : addressParts.join(', ');
  }
}
