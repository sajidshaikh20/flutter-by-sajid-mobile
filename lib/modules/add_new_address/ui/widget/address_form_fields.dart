import '../../../../utils/exports.dart';

/// Common widget for address form fields
/// A widget that renders a standard address form with multiple input fields.
///
/// This widget builds input fields based on the current [AddressState] and
/// uses [AddressCubit] to handle state changes, validation, and interactions.
/// The layout adapts according to the [device] type.
class AddressFormFields extends StatelessWidget {
  /// Creates an [AddressFormFields] widget.
  ///
  /// [state] represents the current address form state.
  /// [addressCubit] manages all state updates and business logic for the form.
  /// [device] determines the layout for mobile, tablet, or desktop.
  const AddressFormFields({
    super.key,
    required this.state,
    required this.addressCubit,
    required this.device,
  });

  /// The current state of the address form.
  final AddressState state;

  /// The cubit responsible for managing the address form state.
  final AddressCubit addressCubit;

  /// The type of device layout to adapt the form's appearance.
  final ScreenType device;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Area field
        AddressTextField(
          controller: state.areaController,
          label: context.appString.areaLabelKey,
          errorMsg: state.areaErrorMessage,
          nextFocusNode: state.blockFocusNode,
          maxLength: Dimens.maxLength50,
          inputAction: TextInputAction.next,
          validationType: ValidationType.required,
          onValidation: (String value) {
            if (value.trim().isEmpty) {
              addressCubit.handleValidationErrorArea(
                  context.appString.pleaseEnterAreaKey);
            } else {
              addressCubit.handleValidationErrorArea("");
            }
          },
          onNextField: () => addressCubit.moveToNextField(state.blockFocusNode),
        ),

        // Block field
        AddressTextField(
          controller: state.blockController,
          label: context.appString.blockLabelKey,
          errorMsg: state.blockErrorMessage,
          focusNode: state.blockFocusNode,
          nextFocusNode: state.streetFocusNode,
          maxLength: Dimens.maxLength5,
          inputAction: TextInputAction.next,
          textInputType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
          ],
          validationType: ValidationType.required,
          onValidation: (String value) {
            if (value.trim().isEmpty) {
              addressCubit.handleValidationErrorBlock(
                  context.appString.pleaseEnterBlockNumberKey);
            } else {
              addressCubit.handleValidationErrorBlock("");
            }
          },
          onNextField: () => addressCubit.moveToNextField(state.streetFocusNode),
        ),

        // Street field
        AddressTextField(
          controller: state.streetNameController,
          label: context.appString.streetLabelKey,
          errorMsg: state.streetErrorMessage,
          focusNode: state.streetFocusNode,
          nextFocusNode: state.buildingVillaFocusNode,
          maxLength: Dimens.maxLength50,
          inputAction: TextInputAction.next,
          validationType: ValidationType.street,
          onValidation: (String value) {
            if (value.trim().isEmpty) {
              addressCubit.handleValidationErrorStreet(
                  context.appString.pleaseEnterStreetKey);
            } else if (!RegExpressions.instance.streetNameRegex.hasMatch(value)) {
              addressCubit.handleValidationErrorStreet(
                  context.appString.onlyAllowedStreetCharsKey);
            } else {
              addressCubit.handleValidationErrorStreet("");
            }
          },
          onNextField: () => addressCubit.moveToNextField(state.buildingVillaFocusNode),
        ),

        // Building/Villa field
        AddressTextField(
          controller: state.buildingVillaController,
          label: context.appString.buildingVillaLabelKey,
          errorMsg: state.buildingVillaErrorMessage,
          focusNode: state.buildingVillaFocusNode,
          nextFocusNode: state.floorFocusNode,
          maxLength: Dimens.maxLength50,
          inputAction: TextInputAction.next,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExpressions.instance.buildingVillaRegex),
          ],
          validationType: ValidationType.required,
          onValidation: (String value) {
            if (value.trim().isEmpty) {
              addressCubit.handleValidationErrorBuildingVilla(
                  context.appString.pleaseEnterBuildingVillaKey);
            } else {
              addressCubit.handleValidationErrorBuildingVilla("");
            }
          },
          onNextField: () => addressCubit.moveToNextField(state.floorFocusNode),
        ),

        // Floor field (optional)
        AddressTextField(
          controller: state.floorController,
          label: context.appString.floorLabelKey,
          errorMsg: state.floorErrorMessage,
          focusNode: state.floorFocusNode,
          nextFocusNode: state.flatApartmentFocusNode,
          maxLength: Dimens.maxLength5,
          inputAction: TextInputAction.next,
          textInputType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
          ],
          validationType: ValidationType.optional,
          onValidation: (String value) {
            addressCubit.handleValidationErrorFloor("");
          },
          onNextField: () => addressCubit.moveToNextField(state.flatApartmentFocusNode),
        ),

        // Flat/Apartment field (optional)
        AddressTextField(
          controller: state.flatApartmentController,
          label: context.appString.flatApartmentLabelKey,
          errorMsg: state.flatApartmentErrorMessage,
          focusNode: state.flatApartmentFocusNode,
          nextFocusNode: state.landmarkFocusNode,
          maxLength: Dimens.maxLength5,
          inputAction: TextInputAction.next,
          textInputType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
          ],
          validationType: ValidationType.optional,
          onValidation: (String value) {
            addressCubit.handleValidationErrorFlatApartment("");
          },
          onNextField: () => addressCubit.moveToNextField(state.landmarkFocusNode),
        ),

        // Landmark field (optional)
        AddressTextField(
          controller: state.landmarkController,
          label: context.appString.landmarkLabelKey,
          errorMsg: state.landmarkErrorMessage,
          focusNode: state.landmarkFocusNode,
          maxLength: Dimens.maxLength50,
          inputAction: TextInputAction.done,
          validationType: ValidationType.optional,
          onValidation: (String value) {
            addressCubit.handleValidationErrorLandmark("");
          },
        ),

        // Mobile number field
        AddressMobileField(
          state: state,
          addressCubit: addressCubit,
          device: device,
        ),
      ],
    );
  }
}

