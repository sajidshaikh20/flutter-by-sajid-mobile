import '../../../../utils/exports.dart';

/// A page that displays a Google Map and allows user interaction.
///
/// This widget can be used to pick locations, show markers, or display
/// map-related information. Implementation details can include map
/// controllers, markers, and callbacks for location selection.
class GoogleMapPage extends StatefulWidget {
  /// Creates a [GoogleMapPage].
  const GoogleMapPage({super.key});

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  SelectedAddressModel? savedAddress;

  @override
  void initState() {
    super.initState();
    scheduleMicrotask(() async {
      await _loadSavedAddress();
    });
  }

  /// Load saved address from SharedPreferences and set map position
  Future<void> _loadSavedAddress() async {
    try {
      final SelectedAddressModel? address =
          await SharedPref.instance.getSelectedAddress();
      if (address != null &&
          address.isValid &&
          address.latLng != null &&
          mounted) {
        setState(() {
          savedAddress = address;
        });
        DebugLog.instance
            .i('GoogleMapPage: Loaded saved address: ${address.title}');

        // Set the map position to saved address location
        final AddressCubit addressCubit = context.instance<AddressCubit>()
          ..updateLatLng(address.latLng!);

        // Animate camera to saved location
        if (addressCubit.mapController != null) {
          await addressCubit.mapController!.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: address.latLng!,
                zoom: Dimens.zoom14,
              ),
            ),
          );
        }

