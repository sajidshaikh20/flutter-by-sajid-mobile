import '../../../../utils/exports.dart';

/// [NewAddressAddWidget] is a widget to render Add New Address Screen
class NewAddressAddWidget extends StatefulWidget {
  /// Constructor for [NewAddressAddWidget]
  ///
  /// [device] parameter is optional and default value is [ScreenType.mobile]
  const NewAddressAddWidget({super.key,
    this.device = ScreenType.mobile,
    this.isEdit,
    this.isFromAddressList,
    this.myAddress,
  });

  /// [device] is a parameter to check the Device type such as [ScreenType.mobile]
  final ScreenType device;

  /// Whether this page is for editing an existing address
  final bool? isEdit;

  ///isFromAddressList
  final bool? isFromAddressList;

  /// The address to edit (only used when isEdit is true)
  final MyAddressListingResponse? myAddress;


  @override
  State<NewAddressAddWidget> createState() => _NewAddressAddWidgetState();
}

class _NewAddressAddWidgetState extends State<NewAddressAddWidget> {
  @override
  void initState() {
    super.initState();
    
    if (widget.isEdit ?? false) {
      // Form fields are already populated by the cubit's initData method
      DebugLog.instance.d('NewAddressAddWidget: Edit mode - form fields populated by cubit');
    } else {
      // Populate area field from saved address for new address
      scheduleMicrotask(() async {
        await _populateAreaFromSavedAddress();
      });
    }
  }

