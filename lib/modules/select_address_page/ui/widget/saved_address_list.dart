import '../../../../utils/exports.dart';

/// Widget that displays a list of saved addresses for selection.
class SavedAddressList extends StatelessWidget {
  /// Creates a saved address list widget.
  const SavedAddressList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectAddressCubit, SelectAddressState>(
      buildWhen: (SelectAddressState previous, SelectAddressState current) {
        // Only rebuild when address-related state changes
        return previous.apiCallForAddress != current.apiCallForAddress ||
               previous.addressList != current.addressList ||
               previous.isAddressPaginationLoading != current.isAddressPaginationLoading;
      },
      builder: (BuildContext context, SelectAddressState state) {
        return Padding(
          padding: const EdgeInsets.only(
            right: Dimens.size16,
            left: Dimens.size16,
          ),
          child: state.apiCallForAddress == BaseStateStatus.loading
              ? CustomListView(
                  isPadding: true,
                  itemCount: AppConstant.itemCount5,
                  scrollController: ScrollController(),
                  itemBuilder: (BuildContext context, int index) {
                    return const SelectHomeOfficeItemShimmer();
                  },
                )
              : state.addressList.isEmpty
                  ? CustomNoDataWidget(
                      message: context.appString.noAddressFoundKey,
                      showImage: false,
                      showButton: false,
                      backgroundColor: Colors.transparent,
                      description: context.appString.noAddressFoundDescKey,
                      onButtonPressed: () async {},
                    )
                  : SingleChildScrollView(
                      controller: state.scrollController,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: Dimens.space50),
                        child: Column(
                          children: <Widget>[
                            // Show address items
                            ...state.addressList.asMap().entries.map<Widget>((MapEntry<int, MyAddressListingResponse> entry) {
                              final MyAddressListingResponse address = entry.value;
                              return Padding(
                                padding: const EdgeInsets.only(bottom: Dimens.space8),
                                child: SelectHomeofficeItem(
                                  showEditDelete: false,
                                  image: AddressUtils.getAddressIcon(
                                      address.addressType),
                                  storeName: AddressUtils.getAddressTitle(address),
                                  address: address.mapAddress ?? "",
                                  onTap: () async {
                                    // Handle address selection - load stores based on address location
                                    await context.read<SelectAddressCubit>()
                                          .loadStoresForAddress(address);
                                  },
                                  onTapEdit: () {
                                    DebugLog.instance.d("Edit address: ${address.id}");
                                  },
                                  onTapDelete: () {
                                    DebugLog.instance.d("Delete address: ${address.id}");
                                  },
                                ),
                              );
                            }),
                            // Show pagination loading indicator
                            Visibility(
                              visible: state.isAddressPaginationLoading,
                              child: const CustomPaginationLoaderWidget(),
                            ),
                          ],
                        ),
                      ),
                    ),
        );
      },
    );
  }
}
