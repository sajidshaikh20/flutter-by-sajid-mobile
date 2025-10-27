import '../../../../utils/exports.dart';

/// Widget that handles address selection with location services and saved addresses.
class SelectAddressWidget extends StatelessWidget {
  /// Creates a select address widget.
  const SelectAddressWidget({super.key, this.device = ScreenType.mobile});

  /// The screen type for responsive design.
  final ScreenType device;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SelectAddressCubit, SelectAddressState>(
      listener: (BuildContext context, SelectAddressState state) async {
        if (state.redirectRoute != null) {
          await context.router.push(state.redirectRoute!);
        } else if (state.msg?.isNotEmpty ?? false) {
          displaySnackBar(state.msg!, context);
        }
      },
      listenWhen: (SelectAddressState previous, SelectAddressState current) =>
          previous.status != current.status,
      child: BlocBuilder<SelectAddressCubit, SelectAddressState>(
          buildWhen: (SelectAddressState previous, SelectAddressState current) {
            // Only rebuild when relevant UI state changes
            return previous.selectedSegmentIndex != current.selectedSegmentIndex ||
                   previous.isFromLogin != current.isFromLogin;
          },
          builder: (BuildContext context, SelectAddressState state) {
            return NoInternetWidget(
              childWidget: PopScope(
                canPop: !state.isFromStoreSelection,
                onPopInvokedWithResult: (bool didPop, dynamic result) async {
                  if (!didPop) {
                    await handleCloseAction(context);
                  }
                },
                child: Scaffold(
                  backgroundColor: MainConfig.appColors.backgroundWhite,
                  body: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  // Use ListView to handle scrollable content
                  children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: PageView.builder(
                          controller: PageController(
                              initialPage: state.selectedSegmentIndex),
                          onPageChanged: (int index) {
                            context.read<SelectAddressCubit>().onSegmentChangedIndex(index);
                          },
                          itemCount: 1, // Two pages: Delivery and Pickup
                          itemBuilder: (BuildContext context, int index) {
                            if (index == 0) {
                              return Assets.svgs.bgFullscreenCommon.svg(
                                  fit: BoxFit.fitWidth,
                                  width: double.infinity,
                                  height: double.infinity);
                            } else {
                              return Container(); // Add other pages if necessary
                            }
                          },
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Material(
                            elevation: Dimens.elevation4 ,
                            shadowColor: Colors.black.withValues(alpha:Dimens.opacity02),
                            child: Container(
                              color: Colors.white,
                              height: Dimens.size55,
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: Dimens.space5,
                                    left: Dimens.size16,
                                    right: Dimens.size16), // Padding for the row
                                child: Stack(
                                  children: <Widget>[
                                    // Center the SegmentedControl
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: Dimens.size16),
                                        // Adjust top padding to vertically center
                                        child: SizedBox(
                                          width: Dimens.size160,
                                          child: SegmentedControl(
                                            firstTitle:
                                                context.appString.deliveryKey,
                                            secondTitle:
                                                context.appString.pickupKey,
                                            selectedIndex: /*context.read<SelectAddressCubit>().tempSelectedAddress ==null ?*/ state.selectedSegmentIndex /*:0*/,
                                            onIndexChanged: (int value) {
                                              context.read<SelectAddressCubit>().onSegmentChangedIndex(value);
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Close Button aligned at the top left corner
                                    Visibility(
                                      visible: !state.isFromLogin || state.selectedSegmentIndex == 1,
                                      replacement: const SizedBox(),
                                      child: Positioned(
                                          top: Dimens.size26,
                                          // Adjust to align vertically with the SegmentedControl
                                          child: GestureDetector(
                                            onTap: () async {
                                              if(state.isFromStoreSelection){
                                                await handleCloseAction(context);
                                              }else{
                                                goBack(context);
                                              }
                                            },
                                            child: Assets.svgs.icCrossCancel.svg(
                                                height: Dimens.size24,
                                                width: Dimens.size24),
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // Column wrapped in Expanded to take up remaining space
                          Column(
                            children: <Widget>[
                              if (state.selectedSegmentIndex == 0)
                                Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: Dimens.fontSize16),
                                      child: SizedBox(
                                        height: Dimens.size44,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: Dimens.size16),
                                          child: GooglePlaceAutoCompleteTextField(
                                            textEditingController:
                                                TextEditingController(),
                                            googleAPIKey: configGoogleApiKey,
                                            inputDecoration: InputDecoration(
                                              border: Dimens.radius10
                                                  .outlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: MainConfig.appColors
                                                        .borderColorWhite),
                                              ),
                                              focusedBorder: Dimens.radius10
                                                  .outlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: MainConfig.appColors
                                                        .borderColorWhite),
                                              ),
                                              enabledBorder: Dimens.radius10
                                                  .outlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: MainConfig.appColors
                                                        .borderColorWhite),
                                              ),
                                              filled: true,
                                              fillColor: MainConfig
                                                  .appColors.backgroundWhite,
                                              prefixIcon: Padding(
                                                padding: const EdgeInsets.only(
                                                  right: Dimens.size4,
                                                  left: Dimens.size12,
                                                  top: Dimens.size12,
                                                  bottom: Dimens.size12,
                                                ),
                                                child: Assets
                                                    .svgs.icSearchAddressIcon
                                                    .svg(
                                                  height: Dimens.size18,
                                                  width: Dimens.size18,
                                                ),
                                              ),
                                              hintText: context.appString
                                                  .searchForAreaStreetNameKey,
                                              hintStyle: context
                                                  .textTheme.bodySmall
                                                  ?.copyWith(
                                                fontSize: Dimens.fontSize16,
                                                color: MainConfig
                                                    .appColors.textColorGrey,
                                              ),
                                            ),
                                            isCrossBtnShown: false,
                                            getPlaceDetailWithLatLng: (Prediction
                                                postalCodeResponse) async {
                                              final LatLng newLatLang = LatLng(
                                                double.parse(
                                                    postalCodeResponse.lat ?? ''),
                                                double.parse(
                                                    postalCodeResponse.lng ?? ''),
                                              );
                                              await context
                                                  .read<AddressCubit>()
                                                  .mapController
                                                  ?.moveCamera(
                                                    CameraUpdate
                                                        .newCameraPosition(
                                                      CameraPosition(
                                                          target: newLatLang,
                                                          zoom: Dimens.zoom14),
                                                    ),
                                                  );
                                            },
                                            itemClick: (Prediction
                                                postalCodeResponse) {},
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: Dimens.size8),
                                    const AddressOptionView(),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: Dimens.size16),
                                      child: Divider(
                                          color: MainConfig
                                              .appColors.lightGreyColor),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: Dimens.size11,
                                          left: Dimens.size16,
                                          top: Dimens.size14),
                                      child: GestureDetector(
                                        onTap: ()  {
                                        //  await context.pushRoute(ListAddressRoute());
                                        },
                                        child: Row(
                                          children: <Widget>[
                                            CustomTextLabelWidget(
                                              maxLines: Dimens.maxLines01,
                                              textAlign: TextAlign.start,
                                              style: context.textTheme.titleLarge
                                                  ?.copyWith(
                                                height: Dimens.lineHeight16
                                                    .toLineHeight(
                                                        Dimens.fontSize18),
                                                fontWeight: FontWeight.w700,
                                                color: MainConfig
                                                    .appColors.textBlackColor,
                                                fontSize: Dimens.fontSize18,
                                              ),
                                              label:
                                                  context.appString.savedAddressKey,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: context.height - Dimens.size300,
                                      // Adjust remaining height
                                      child: const SavedAddressList(),
                                    ),
                                  ],
                                )
                              else
                                SizedBox(
                                  height: context.height - Dimens.space140,
                                  // Adjust height for available stores
                                  child: BlocBuilder<AddressCubit, AddressState>(

                                    builder: (BuildContext context,
                                        AddressState state) {
                                      return AvailableStoresView(
                                        addressCubit: context.read<AddressCubit>(),
                                        state: state,
                                      );
                                    },
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
                ),
              ),
            );
        },
      ),
    );
  }



  /// Checks if user has made any selection (address or store)
  bool hasUserMadeSelection() {
    // Check if there's already a store selected in CountryService
    final int? existingStore = getIt<CountryService>().store;
    if (existingStore != null) {
      // If there's already a store selected, allow exit
      return true;
    }
    return false;
  }

  /// Handles the close/back action with validation
  Future<void> handleCloseAction(BuildContext context) async {
    if (hasUserMadeSelection()) {

    } else {
      // User hasn't made a selection, show confirmation dialog
      await _showExitConfirmationDialog(context);
    }
  }

  /// Shows confirmation dialog when user tries to exit without selection
  Future<void> _showExitConfirmationDialog(BuildContext context) async {
    showCustomDialog(
      context.appString.pleaseSelectStoreBeforeContinuingKey,
      title: context.appString.selectDeliveryMethodKey,
      okBtnTitle: context.appString.okayKey,
      onOkClicked: () {
        goBack(context);
      },
    );
  }
}