        // Get placemark data for the saved location
        await addressCubit.getPlacemarkData(address.latLng!);
      }
    } on Exception catch (e) {
      DebugLog.instance.e('GoogleMapPage: Error loading saved address: $e');
    }
  }

  /// Save the current location to SharedPreferences
  Future<void> _saveLocationToPreferences(LatLng latLng) async {
    try {
      final SelectedAddressModel? address =
          await SharedPref.instance.getSelectedAddress();
      if (address != null) {
        await SharedPref.instance.saveSelectedAddress(
          address.copyWith(latLng: latLng),
        );
        DebugLog.instance
            .i('GoogleMapPage: Saved location to preferences: $latLng');
      }
    } on Exception catch (e) {
      DebugLog.instance
          .e('GoogleMapPage: Error saving location to preferences: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final AddressCubit addressCubit = context.instance<AddressCubit>();
    CameraPosition? cameraPosition;

    // Fetch the current location if editing is not enabled and no lat/lng data exists
    if (!addressCubit.isForEdit &&
        addressCubit.state.latLng == null &&
        savedAddress == null) {
      scheduleMicrotask(
        () async {
          if (context.mounted) {
            unawaited(context
                .instance<AddressCubit>()
                .getLocation(moveToCurrentLocation: true));
          }
        },
      );
    }

    return Stack(
      children: <Widget>[
        BlocBuilder<AddressCubit, AddressState>(
          builder: (BuildContext context, AddressState state) => GoogleMap(
            zoomControlsEnabled: false,
            // Disable zoom controls
            mapToolbarEnabled: false,
            // Disable map toolbar
            myLocationButtonEnabled: false,
            // Disable location button
            onCameraMoveStarted: () {},
            // Handle camera move start (empty)
            initialCameraPosition: AddressState.cameraPosition,
            // Set initial camera position
            markers: <Marker>{
              AddressState.marker.copyWith(
                positionParam: addressCubit.state.latLng,
                visibleParam: addressCubit.state.latLng != null,
              ),
            },
            onCameraMove: (CameraPosition position) {
              cameraPosition = position;
              addressCubit.updateLatLng(position.target); // Update lat/lng
            },
            onCameraIdle: () async {
              // If camera position has changed, update location data
              if (cameraPosition != null) {
                addressCubit.updateLatLng(cameraPosition!.target);
                // Get placemark data for the new location
                await addressCubit.getPlacemarkData(cameraPosition!.target);

                // Save the new location to SharedPreferences
                await _saveLocationToPreferences(cameraPosition!.target);
              }
            },
            onMapCreated: (GoogleMapController controller) async {
              addressCubit.mapController = controller;

              // If we have a saved address, animate to that location
              if (savedAddress?.latLng != null) {
                await controller.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: savedAddress!.latLng!,
                      zoom: Dimens.zoom14,
                    ),
                  ),
                );
              } else {
                await addressCubit
                    .animateCamera(); // Animate camera to the target position
              }
            },
          ),
          buildWhen: (AddressState previous, AddressState current) =>
              previous.latLng != current.latLng,
        ),
        Visibility(
          //keeping it as false since we might require it. It is a search box
          child: Container(
            height: Dimens.size44,
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.only(
              top: Dimens.space16,
              left: Dimens.space15,
              right: Dimens.space15,
            ),
            child: GooglePlaceAutoCompleteTextField(
              textEditingController:
                  addressCubit.state.searchTextEditingController,
              googleAPIKey: configGoogleApiKey,
              inputDecoration: InputDecoration(
                border: Dimens.radius10.outlineInputBorder(
                    borderSide: BorderSide(
                        color: MainConfig.appColors.borderColorWhite)),
                focusedBorder: Dimens.radius10.outlineInputBorder(
                    borderSide: BorderSide(
                        color: MainConfig.appColors.borderColorWhite)),
                enabledBorder: Dimens.radius10.outlineInputBorder(
                    borderSide: BorderSide(
                        color: MainConfig.appColors.borderColorWhite)),
                filled: true,
                fillColor: MainConfig.appColors.backgroundWhite,
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(
                      right: Dimens.size4,
                      left: Dimens.size12,
                      top: Dimens.size12,
                      bottom: Dimens.size12),
                  // Adjust padding as needed
                  child: Assets.svgs.icSearchAddressIcon
                      .svg(height: Dimens.size18, width: Dimens.size18),
                ),
                hintText: context.appString.searchForAreaStreetNameKey,
                hintStyle: context.textTheme.bodySmall?.copyWith(
                  fontSize: Dimens.fontSize16,
                  color: MainConfig.appColors.textColorGrey,
                ),
              ),
              isCrossBtnShown: false,
              getPlaceDetailWithLatLng: (Prediction postalCodeResponse) async {
                final LatLng newLatLang = LatLng(
                    double.parse(postalCodeResponse.lat ?? ''),
                    double.parse(postalCodeResponse.lng ?? ''));
                await context.read<AddressCubit>().mapController?.moveCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                          target: newLatLang, //initial position
                          zoom: Dimens.zoom14, //initial zoom level
                        ),
                      ),
                    );
              },
              itemClick: (Prediction postalCodeResponse) {},
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              bottom: Dimens.size16, right: Dimens.size16),
          child: Align(
            alignment: Alignment.bottomRight,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                // White background color
                borderRadius: Dimens.radius30.borderRadius,
                // Adjust radius for rounded corners
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withValues(
                      alpha: 0.1 * 255, // double
                      red: 0.0,
                      green: 0.0,
                      blue: 0.0,
                    ),
                    // Optional: adds a subtle shadow
                    blurRadius: Dimens.blurRadius4,
                    offset: const Offset(Dimens.offset0, Dimens.offset4),
                  ),
                ],
              ),
              child: InkWell(
                onTap: () async {
                  await addressCubit.getLocation(moveToCurrentLocation: true);
                },
                child: Padding(
                  padding: const EdgeInsets.all(Dimens.size8),
                  // Adjust padding inside the container
                  child: Assets.svgs.icGetCurrentLocation.svg(),
                ),
              ),
            ),
          ),
        ),

        ///View to add the custom pin location. make it visible when custom marker is required
        // Visibility(
        //   child: Align(
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: <Widget>[
        //           Container(
        //             padding: const EdgeInsets.symmetric(
        //                 horizontal: Dimens.space11, vertical: Dimens.space2),
        //             height: Dimens.size23,
        //             decoration: BoxDecoration(
        //                 borderRadius: Dimens.radius3.borderRadius,
        //                 color: MainConfig.appColors.shadowBlackColor
        //                     .withOpacity(Dimens.opacity073)),
        //             child: CustomTextLabelWidget(
        //               label: context.appString.moveToMapTosetLocation,
        //               style: context.textTheme.bodySmall?.copyWith(
        //                 fontSize: Dimens.fontSize12,
        //                 color: MainConfig.appColors.textWhiteColor,
        //               ),
        //             ),
        //           ),
        //           Dimens.size5.heightBox,
        //           Assets.svgs.icMarkerLocation.svg()
        //         ],
        //       )),
        // ),
      ],
    );
  }
}
