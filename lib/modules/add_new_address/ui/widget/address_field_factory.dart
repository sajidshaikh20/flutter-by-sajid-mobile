import '../../../../utils/exports.dart';

/// Factory class to create address field configurations
class AddressFieldFactory {
  // Private constructor to prevent instantiation
  AddressFieldFactory._();

  ///createAreaField function
  static AddressFieldConfig createAreaField({
    required AddressState state,
    required AddressCubit addressCubit,
    required BuildContext context,
  }) {
    return AddressFieldConfig(
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
            context.appString.pleaseEnterAreaKey,
          );
        } else {
          addressCubit.handleValidationErrorArea("");
        }
      },
      onNextField: () => addressCubit.moveToNextField(state.blockFocusNode),
    );
  }

  ///createBlockField
  static AddressFieldConfig createBlockField({
    required AddressState state,
    required AddressCubit addressCubit,
    required BuildContext context,
  }) {
    return AddressFieldConfig(
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
    );
  }

  ///createStreetField
  static AddressFieldConfig createStreetField({
    required AddressState state,
    required AddressCubit addressCubit,
    required BuildContext context,
  }) {
    return AddressFieldConfig(
      controller: state.streetNameController,
      label: context.appString.streetLabelKey,
      errorMsg: state.streetErrorMessage,
      focusNode: state.streetFocusNode,
      nextFocusNode: state.buildingVillaFocusNode,
      maxLength: Dimens.maxLength50,
      inputAction: TextInputAction.next,
      validationType: ValidationType.street,
      onValidation: (String value) {
        final RegExp allowed = RegExpressions.instance.streetNameRegex;
        if (value.trim().isEmpty) {
          addressCubit.handleValidationErrorStreet(
              context.appString.pleaseEnterStreetKey);
        } else if (!allowed.hasMatch(value)) {
          addressCubit.handleValidationErrorStreet(
              context.appString.onlyAllowedStreetCharsKey);
        } else {
          addressCubit.handleValidationErrorStreet("");
        }
      },
      onNextField: () =>
          addressCubit.moveToNextField(state.buildingVillaFocusNode),
    );
  }

  ///CreateBuildingVillaField
  static AddressFieldConfig createBuildingVillaField({
    required AddressState state,
    required AddressCubit addressCubit,
    required BuildContext context,
  }) {
    return AddressFieldConfig(
      controller: state.buildingVillaController,
      label: context.appString.buildingVillaLabelKey,
      errorMsg: state.buildingVillaErrorMessage,
      focusNode: state.buildingVillaFocusNode,
      nextFocusNode: state.floorFocusNode,
      maxLength: Dimens.maxLength50,
      inputAction: TextInputAction.next,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(
            RegExpressions.instance.buildingVillaRegex),
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
    );
  }

  ///createFloorField
  static AddressFieldConfig createFloorField({
    required AddressState state,
    required AddressCubit addressCubit,
    required BuildContext context,
  }) {
    return AddressFieldConfig(
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
      onNextField: () =>
          addressCubit.moveToNextField(state.flatApartmentFocusNode),
    );
  }

  ///createFlatApartmentField
  static AddressFieldConfig createFlatApartmentField({
    required AddressState state,
    required AddressCubit addressCubit,
    required BuildContext context,
  }) {
    return AddressFieldConfig(
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
    );
  }

  ///createLandmarkField
  static AddressFieldConfig createLandmarkField({
    required AddressState state,
    required AddressCubit addressCubit,
    required BuildContext context,
  }) {
    return AddressFieldConfig(
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
    );
  }
}
