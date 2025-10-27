import '../../../utils/exports.dart';

/// A widget that displays a list of user addresses.
///
/// Supports responsive layouts based on [device] type. Shows a loading shimmer
/// while fetching addresses, a no-data widget if the list is empty, and a list
/// of address items when data is available. Provides options to add, edit, or
/// delete addresses.
class AddressListWidget extends StatelessWidget {
  /// Creates an [AddressListWidget].
  ///
  /// The [device] parameter allows adjusting layout and padding for different devices,
  /// defaulting to [ScreenType.mobile].
  const AddressListWidget({super.key, this.device = ScreenType.mobile});

  /// The type of device layout to adapt the widget's appearance.
  final ScreenType device;

  @override
  Widget build(BuildContext context) {
    // Default paddings
    double horizontalPadding = Dimens.space16;
    // Increase horizontal padding for tablet layout
    switch (device) {
      case ScreenType.tablet:
        horizontalPadding = Dimens.space32;
      default:
        break;
    }

    return BlocConsumer<AddressListCubit, AddressListState>(
      listener: (BuildContext context, AddressListState state) {
        // You can handle side effects here, e.g., showing a snackbar on errors
      },
      builder: (BuildContext context, AddressListState state) => NoInternetWidget(
        childWidget: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            children: <Widget>[
              // App bar with title and "Add New" button
              ProductDetailsAppBar(
                onTap: () async {
                  unawaited(
                    context.router.push(
                      AddNewAddressRoute(isFromAddressList: true),
                    ),
                  );
                },
                style: context.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: Dimens.fontSize14,
                  color: MainConfig.appColors.mainColor,
                  height: Dimens.lineHeight18.toLineHeight(Dimens.fontSize14),
                ),
                endText: context.appString.addNewKey,
                titleText: context.appString.myAddressesKey,
                isLastWidgetClearAll: true,
                prefixIcon: Assets.svgs.icBack.svg(
                  height: Dimens.size24,
                  width: Dimens.size24,
                ),
              ),

              // Main content: loading, empty, or populated list
              Expanded(
                child: (state.status == BaseStateStatus.loading || state.isRefreshing)
                    ? CustomListView(
                  isPadding: true,
                  itemCount: AppConstant.itemCount8,
                  scrollController: ScrollController(),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                      child: const SelectHomeOfficeItemShimmer(),
                    );
                  },
                )
                    : state.addressList.isEmpty
                    ? CustomNoDataWidget(
                  message: context.appString.noAddressFoundKey,
                  asset: Assets.svgs.noAddressFound.svg(),
                  description: context.appString.noAddressFoundDescKey,
                  onButtonPressed: () async {
                    // Try again - refresh address list
                    await context.read<AddressListCubit>().refreshAddressList();
                  },
                )
                    : CustomListView(
                  isPadding: true,
                  itemCount: state.addressList.length,
                  scrollController: ScrollController(),
                  itemBuilder: (BuildContext context, int index) {
                    final MyAddressListingResponse address = state.addressList[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                      child: SelectHomeofficeItem(
                        image: AddressUtils.getAddressIcon(address.addressType),
                        storeName: AddressUtils.getAddressTitle(address),
                        address: AddressUtils.formatAddress(address, includeMobile: true),
                        onTap: () async {
                          //#TODO: Save selected address in the future if needed
                        },
                        onTapEdit: () async {
                          DebugLog.instance.d(
                            "Edit Address data: ${address.id} ${address.latitude}, ${address.longitude} ${address.addressType} ${address.area} ${address.blockNo} ${address.street} ${address.buildingVilla} ${address.floor} ${address.flatAppartment} ${address.landmark} ${address.mobileNo}",
                          );
                          await context.router.push(
                            NewAddressAddRoute(
                              isEdit: true,
                              isFromAddressList: true,
                              myAddress: address,
                            ),
                          );
                        },
                        onTapDelete: () {
                          // Show delete confirmation dialog
                          _showDeleteConfirmationDialog(context, address.id ?? '');
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Shows a confirmation dialog before deleting an address.
  ///
  /// [addressId] is the ID of the address to delete.
  void _showDeleteConfirmationDialog(BuildContext context, String addressId) {
    showCustomDialog(
      context.appString.deleteAddressMessageKey,
      title: context.appString.deleteAddressKey,
      okBtnTitle: context.appString.yesKey,
      textAlign: TextAlign.center,
      onOkClicked: () async {
        goBack(context);
        final AddressListCubit cubit = context.read<AddressListCubit>();
        await cubit.deleteAddress(addressId);
      },
      cancelBtnTitle: context.appString.noKey,
      onCancelClicked: () {
        goBack(context);
      },
      device: device,
    );
  }
}
