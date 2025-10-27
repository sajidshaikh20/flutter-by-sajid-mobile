import '../../../utils/exports.dart';

/// State class for managing edit profile form data and validation.
/// Contains all form fields, controllers, focus nodes, and validation states.
class EditProfileState extends BaseState {
  /// Text controller for mobile number input field.
  final TextEditingController mobileNumberController;

  /// Text controller for full name input field.
  final TextEditingController fullNameController;

  /// Text controller for email input field.
  final TextEditingController emailController;

  /// Text controller for update email input field.
  final TextEditingController updateEmailController;

  /// Text controller for nationality input field.
  final TextEditingController nationalityController;

  /// Text controller for date of birth input field.
  final TextEditingController dateOfBirthController;

  /// The edit profile model containing user data.
  final EditProfileModel editProfileModel;

  /// The phone code/country code for the mobile number.
  final String? phoneCode;

  /// Form key for validation.
  final GlobalKey<FormState> formKey;

  /// Success message after successful profile update.
  final String successMsg;

  /// The selected nationality value.
  final String selectedNationality;

  /// Focus node for full name input field.
  final FocusNode fullNameFocusNode;

  /// Focus node for mobile number input field.
  final FocusNode mobileNumberFocusNode;

  /// Focus node for email input field.
  final FocusNode emailFocusNode;

  /// Focus node for nationality input field.
  final FocusNode nationalityFocusNode;

  /// Focus node for date of birth input field.
  final FocusNode dateOfBirthFocusNode;

  /// The selected gender value.
  final String? selectedGender;

  /// Error message for full name field.
  final String? fullNameErrorMessage;

  /// Error message for mobile number field.
  final String? mobileErrorMessage;

  /// Error message for email field.
  final String? emailErrorMessage;

  /// Error message for update email field.
  final String? updateEmailErrorMessage;

  /// Error message for nationality field.
  final String? nationalityErrorMessage;

  /// Error message for date of birth field.
  final String? dateOfBirthErrorMessage;

  /// Error message for gender field.
  final String? genderErrorMessage;

  /// Whether the menu is currently open.
  final bool isMenuOpen;

  /// Creates an [EditProfileState] instance.
  ///
  /// All parameters are required for proper form state management.
  const EditProfileState({
    required this.mobileNumberController,
    required this.fullNameController,
    required this.emailController,
    required this.updateEmailController,
    required this.nationalityController,
    required this.dateOfBirthController,
    required this.editProfileModel,
    required this.phoneCode,
    required super.status,
    required this.formKey,
    required this.fullNameFocusNode,
    required this.mobileNumberFocusNode,
    required this.emailFocusNode,
    required this.nationalityFocusNode,
    required this.dateOfBirthFocusNode,
    super.redirectRoute,
    super.msg,
    this.selectedNationality = "",
    this.successMsg = '',
    this.selectedGender,
    this.fullNameErrorMessage,
    this.mobileErrorMessage,
    this.emailErrorMessage,
    this.updateEmailErrorMessage,
    this.nationalityErrorMessage,
    this.dateOfBirthErrorMessage,
    this.genderErrorMessage,
    this.isMenuOpen=false
  });

  /// Gets the list of properties to use for equality comparison.
  ///
  /// Required for Equatable to properly compare instances of this class.
  @override
  List<Object?> get props => <Object?>[
    editProfileModel,
    phoneCode,
    successMsg,
    selectedNationality,
    selectedGender,
    fullNameErrorMessage,
    mobileErrorMessage,
    emailErrorMessage,
    updateEmailErrorMessage,
    nationalityErrorMessage,
    dateOfBirthErrorMessage,
    genderErrorMessage,
    fullNameFocusNode,
    mobileNumberFocusNode,
    emailFocusNode,
    nationalityFocusNode,
    dateOfBirthFocusNode,
    updateEmailController,
    ...super.props,
    isMenuOpen
  ];

