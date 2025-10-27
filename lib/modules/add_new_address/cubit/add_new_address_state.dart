import '../../../utils/exports.dart';


///
class AddNewAddressState extends BaseState {
  /// {@macro add_new_address_state}
  const AddNewAddressState({
    required this.formKey,
    required super.status,
    super.msg = '',
    super.redirectRoute,
    // Form controllers
    required this.areaController,
    required this.blockController,
    required this.streetNameController,
    required this.buildingVillaController,
    required this.floorController,
    required this.flatApartmentController,
    required this.landmarkController,
    required this.mobileNoController,
    // Focus nodes
    required this.areaFocusNode,
    required this.blockFocusNode,
    required this.streetFocusNode,
    required this.buildingVillaFocusNode,
    required this.floorFocusNode,
    required this.flatApartmentFocusNode,
    required this.landmarkFocusNode,
    required this.mobileNoFocusNode,
    // Error messages
    this.areaErrorMessage = '',
    this.blockErrorMessage = '',
    this.streetErrorMessage = '',
    this.buildingVillaErrorMessage = '',
    this.floorErrorMessage = '',
    this.flatApartmentErrorMessage = '',
    this.landmarkErrorMessage = '',
    this.mobileNoErrorMessage = '',
    // Mobile code
    this.mobileCode = '',
  });

  /// {@macro formKey}
  final GlobalKey<FormState> formKey;
  
  // Form controllers
  /// Area controller
  final TextEditingController areaController;
  /// Block controller
  final TextEditingController blockController;
  /// Street name controller
  final TextEditingController streetNameController;
  /// Building/Villa controller
  final TextEditingController buildingVillaController;
  /// Floor controller
  final TextEditingController floorController;
  /// Flat/Apartment controller
  final TextEditingController flatApartmentController;
  /// Landmark controller
  final TextEditingController landmarkController;
  /// Mobile number controller
  final TextEditingController mobileNoController;
  
  // Focus nodes
  /// Area focus node
  final FocusNode areaFocusNode;
  /// Block focus node
  final FocusNode blockFocusNode;
  /// Street focus node
  final FocusNode streetFocusNode;
  /// Building/Villa focus node
  final FocusNode buildingVillaFocusNode;
  /// Floor focus node
  final FocusNode floorFocusNode;
  /// Flat/Apartment focus node
  final FocusNode flatApartmentFocusNode;
  /// Landmark focus node
  final FocusNode landmarkFocusNode;
  /// Mobile number focus node
  final FocusNode mobileNoFocusNode;
  
  // Error messages
  /// Area error message
  final String? areaErrorMessage;
  /// Block error message
  final String? blockErrorMessage;
  /// Street error message
  final String? streetErrorMessage;
  /// Building/Villa error message
  final String? buildingVillaErrorMessage;
  /// Floor error message
  final String? floorErrorMessage;
  /// Flat/Apartment error message
  final String? flatApartmentErrorMessage;
  /// Landmark error message
  final String? landmarkErrorMessage;
  /// Mobile number error message
  final String? mobileNoErrorMessage;
  
  // Mobile code
  /// Mobile code
  final String mobileCode;

  @override
  List<Object?> get props => <Object?>[
        ...super.props,
        areaController,
        blockController,
        streetNameController,
        buildingVillaController,
        floorController,
        flatApartmentController,
        landmarkController,
        mobileNoController,
        areaFocusNode,
        blockFocusNode,
        streetFocusNode,
        buildingVillaFocusNode,
        floorFocusNode,
        flatApartmentFocusNode,
        landmarkFocusNode,
        mobileNoFocusNode,
        areaErrorMessage,
        blockErrorMessage,
        streetErrorMessage,
        buildingVillaErrorMessage,
        floorErrorMessage,
        flatApartmentErrorMessage,
        landmarkErrorMessage,
        mobileNoErrorMessage,
        mobileCode,
      ];

  ///copyWith method
  AddNewAddressState copyWith({
    BaseStateStatus? status,
    PageRouteInfo? redirectRoute,
    String? msg,
    // Form controllers
    TextEditingController? areaController,
    TextEditingController? blockController,
    TextEditingController? streetNameController,
    TextEditingController? buildingVillaController,
    TextEditingController? floorController,
    TextEditingController? flatApartmentController,
    TextEditingController? landmarkController,
    TextEditingController? mobileNoController,
    // Focus nodes
    FocusNode? areaFocusNode,
    FocusNode? blockFocusNode,
    FocusNode? streetFocusNode,
    FocusNode? buildingVillaFocusNode,
    FocusNode? floorFocusNode,
    FocusNode? flatApartmentFocusNode,
    FocusNode? landmarkFocusNode,
    FocusNode? mobileNoFocusNode,
    // Error messages
    String? areaErrorMessage,
    String? blockErrorMessage,
    String? streetErrorMessage,
    String? buildingVillaErrorMessage,
    String? floorErrorMessage,
    String? flatApartmentErrorMessage,
    String? landmarkErrorMessage,
    String? mobileNoErrorMessage,
    // Mobile code
    String? mobileCode,
  }) {
    return AddNewAddressState(
      status: status ?? this.status,
      redirectRoute: redirectRoute,
      msg: msg,
      formKey: formKey,
      // Form controllers
      areaController: areaController ?? this.areaController,
      blockController: blockController ?? this.blockController,
      streetNameController: streetNameController ?? this.streetNameController,
      buildingVillaController: buildingVillaController ?? this.buildingVillaController,
      floorController: floorController ?? this.floorController,
      flatApartmentController: flatApartmentController ?? this.flatApartmentController,
      landmarkController: landmarkController ?? this.landmarkController,
      mobileNoController: mobileNoController ?? this.mobileNoController,
      // Focus nodes
      areaFocusNode: areaFocusNode ?? this.areaFocusNode,
      blockFocusNode: blockFocusNode ?? this.blockFocusNode,
      streetFocusNode: streetFocusNode ?? this.streetFocusNode,
      buildingVillaFocusNode: buildingVillaFocusNode ?? this.buildingVillaFocusNode,
      floorFocusNode: floorFocusNode ?? this.floorFocusNode,
      flatApartmentFocusNode: flatApartmentFocusNode ?? this.flatApartmentFocusNode,
      landmarkFocusNode: landmarkFocusNode ?? this.landmarkFocusNode,
      mobileNoFocusNode: mobileNoFocusNode ?? this.mobileNoFocusNode,
      // Error messages
      areaErrorMessage: areaErrorMessage ?? this.areaErrorMessage,
      blockErrorMessage: blockErrorMessage ?? this.blockErrorMessage,
      streetErrorMessage: streetErrorMessage ?? this.streetErrorMessage,
      buildingVillaErrorMessage: buildingVillaErrorMessage ?? this.buildingVillaErrorMessage,
      floorErrorMessage: floorErrorMessage ?? this.floorErrorMessage,
      flatApartmentErrorMessage: flatApartmentErrorMessage ?? this.flatApartmentErrorMessage,
      landmarkErrorMessage: landmarkErrorMessage ?? this.landmarkErrorMessage,
      mobileNoErrorMessage: mobileNoErrorMessage ?? this.mobileNoErrorMessage,
      // Mobile code
      mobileCode: mobileCode ?? this.mobileCode,
    );
  }
}