  /// Populate area field from saved address in SharedPreferences
  Future<void> _populateAreaFromSavedAddress() async {
    try {
      final SelectedAddressModel? savedAddress = await SharedPref.instance.getSelectedAddress();
      if (savedAddress != null && savedAddress.isValid && savedAddress.city != null && savedAddress.city!.isNotEmpty && mounted) {
      context.instance<AddNewAddressCubit>()
          .populateAreaFromSavedAddress(savedAddress.city!);
      } else if (savedAddress != null && savedAddress.isValid && savedAddress.streetAddress1 != null && savedAddress.streetAddress1!.isNotEmpty && mounted) {
        // Fallback to streetAddress1 if city is not available
      context.instance<AddNewAddressCubit>()
          .populateAreaFromSavedAddress(savedAddress.streetAddress1!);
      }
    } on Exception catch (e) {
      DebugLog.instance.e('Error populating area from saved address: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final AddNewAddressCubit addNewAddressCubit = context.instance<AddNewAddressCubit>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.whiteColor,
      body: Stack(
        children: <Widget>[
          Assets.svgs.bgFullscreenCommon.svg(
            fit: BoxFit.cover, // Adjust the image to cover the entire screen
            width: double.infinity, // Make it fill the width
            height: double.infinity, // Make it fill the height
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ProductDetailsAppBar(
                titleText: context.appString.selectNewAddressKey,
                isLastWidgetDisplay: false,
                prefixIcon: Assets.svgs.icBack
                    .svg(height: Dimens.size24, width: Dimens.size24),
              ),
              Expanded(
                child: BlocBuilder<AddNewAddressCubit, AddNewAddressState>(
                  buildWhen: (AddNewAddressState previous, AddNewAddressState current) {
                    // Rebuild when any error message changes or form data changes
                    return previous.areaErrorMessage != current.areaErrorMessage ||
                        previous.blockErrorMessage != current.blockErrorMessage ||
                        previous.streetErrorMessage != current.streetErrorMessage ||
                        previous.buildingVillaErrorMessage != current.buildingVillaErrorMessage ||
                        previous.floorErrorMessage != current.floorErrorMessage ||
                        previous.flatApartmentErrorMessage != current.flatApartmentErrorMessage ||
                        previous.landmarkErrorMessage != current.landmarkErrorMessage ||
                        previous.mobileNoErrorMessage != current.mobileNoErrorMessage ||
                        previous.areaController.text != current.areaController.text ||
                        previous.blockController.text != current.blockController.text ||
                        previous.streetNameController.text != current.streetNameController.text ||
                        previous.buildingVillaController.text != current.buildingVillaController.text ||
                        previous.floorController.text != current.floorController.text ||
                        previous.flatApartmentController.text != current.flatApartmentController.text ||
                        previous.landmarkController.text != current.landmarkController.text ||
                        previous.mobileNoController.text != current.mobileNoController.text;
                  },
                  builder: (BuildContext context, AddNewAddressState state) {
                    return SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Dimens.size16),
                            child: Column(
                              children: <Widget>[
                                const AddressHeaderWidget(),
                                // Area (auto-fetched) - read-only
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: Dimens.size25),
                                  child: CommonTextFormFieldWidget(
                                    style: context.textTheme.titleLarge
                                        ?.copyWith(
                                        height: Dimens.lineHeight30
                                            .toLineHeight(
                                            Dimens.fontSize16),
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.blackColor,
                                        fontSize: Dimens.fontSize16),
                                    cursorHeight: Dimens.size20,
                                    controller: state.areaController,
                                    label: context.appString.areaLabelKey,
                                    errorMsg: state.areaErrorMessage,
                                    input: TextInputAction.next,
                                    // keep editable in case user adjusts
                                    maxLength: Dimens.maxLength50,
                                    maxLines: 2,
                                    enableAutoHeight: true,
                                    onTextSubmit: (String p0) {
                                      addNewAddressCubit.moveToNextField(
                                          state.blockFocusNode);
                                    },
                                    onChange: (String value) {
                                      if (value.trim().isEmpty) {
                                        addNewAddressCubit.handleValidationErrorArea(
                                            context.appString.pleaseEnterAreaKey);
                                      } else {
                                        addNewAddressCubit.handleValidationErrorArea("");
                                      }
                                    },
                                  ),
                                ),
                                // Block (mandatory, digits, max 5)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: Dimens.fontSize16),
                                  child: CommonTextFormFieldWidget(
                                    cursorHeight: Dimens.size20,
                                    style: context.textTheme.titleLarge
                                        ?.copyWith(
                                        height: Dimens.lineHeight30
                                            .toLineHeight(
                                            Dimens.fontSize16),
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.blackColor,
                                        fontSize: Dimens.fontSize16),
                                    controller: state.blockController,
                                    label: context.appString.blockLabelKey,
                                    errorMsg: state.blockErrorMessage,
                                    input: TextInputAction.next,
                                    focusNode: state.blockFocusNode,
                                    textInputType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    maxLength: Dimens.maxLength5,
                                    onChange: (String value) {
                                      if (value.trim().isEmpty) {
                                        addNewAddressCubit
                                            .handleValidationErrorBlock(
                                            context.appString
                                                .pleaseEnterBlockNumberKey);
                                      } else {
                                        addNewAddressCubit
                                            .handleValidationErrorBlock("");
                                      }
                                    },
                                    onTextSubmit: (String p0) {
                                      addNewAddressCubit.moveToNextField(
                                          state.streetFocusNode);
                                    },
                                  ),
                                ),
                                // Street (mandatory, allowed chars, max 50)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: Dimens.fontSize16),
                                  child: CommonTextFormFieldWidget(
                                    cursorHeight: Dimens.size20,
                                    style: context.textTheme.titleLarge
                                        ?.copyWith(
                                        height: Dimens.lineHeight30
                                            .toLineHeight(
                                            Dimens.fontSize16),
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.blackColor,
                                        fontSize: Dimens.fontSize16),
                                    controller: state.streetNameController,
                                    label: context.appString.streetLabelKey,
                                    errorMsg: state.streetErrorMessage,
                                    maxLines: 2,
                                    enableAutoHeight: true,
                                    input: TextInputAction.next,
                                    focusNode: state.streetFocusNode,
                                    // Do not restrict typing; show inline error if invalid characters are present
                                    maxLength: Dimens.maxLength50,
                                    onChange: (String value) {
                                      // More permissive regex for street names
                                      final RegExp allowed = RegExp(r"^[a-zA-Z0-9\-_'.,\s]+$");
                                      if (value.trim().isEmpty) {
                                        addNewAddressCubit.handleValidationErrorStreet(
                                            context.appString.pleaseEnterStreetKey);
                                      } else if (!allowed.hasMatch(value)) {
                                        addNewAddressCubit.handleValidationErrorStreet(
                                            context.appString.onlyAllowedStreetCharsKey);
                                      } else {
                                        addNewAddressCubit.handleValidationErrorStreet("");
                                      }
                                    },
                                    onTextSubmit: (String p0) {
                                      addNewAddressCubit.moveToNextField(
                                          state.buildingVillaFocusNode);
                                    },
                                  ),
                                ),
                                // Building/Villa (mandatory, alphanumeric, max 50)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: Dimens.fontSize16),
                                  child: CommonTextFormFieldWidget(
                                    cursorHeight: Dimens.size20,
                                    style: context.textTheme.titleLarge
                                        ?.copyWith(
                                        height: Dimens.lineHeight30
                                            .toLineHeight(
                                            Dimens.fontSize16),
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.blackColor,
                                        fontSize: Dimens.fontSize16),
                                    controller: state.buildingVillaController,
                                    label:
                                    context.appString.buildingVillaLabelKey,
                                    errorMsg: state.buildingVillaErrorMessage,
                                    input: TextInputAction.next,
                                    focusNode: state.buildingVillaFocusNode,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r"[a-zA-Z0-9 ]")),
                                    ],
                                    maxLength: Dimens.maxLength50,
                                    maxLines: 2,
                                    enableAutoHeight: true,
                                    onChange: (String value) {
                                      if (value.trim().isEmpty) {
                                        addNewAddressCubit
                                            .handleValidationErrorBuildingVilla(
                                            context.appString
                                                .pleaseEnterBuildingVillaKey);
                                      } else {
                                        addNewAddressCubit
                                            .handleValidationErrorBuildingVilla(
                                            "");
                                      }
                                    },
                                    onTextSubmit: (String p0) {
                                      addNewAddressCubit.moveToNextField(
                                          state.floorFocusNode);
                                    },
                                  ),
                                ),
                                // Floor (optional, digits, max 5)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: Dimens.fontSize16),
                                  child: CommonTextFormFieldWidget(
                                    cursorHeight: Dimens.size20,
                                    style: context.textTheme.titleLarge
                                        ?.copyWith(
                                        height: Dimens.lineHeight30
                                            .toLineHeight(
                                            Dimens.fontSize16),
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.blackColor,
                                        fontSize: Dimens.fontSize16),
                                    controller: state.floorController,
                                    label: context.appString.floorLabelKey,
                                    errorMsg: state.floorErrorMessage,
                                    input: TextInputAction.next,
                                    focusNode: state.floorFocusNode,
                                    textInputType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    maxLength: Dimens.maxLength5,
                                    onChange: (String value) {
                                      // Optional; clear error when digits
                                      addNewAddressCubit
                                          .handleValidationErrorFloor("");
                                    },
                                    onTextSubmit: (String p0) {
                                      addNewAddressCubit.moveToNextField(
                                          state.flatApartmentFocusNode);
                                    },
                                  ),
                                ),
                                // Flat/Apartment (optional, digits, max 5)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: Dimens.fontSize16),
                                  child: CommonTextFormFieldWidget(
                                    cursorHeight: Dimens.size20,
                                    style: context.textTheme.titleLarge
                                        ?.copyWith(
                                        height: Dimens.lineHeight30
                                            .toLineHeight(
                                            Dimens.fontSize16),
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.blackColor,
                                        fontSize: Dimens.fontSize16),
                                    controller: state.flatApartmentController,
                                    label:
                                    context.appString.flatApartmentLabelKey,
                                    errorMsg: state.flatApartmentErrorMessage,
                                    input: TextInputAction.next,
                                    focusNode: state.flatApartmentFocusNode,
                                    textInputType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    maxLength: Dimens.maxLength5,
                                    onChange: (String value) {
                                      addNewAddressCubit
                                          .handleValidationErrorFlatApartment(
                                          "");
                                    },
                                    onTextSubmit: (String p0) {
                                      addNewAddressCubit.moveToNextField(
                                          state.landmarkFocusNode);
                                    },
                                  ),
                                ),
                                // Landmark (optional, alphanumeric + special, max 50)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: Dimens.fontSize16),
                                  child: CommonTextFormFieldWidget(
                                    cursorHeight: Dimens.size20,
                                    style: context.textTheme.titleLarge
                                        ?.copyWith(
                                        height: Dimens.lineHeight30
                                            .toLineHeight(
                                            Dimens.fontSize16),
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.blackColor,
                                        fontSize: Dimens.fontSize16),
                                    controller: state.landmarkController,
                                    label: context.appString.landmarkLabelKey,
                                    errorMsg: state.landmarkErrorMessage,
                                    input: TextInputAction.next,
                                    focusNode: state.landmarkFocusNode,
                                    maxLength: Dimens.maxLength50,
                                    maxLines: 2,
                                    enableAutoHeight: true,
                                    onChange: (String value) {
                                      addNewAddressCubit
                                          .handleValidationErrorLandmark("");
                                    },
                                  ),
                                ),
                                // Mobile number (follow sign-up behavior/widget)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: Dimens.fontSize16),
                                  child: CustomMobileInputWidget(
                                    device: widget.device,
                                    mobileNumberController:
                                    state.mobileNoController,
                                    initialCountryCode:
                                    state.mobileCode.isNotEmpty
                                        ? state.mobileCode
                                        : context.appString.kuwaitCountryCodeKey,
                                    focusNode: state.mobileNoFocusNode,
                                    errorMessage: state.mobileNoErrorMessage,
                                    onCountryCodeChanged: (String? code) {
                                      if (code != null && code.isNotEmpty) {
                                        addNewAddressCubit.updateMobileCode(code);
                                      }
                                    },
                                    onChange: (String value) {
                                      // Simplified mobile validation - only show error if field is not empty and invalid
                                      if (value.isEmpty) {
                                        // Empty is fine (optional field)
                                        addNewAddressCubit.handleValidationErrormobileNo('');
                                      } else if (value.validMobileBool(isRequired: false) == true) {
                                        // Valid mobile number
                                        addNewAddressCubit.handleValidationErrormobileNo('');
                                      } else {
                                        // Invalid mobile number
                                        addNewAddressCubit.handleValidationErrormobileNo(
                                            context.appString.enterValidMobileNumberKey);
                                      }
                                    },
                                  ),
                                ),
                                SaveAsSectionWidget(
                                  isEdit: widget.isEdit ?? false,
                                  addressType: widget.myAddress?.addressType,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              BlocBuilder<AddNewAddressCubit, AddNewAddressState>(
                builder: (BuildContext context, AddNewAddressState state) {
                  return SaveAddressButton(
                    addNewAddressCubit: context.read<AddNewAddressCubit>(),
                    state: state,
                    context: context,
                    isEdit: widget.isEdit ?? false,
                    isFromAddressList: widget.isFromAddressList ?? false,
                    myAddressId: widget.myAddress?.id ?? '',
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
