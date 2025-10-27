import '../../../utils/exports.dart';
///AddressFieldForm
class AddressFieldForm extends StatelessWidget {

  /// AddressFieldForm constructor
  const AddressFieldForm({super.key, this.device = ScreenType.mobile, required this.isFromAddressList});

  ///device
  final ScreenType device;

  ///isFromAddressList
  final bool isFromAddressList;

  @override
  Widget build(BuildContext context) {
    bool isEnglish = context.isEnglishLanguage;

    double horizontalPadding = Dimens.space16;
    switch (device) {
      case ScreenType.mobile:
        break;
      case ScreenType.tablet:
        horizontalPadding = Dimens.space60;

      default:
        break;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocListener<AddressCubit, AddressState>(
        listener: (BuildContext context, AddressState state) async {
          if (state.status == BaseStateStatus.success) {
            if (state.showLocationPermissionDialog ?? false) {
              displayLocationAlert(context);
            } else if (state.redirectRoute != null) {
              if (state.isForCheckOut ?? false) {
                context.router.popUntil(
                      (Route<dynamic> route) {
                    return route.settings.name ==
                        const DashboardRoute().routeName;
                  },
                );
              } else {
                unawaited(context.router.maybePop());
              }
            }
          } else if (state.status == BaseStateStatus.failure) {
            displaySnackBar(state.msg ?? "", context);
          }
        },
        listenWhen: (AddressState previous, AddressState current) =>
        previous.status != current.status,
        child: Column(
          children: <Widget>[
            ProductDetailsAppBar(
              titleText: context.appString.selectDeliveryLocationKey,
              isLastWidgetDisplay: false,
              prefixIcon: Assets.svgs.icBack
                  .svg(height: Dimens.size24, width: Dimens.size24),
            ),
            const SizedBox(
              height: Dimens.size2,
            ),
            const Expanded(child: GoogleMapPage()),

            /*   Expanded(
              child: KeyboardActions(
                config: _buildConfig(
                    context, context.instance<AddressCubit>().state),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: horizontalPadding),
                          child: CustomTextLabelWidget(
                            label: MainConfig.dynamicString(
                                JsonServiceString.keyYourLocation),
                            style: context.textTheme.headlineMedium?.copyWith(
                              fontSize: yourLocationFontSize,
                              color: AppColors.textDarkBlueColor,
                            ),
                          ),
                        ),
                        */ /* AddAddressField(
                          device: device,
                        ),*/ /*
                      ],
                    ),
                  ),
                ),
              ),
            ),*/
            Container(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                children: <Widget>[
                  // Row for Location Icon and Title
                  Padding(
                    padding: const EdgeInsets.only(top: Dimens.size18),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            left: !isEnglish ? Dimens.size10 : Dimens.size0,
                            // Adjust based on RTL or LTR
                            right: !isEnglish
                                ? Dimens.size0
                                : Dimens.size10, // Adjust based on RTL or LTR
                          ),
                          child: Assets.svgs.icMapLocation
                              .svg(height: Dimens.size20, width: Dimens.size20),
                        ),
                        Expanded(
                          child: BlocBuilder<AddressCubit, AddressState>(
                            builder: (BuildContext context, AddressState state) {
                              String titleText = AppConstant.salmiyahAddress;
                              String addressText = AppConstant.salmiyahAddressTail;

                              // Debug logging
                              DebugLog.instance.i('Current latLng: ${state.latLng}');
                              DebugLog.instance.i('Default latLng: ${AddressState.defaultLocation}');
                              DebugLog.instance.i('Street address: ${state.streetAddress1TextEditingController.text}');

                              // Check if we have a valid location (including default Kuwait location)
                              // Use a small tolerance for floating-point comparison
                              const double tolerance = 0.0001;
                              bool hasValidLocation = state.latLng != null;
                              bool isDefaultLocation = hasValidLocation &&
                                  (state.latLng!.latitude - AddressState.defaultLocation.latitude).abs() <= tolerance &&
                                  (state.latLng!.longitude - AddressState.defaultLocation.longitude).abs() <= tolerance;
                              bool hasRealLocation = hasValidLocation && !isDefaultLocation;

                              DebugLog.instance.i('Has valid location: $hasValidLocation');
                              DebugLog.instance.i('Is default location: $isDefaultLocation');
                              DebugLog.instance.i('Has real location: $hasRealLocation');
                              DebugLog.instance.i('Lat diff: ${state.latLng != null ? (state.latLng!.latitude - AddressState.defaultLocation.latitude).abs() : 0}');
                              DebugLog.instance.i('Lng diff: ${state.latLng != null ? (state.latLng!.longitude - AddressState.defaultLocation.longitude).abs() : 0}');

                              if (hasValidLocation) {
                                // If we have street address from placemark, use it (regardless of whether it's default or real location)
                                if (state.streetAddress1TextEditingController.text.isNotEmpty) {
                                  titleText = state.streetAddress1TextEditingController.text;
                                  addressText = _getFormattedAddress(state);
                                  DebugLog.instance.i('Using street address: $titleText');

                                  // Save selected address to SharedPreferences
                                  _saveSelectedAddress(state, titleText, addressText);
                                } else if (hasRealLocation) {
                                  // If no street address yet but we have a real location, show loading state
                                  titleText = 'Getting Address...';
                                  addressText = 'Please wait while we get your location details';
                                  DebugLog.instance.i('Showing loading state for real location...');
                                } else {
                                  // If it's the default location and no street address, keep default text
                                  DebugLog.instance.i('Using default text for default location');
                                }
                              } else {
                                DebugLog.instance.i('No valid location available');
                              }

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  CustomTextLabelWidget(
                                    textAlign:
                                    !isEnglish ? TextAlign.end : TextAlign.start,
                                    // Adjust text alignment based on RTL or LTR
                                    style: context.textTheme.titleLarge?.copyWith(
                                        height: Dimens.lineHeight24
                                            .toLineHeight(Dimens.fontSize16),
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.blackColor,
                                        fontSize: Dimens.fontSize16),
                                    label: titleText,
                                  ),
                                  // Address Text with padding for spacing
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: Dimens.space17,
                                      bottom: Dimens.space23,
                                      left: !isEnglish ? Dimens.space80 : Dimens.size0,
                                      // Adjust padding based on LTR/RTL
                                      right: !isEnglish
                                          ? Dimens.size0
                                          : Dimens.size80, // Adjust padding based on LTR/RTL
                                    ),
                                    child: CustomTextLabelWidget(
                                      style: context.textTheme.titleLarge?.copyWith(
                                        height:
                                        Dimens.lineHeight18.toLineHeight(Dimens.fontSize14),
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.blackColor,
                                        fontSize: Dimens.fontSize14,
                                      ),
                                      textAlign: !isEnglish ? TextAlign.end : TextAlign.start,
                                      // Adjust text alignment based on LTR/RTL
                                      label: addressText,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Button with proper padding and full-width alignment
                  Padding(
                    padding: const EdgeInsets.only(bottom: Dimens.space33),
                    child: CustomGradientButtonWidget(
                      device: device,
                      title: context.appString.confirmLocationKey,
                      onTap: () async {
                        await context.router.push(NewAddressAddRoute(isFromAddressList: isFromAddressList));
                        // addressCubit.saveAddress();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  ///displayLocationAlert
  void displayLocationAlert(BuildContext context) {
    Future<void>.delayed(
      const Duration(milliseconds: Dimens.millisecond3000),
          () {
        if (context.mounted) {
          showCustomDialog(
            title: context.appString.permissionRequiredKey,
            context.appString.permissionSettingsMessageKey,
            okBtnTitle: context.appString.openSettingsKey,
            textAlign: TextAlign.center,
            onOkClicked: () async {
              await PermissionManager().openMobileSetting();
              if (context.mounted) {
                goBack(context);
              }
            },
            cancelBtnTitle: context.appString.cancelKey,
            onCancelClicked: () {
              if (context.mounted) {
                goBack(context);
              }
            },
            device: device,
          );
        }
      },
    );
  }

  /// Get formatted address from the current location
  String _getFormattedAddress(AddressState state) {
    try {
      // If we have a street address from placemark, use it
      if (state.streetAddress1TextEditingController.text.isNotEmpty) {
        String streetAddress = state.streetAddress1TextEditingController.text;

        // Try to get additional address components
        String additionalInfo = '';
        if (state.streetAddress2TextEditingController.text.isNotEmpty) {
          additionalInfo += ', ${state.streetAddress2TextEditingController.text}';
        }
        if (state.streetAddress3TextEditingController.text.isNotEmpty) {
          additionalInfo += ', ${state.streetAddress3TextEditingController.text}';
        }
        if (state.cityTextEditingController.text.isNotEmpty) {
          additionalInfo += ', ${state.cityTextEditingController.text}';
        }
        if (state.postalCodeTextEditingController.text.isNotEmpty) {
          additionalInfo += ', ${state.postalCodeTextEditingController.text}';
        }

        String fullAddress = '$streetAddress$additionalInfo';
        DebugLog.instance.i('Formatted address: $fullAddress');
        return fullAddress;
      }

      // Fallback to coordinates if no street address
      if (state.latLng != null) {
        String coordinates = 'Location: ${state.latLng!.latitude.toStringAsFixed(4)}, ${state.latLng!.longitude.toStringAsFixed(4)}';
        DebugLog.instance.i('Using coordinates as address: $coordinates');
        return coordinates;
      }
    } on Exception catch (e) {
      DebugLog.instance.e('Error formatting address: $e');
    }
    return AppConstant.salmiyahAddressTail;
  }

  /// Saves the selected address to SharedPreferences
  void _saveSelectedAddress(AddressState state, String titleText, String addressText) {
    if (state.latLng != null) {
      final SelectedAddressModel addressModel = SelectedAddressModel.fromLatLngAndDetails(
        latLng: state.latLng!,
        title: titleText,
        details: addressText,
        streetAddress1: state.streetAddress1TextEditingController.text,
        streetAddress2: state.streetAddress2TextEditingController.text,
        streetAddress3: state.streetAddress3TextEditingController.text,
        city: state.cityTextEditingController.text,
        postalCode: state.postalCodeTextEditingController.text,
        country: state.countryTextEditingController.text,
      );

      // Save to SharedPreferences (fire and forget)
      unawaited(SharedPref.instance.saveSelectedAddress(addressModel));
      DebugLog.instance.i('Address saved to SharedPreferences: $titleText');
    }
  }
}
