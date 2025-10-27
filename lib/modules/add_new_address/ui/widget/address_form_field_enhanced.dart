import '../../../../utils/exports.dart';

/// A widget that renders an enhanced address form using configurable fields.
///
/// This widget builds multiple address input fields based on [AddressState] and
/// uses [AddressCubit] to handle state updates, validation, and interactions.
/// The layout can adapt based on the [device] type.
class AddressFormFieldsEnhanced extends StatelessWidget {
  /// Creates an [AddressFormFieldsEnhanced] widget.
  /// [state] represents the current address form state.
  /// [addressCubit] handles all state changes and business logic for the form.
  /// [device] allows adjusting the layout for mobile, tablet, or desktop.
  const AddressFormFieldsEnhanced({
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
    final List<AddressFieldConfig> fieldConfigs = <AddressFieldConfig>[
      AddressFieldFactory.createAreaField(
        state: state,
        addressCubit: addressCubit,
        context: context,
      ),
      AddressFieldFactory.createBlockField(
        state: state,
        addressCubit: addressCubit,
        context: context,
      ),
      AddressFieldFactory.createStreetField(
        state: state,
        addressCubit: addressCubit,
        context: context,
      ),
      AddressFieldFactory.createBuildingVillaField(
        state: state,
        addressCubit: addressCubit,
        context: context,
      ),
      AddressFieldFactory.createFloorField(
        state: state,
        addressCubit: addressCubit,
        context: context,
      ),
      AddressFieldFactory.createFlatApartmentField(
        state: state,
        addressCubit: addressCubit,
        context: context,
      ),
      AddressFieldFactory.createLandmarkField(
        state: state,
        addressCubit: addressCubit,
        context: context,
      ),
    ];

    return Column(
      children: <Widget>[
        // Generate text fields from configurations
        ...fieldConfigs.map((AddressFieldConfig config) => AddressTextFieldFactory.fromConfig(config)),

        // Mobile number field (special case)
        AddressMobileField(
          state: state,
          addressCubit: addressCubit,
          device: device,
        ),
      ],
    );
  }
}