  /// Creates a copy of this [EditProfileState] with optional new values.
  ///
  /// If a parameter is not provided, the current value is used.
  /// Returns a new instance with the updated values.
  EditProfileState copyWith({
    BaseStateStatus? status,
    EditProfileModel? editProfileModel,
    bool? passwordObscureText,
    PageRouteInfo? redirectRoute,
    String? msg,
    String? phoneCode,
    String? successMsg,
    String? selectedNationality,
    String? selectedGender,
    String? fullNameErrorMessage,
    String? mobileErrorMessage,
    String? emailErrorMessage,
    String? updateEmailErrorMessage,
    String? nationalityErrorMessage,
    String? dateOfBirthErrorMessage,
    String? genderErrorMessage,
    FocusNode? firstNameFocusNode,
    FocusNode? mobileNumberFocusNode,
    FocusNode? emailFocusNode,
    FocusNode? nationalityFocusNode,
    FocusNode? dateOfBirthFocusNode,
    bool? isMenuOpen
  }) {
    return EditProfileState(
      status: status ?? this.status,
      fullNameController: fullNameController,
      emailController: emailController,
      updateEmailController: updateEmailController,
      mobileNumberController: mobileNumberController,
      nationalityController: nationalityController,
      dateOfBirthController: dateOfBirthController,
      editProfileModel: editProfileModel ?? this.editProfileModel,
      phoneCode: phoneCode ?? this.phoneCode,
      formKey: formKey,
      msg: msg ?? this.msg,
      redirectRoute: redirectRoute,
      successMsg: successMsg ?? this.successMsg,
      selectedNationality: selectedNationality ?? this.selectedNationality,
      selectedGender: selectedGender ?? this.selectedGender,
      fullNameErrorMessage: fullNameErrorMessage ?? this.fullNameErrorMessage,
      mobileErrorMessage: mobileErrorMessage ?? this.mobileErrorMessage,
      emailErrorMessage: emailErrorMessage ?? this.emailErrorMessage,
      updateEmailErrorMessage: updateEmailErrorMessage ?? this.updateEmailErrorMessage,
      nationalityErrorMessage: nationalityErrorMessage ?? this.nationalityErrorMessage,
      dateOfBirthErrorMessage: dateOfBirthErrorMessage ?? this.dateOfBirthErrorMessage,
      genderErrorMessage: genderErrorMessage ?? this.genderErrorMessage,
      fullNameFocusNode: firstNameFocusNode ?? fullNameFocusNode,
      mobileNumberFocusNode: mobileNumberFocusNode ?? this.mobileNumberFocusNode,
      emailFocusNode: emailFocusNode ?? this.emailFocusNode,
      nationalityFocusNode: nationalityFocusNode ?? this.nationalityFocusNode,
      dateOfBirthFocusNode: dateOfBirthFocusNode ?? this.dateOfBirthFocusNode,
      isMenuOpen: isMenuOpen ?? this.isMenuOpen
    );
  }

  /// Creates an initial [EditProfileState] with default values.
  ///
  /// [userProfile] is optional and used to pre-populate form fields.
  /// If provided, form controllers will be initialized with user data.
  factory EditProfileState.init({UserProfileModel? userProfile}) {
    return EditProfileState(
      fullNameController: TextEditingController(text: userProfile?.customerName ?? ''),
      emailController: TextEditingController(text: userProfile?.customerEmail ?? ''),
      mobileNumberController: TextEditingController(text: userProfile?.mobileNumber ?? ''),
      nationalityController: TextEditingController(),
      dateOfBirthController: TextEditingController(), // Remove dateOfBirth reference since it doesn't exist in UserProfileModel
      status: BaseStateStatus.initial,
      editProfileModel: const EditProfileModel(), // Always use EditProfileModel, not UserProfileModel
      phoneCode: '${AppConstant.plus} ${userProfile?.prefix}',
      formKey: GlobalKey<FormState>(),
      fullNameFocusNode: FocusNode(),
      mobileNumberFocusNode: FocusNode(),
      emailFocusNode: FocusNode(),
      nationalityFocusNode: FocusNode(),
      dateOfBirthFocusNode: FocusNode(),
      updateEmailController: TextEditingController()
    );
  }
}
