import '../../../../utils/exports.dart';

/// A widget that displays a "Save Address" button and handles validation
/// before allowing the user to save their address.
///
/// This widget interacts with an [AddNewAddressCubit] to manage validation errors
/// and state updates. When pressed, it ensures that all required address
/// fields are filled, and then calls the API to save the address.
class SaveAddressButton extends StatelessWidget {
  /// The cubit that manages address data and validation errors.
  final AddNewAddressCubit addNewAddressCubit;

  /// The current state of the address screen.
  final AddNewAddressState state;

  /// The build context for the widget.
  final BuildContext context;

  /// Whether this page is for editing an existing address
  final bool isEdit;
  ///isFromAddressList
  final bool isFromAddressList;

  /// The address to edit (only used when isEdit is true)
  final String myAddressId;

  /// Creates a [SaveAddressButton] widget.
  SaveAddressButton({
    super.key,
    required this.addNewAddressCubit,
    required this.state,
    required this.context,
    this.isEdit = false,
    this.isFromAddressList = false,
    this.myAddressId = '',
  });

  /// Checks whether the "Save Address" button should be enabled.
  ///
  /// The button is enabled only if:
  /// - Area, block, street, and building/villa fields are filled
  /// - No validation errors exist for required fields
  /// - Address type (Home/Work/Other) is selected
  /// - Mobile number has no validation error (if provided)
  /// - Area field has been populated (either from saved address or user input)
  bool _isSaveButtonEnabled(AddNewAddressCubit cubit, AddNewAddressState state,
      BuildContext context) {

    // Check required fields are filled
    final bool isAreaValid = state.areaController.text.trim().isNotEmpty;
    final bool isBlockValid = state.blockController.text.trim().isNotEmpty;
    final bool isStreetValid =
        state.streetNameController.text.trim().isNotEmpty;
    final bool isBuildingValid =
        state.buildingVillaController.text.trim().isNotEmpty;


    // Check for validation errors (error messages should be empty or null)
    final bool isAreaErrorFree = state.areaErrorMessage?.isEmpty ?? true;
    final bool isBlockErrorFree = state.blockErrorMessage?.isEmpty ?? true;
    final bool isStreetErrorFree = state.streetErrorMessage?.isEmpty ?? true;
    final bool isBuildingErrorFree =
        state.buildingVillaErrorMessage?.isEmpty ?? true;
    final bool isMobileErrorFree = state.mobileNoErrorMessage?.isEmpty ?? true;

    // Check address type selection
    bool isAddressTypeSelected = false;

    try {
      final AddressCubit addressCubit = context.read<AddressCubit>();
      if (addressCubit.state.currentSelectedAddress != null) {
        isAddressTypeSelected =
            addressCubit.state.currentSelectedAddress!.isNotEmpty;
        DebugLog.instance.d(
            'AddressCubit found in context, address type: ${addressCubit.state.currentSelectedAddress}');
      } else {
        // If currentSelectedAddress is null, check if any address type is selected
        isAddressTypeSelected = true; // Default to true since address type is usually pre-selected
        DebugLog.instance.d('AddressCubit found but currentSelectedAddress is null, defaulting to true');
      }
    } on Exception catch (e) {
      DebugLog.instance.d('AddressCubit not available in context: $e');
      // If AddressCubit is not available, assume address type is selected (fallback)
      isAddressTypeSelected = true;
    }


    // All required fields must be filled AND have no validation errors AND address type is selected
    final bool isEnabled = isAreaValid &&
        isBlockValid &&
        isStreetValid &&
        isBuildingValid &&
        isAreaErrorFree &&
        isBlockErrorFree &&
        isStreetErrorFree &&
        isBuildingErrorFree &&
        isMobileErrorFree &&
        isAddressTypeSelected;



    return isEnabled;
  }

