import '../../../../utils/exports.dart';
import 'shimmer/store_location_item_shimmer.dart';

/// A responsive widget that displays store locations with filtering and
/// selection capabilities for different screen types.
class StoreLocationWidget extends BaseResponsiveView {
  /// The screen type (mobile, tablet, etc.) for responsive design.
  final ScreenType device;

  /// Creates a [StoreLocationWidget].
  ///
  /// [device] defaults to [ScreenType.mobile] if not specified.
  const StoreLocationWidget({super.key, this.device = ScreenType.mobile});

  /// Builds the location widget with appropriate padding based on device type.
  ///
  /// [context] is the build context.
  Widget buildLocation(BuildContext context) {
    double horizontalPadding = Dimens.space16;

    switch (device) {
      case ScreenType.tablet:
        horizontalPadding = Dimens.space32;
      default:
        break;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          ProductDetailsAppBar(
            onTap: () {
              // context.router.push(AddNewAddressRoute());
            },
            style: context.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: Dimens.fontSize14,
              color: MainConfig.appColors.mainColor,
              height: Dimens.lineHeight18.toLineHeight(Dimens.fontSize14),
            ),
            endText: context.appString.addNewKey,
            titleText: context.appString.storeLocationsKey,
            isLastWidgetClearAll: true,
            isLastWidgetDisplay: false,
            prefixIcon: Assets.svgs.icBack
                .svg(height: Dimens.size24, width: Dimens.size24),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
              ),
              child: BlocBuilder<StoreLocationsCubit, StoreLocationsState>(
                buildWhen: (StoreLocationsState previous, StoreLocationsState current) {
                  // Only rebuild when store-related state changes
                  return previous.apiCallForStore != current.apiCallForStore ||
                         previous.storeList != current.storeList ||
                         previous.selectedStoreIndex != current.selectedStoreIndex ||
                         previous.isPaginationLoading != current.isPaginationLoading;
                },
                builder: (BuildContext context, StoreLocationsState state) {
                  // Show loading shimmer when API is loading
                  if (state.apiCallForStore == BaseStateStatus.loading) {
                    return CustomListView(
                      isPadding: true,
                      itemCount: AppConstant.limitProduct,
                      itemBuilder: (BuildContext context, int index) {
                        return const StoreLocationItemShimmer();
                      },
                    );
                  }
                  // Show empty state
                  if (state.storeList.isEmpty && state.apiCallForStore == BaseStateStatus.success) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CustomTextLabelWidget(
                            label: 'No stores found',
                            style: context.textTheme.titleLarge?.copyWith(
                              fontSize: Dimens.fontSize16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  // Show store list
                  return CustomListView(
                    isPadding: true,
                    itemCount: state.storeList.length + (state.isPaginationLoading ? 1 : 0),
                    scrollController: state.scrollController,
                    itemBuilder: (BuildContext context, int index) {
                      // Show loading indicator at the bottom for pagination
                      /*if (index == state.storeList.length && state.isPaginationLoading) {
                        return const Padding(
                          padding: EdgeInsets.all(Dimens.space16),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }*/

                      final ListOfStoreResponse store = state.storeList[index];
                      final bool isSelected = state.selectedStoreIndex == index;
                      
                      return StoreLocationItem(
                        storeName: store.storeName ?? '',
                        address: _buildStoreAddress(store),
                        isItemsNotAvailable: store.isStoreAvailable != '1',
                        onTap: () {
                          context.read<StoreLocationsCubit>().selectStore(index);
                        },
                        itemsNotavailable: store.itemsNotAvailableNote ?? '',
                        distance: store.distance?.toString() ?? '',
                        isSelected: isSelected,
                        timeSlot: store.timeSlot,
                        onMapTap: () async {
                          await _openGoogleMaps(store);
                        },
                        onCallTap: () async {
                          await _makeCall(store);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds store address from API response.
  String _buildStoreAddress(ListOfStoreResponse store) {
    final List<String> addressParts = <String>[];
    
    // Add street if it exists and is not false/empty
    if (store.street != null && store.street.toString().isNotEmpty && store.street != false) {
      addressParts.add(store.street.toString());
    }
    // Add district if it exists and is not empty
    if (store.district != null && store.district!.isNotEmpty) {
      addressParts.add(store.district!);
    }
    // Add city if it exists and is not false/empty
    if (store.city != null && store.city.toString().isNotEmpty && store.city != false) {
      addressParts.add(store.city.toString());
    }
    
    // Add country if it exists and is not empty
    if (store.country != null && store.country!.isNotEmpty) {
      addressParts.add(store.country!);
    }
    
    // If no address parts, return a default message
    if (addressParts.isEmpty) {
      return '';
    }
    
    return addressParts.join(', ');
  }



  /// Makes a call to the store
  Future<void> _makeCall(ListOfStoreResponse store) async {
    final String? phoneNumber = store.phoneNumber;

    if (phoneNumber != null && phoneNumber.isNotEmpty) {
      final String telUrl = 'tel:$phoneNumber';

      if (await canLaunchUrl(Uri.parse(telUrl))) {
        await launchUrl(Uri.parse(telUrl));
      } else {
        DebugLog.instance.e('Could not launch phone dialer for number: $phoneNumber');
      }
    } else {
      DebugLog.instance.e('Store phone number is not available');
    }
  }

  /// Opens Google Maps with the store location
  Future<void> _openGoogleMaps(ListOfStoreResponse store) async {
    final double? lat = store.lat;
    final double? lng = store.lang;
    if (lat != null && lng != null) {
      final String googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
      if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
        await launchUrl(Uri.parse(googleMapsUrl));
      } else {
        final String fallbackUrl = 'https://maps.google.com/maps?q=$lat,$lng';
        if (await canLaunchUrl(Uri.parse(fallbackUrl))) {
          await launchUrl(Uri.parse(fallbackUrl));
        } else {
          DebugLog.instance.e('Could not launch maps application');
        }
      }
    } else {
      DebugLog.instance.e('Store location coordinates are not available');
    }
  }

  @override
  Widget buildDesktopWidget(BuildContext context) {
    return buildLocation(context);
  }

  @override
  Widget buildMobileWidget(BuildContext context) {
    return buildLocation(context);
  }

  @override
  Widget buildTabletWidget(BuildContext context) {
    return buildLocation(context);
  }
}