  /// Common padding for the container that wraps the save button.
  EdgeInsets commonContainerPadding = const EdgeInsets.only(
    left: Dimens.space16,
    right: Dimens.space16,
    top: Dimens.space9,
    bottom: Dimens.space30,
  );

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddNewAddressCubit, AddNewAddressState>(
      listener: (BuildContext context, AddNewAddressState state) async {
        if (state.status == BaseStateStatus.success) {

          // Show success message
          displaySnackBar(state.msg ?? '', context);

          // Navigate to dashboard if redirect route is set
          if (state.redirectRoute != null) {
            try {
             // await context.router.popAndPush(state.redirectRoute!);
              await context.router.pushAndPopUntil(
                state.redirectRoute!,    // The route you want to navigate to (like AddNewRoute or HomeRoute)
                predicate: (Route<dynamic> route) => route.settings.name == DashboardRoute.name,
              );
              DebugLog.instance.d('Successfully navigated to dashboard');
            } on Exception catch (e) {
              DebugLog.instance.e('Error navigating to dashboard: $e');
            }
          }
        } else if (state.status == BaseStateStatus.failure) {
          DebugLog.instance.d('Address save failed: ${state.msg}');
          // Show error message
          displaySnackBar(state.msg ?? '', context);
        }
      },
      child: Container(
        padding: commonContainerPadding,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withValues(alpha:Dimens.opacity025),
              offset: const Offset(1, 0),
              blurRadius: Dimens.blurRadius4,
            ),
          ],
        ),
        child: BlocBuilder<AddNewAddressCubit, AddNewAddressState>(
          buildWhen: (AddNewAddressState previous, AddNewAddressState current) {
            // Rebuild when any error message changes or form data changes
            return previous.areaErrorMessage != current.areaErrorMessage ||
                previous.blockErrorMessage != current.blockErrorMessage ||
                previous.streetErrorMessage != current.streetErrorMessage ||
                previous.buildingVillaErrorMessage !=
                    current.buildingVillaErrorMessage ||
                previous.floorErrorMessage != current.floorErrorMessage ||
                previous.flatApartmentErrorMessage !=
                    current.flatApartmentErrorMessage ||
                previous.landmarkErrorMessage != current.landmarkErrorMessage ||
                previous.mobileNoErrorMessage != current.mobileNoErrorMessage ||
                previous.areaController.text != current.areaController.text ||
                previous.blockController.text != current.blockController.text ||
                previous.streetNameController.text !=
                    current.streetNameController.text ||
                previous.buildingVillaController.text !=
                    current.buildingVillaController.text ||
                previous.floorController.text != current.floorController.text ||
                previous.flatApartmentController.text != current.flatApartmentController.text ||
                previous.landmarkController.text != current.landmarkController.text ||
                previous.mobileNoController.text != current.mobileNoController.text ||
                previous.status != current.status;
          },
          builder: (BuildContext context, AddNewAddressState state) {
            final bool isEnabled =
                _isSaveButtonEnabled(addNewAddressCubit, state, context);
            DebugLog.instance
                .d('CustomGradientButtonWidget isButtonEnabled: $isEnabled');

            return CustomGradientButtonWidget(
                  isButtonEnabled: isEnabled,
                  title: state.status == BaseStateStatus.loading
                      ? 'Saving...'
                      : context.appString.saveAddressKey,
                  onTap: () async {
                final String area =
                    addNewAddressCubit.state.areaController.text.trim();
                final String block =
                    addNewAddressCubit.state.blockController.text.trim();
                final String street =
                    addNewAddressCubit.state.streetNameController.text.trim();
                final String building = addNewAddressCubit
                    .state.buildingVillaController.text
                    .trim();
                final String floor =
                    addNewAddressCubit.state.floorController.text.trim();
                final String flatApartment = addNewAddressCubit
                    .state.flatApartmentController.text
                    .trim();
                final String landmark =
                    addNewAddressCubit.state.landmarkController.text.trim();

                // Get address type from AddressCubit in context
                String? addressType;
                try {
                  final AddressCubit addressCubit =
                      context.read<AddressCubit>();
                  addressType = addressCubit.state.currentSelectedAddress;
                } on Exception catch (e) {
                  DebugLog.instance.d(
                      'AddressCubit not available in context, using default address type$e');
                  addressType = AddressType.home.name;
                }

                // Validate required fields
                if (area.isEmpty ||
                    block.isEmpty ||
                    street.isEmpty ||
                    building.isEmpty) {
                  if (area.isEmpty) {
                    addNewAddressCubit.handleValidationErrorArea(
                        context.appString.pleaseEnterAreaKey);
                  }
                  if (block.isEmpty) {
                    addNewAddressCubit.handleValidationErrorBlock(
                        context.appString.pleaseEnterBlockNumberKey);
                  }
                  if (street.isEmpty) {
                    addNewAddressCubit.handleValidationErrorStreet(
                        context.appString.pleaseEnterStreetKey);
                  }
                  if (building.isEmpty) {
                    addNewAddressCubit.handleValidationErrorBuildingVilla(
                        context.appString.pleaseEnterBuildingVillaKey);
                  }
                } else {
                  // Call the API to save the address
                  await addNewAddressCubit.addUpdateAddress(
                    area: area,
                    blockNo: block,
                    streetName: street,
                    buildingVilla: building,
                    floor: floor,
                    flatApartment: flatApartment,
                    landmark: landmark,
                    addressType: addressType,
                    isEdit: isEdit,
                    addressId : myAddressId,
                      isFromAddressList :isFromAddressList
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
