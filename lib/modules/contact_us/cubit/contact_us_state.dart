import '../../../utils/exports.dart';

/// State class for managing the Contact Us screen.
///
/// Holds all the form controllers, focus nodes, error messages, and other
/// UI state like selected nationality or gender.
class ContactUsState extends BaseState {
  /// Constructs a [ContactUsState] with all required fields.
  const ContactUsState({
    required this.mobileNumberController,
    required this.fullNameController,
    required this.emailController,
    required this.writeCommentContoller,
    required this.dateOfBirthController,
    required this.editProfileModel,
    required this.phoneCode,
    required super.status,
    required this.formKey,
    required this.fullNameFocusNode,
    required this.mobileNumberFocusNode,
    required this.writeCommentFocusNode,
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
    this.writeCommnetMessage,
    this.dateOfBirthErrorMessage,
    this.genderErrorMessage,
  });

  /// Text editing controllers for form fields
  final TextEditingController mobileNumberController;

  /// Controller for the full name text field.
  /// Used to read and modify the text input programmatically.
  final TextEditingController fullNameController;

  /// Controller for the email text field.
  /// Manages the input value and allows programmatic updates.
  final TextEditingController emailController;

  /// Controller for the comment or message text field.
  /// Enables reading, updating, and clearing the user's comment.
  final TextEditingController writeCommentContoller;

  /// Controller for the date of birth text field.
  /// Used to get or set the DOB value and manage input programmatically.
  final TextEditingController dateOfBirthController;


  /// Model holding profile data
  final EditProfileModel editProfileModel;

  /// Selected phone code for mobile number
  final String? phoneCode;

  /// Form key to manage validation
  final GlobalKey<FormState> formKey;

  /// Success message after submitting the form
  final String successMsg;

  /// Currently selected nationality
  final String selectedNationality;

  // Focus nodes for managing field focus
  /// Focus node for the full name text field.
  /// Used to manage keyboard focus and field interactions.
  final FocusNode fullNameFocusNode;

  /// Focus node for the mobile number text field.
  /// Helps control focus when moving between input fields.
  final FocusNode mobileNumberFocusNode;

  /// Focus node for the email text field.
  /// Allows programmatic focus and validation handling.
  final FocusNode emailFocusNode;

  /// Focus node for the comment/message text field.
  /// Useful for controlling keyboard behavior and focus transitions.
  final FocusNode writeCommentFocusNode;

  /// Focus node for the nationality selection field.
  /// Used to manage focus when navigating between form fields.
  final FocusNode nationalityFocusNode;

  /// Focus node for the date of birth text field.
  /// Helps control focus and keyboard interactions for DOB input.
  final FocusNode dateOfBirthFocusNode;


  /// Selected gender value
  final String? selectedGender;

  /// Error message shown when the full name field fails validation.
  /// For example, if the user leaves it empty or enters invalid characters.
  final String? fullNameErrorMessage;

  /// Error message shown when the mobile number field fails validation.
  /// For example, if the number is too short or contains invalid characters.
  final String? mobileErrorMessage;

  /// Error message shown when the email field fails validation.
  /// For example, if the email format is incorrect.
  final String? emailErrorMessage;

  /// Error message or helper message for the comment/message field.
  /// Typically used if the user input is empty or exceeds a character limit.
  final String? writeCommnetMessage;

  /// Error message shown when the date of birth field fails validation.
  /// For example, if the date is in an invalid format or outside allowed range.
  final String? dateOfBirthErrorMessage;

  /// Error message shown when gender selection fails validation.
  /// Typically used if the field is required but not selected.
  final String? genderErrorMessage;


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
    writeCommnetMessage,
    dateOfBirthErrorMessage,
    genderErrorMessage,
    fullNameFocusNode,
    mobileNumberFocusNode,
    writeCommentFocusNode,
    emailFocusNode,
    nationalityFocusNode,
    dateOfBirthFocusNode,
    ...super.props,
  ];

  /// Creates a copy of the current state with updated values.
  ContactUsState copyWith({
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
    String? writeCommnetMessage,
    String? dateOfBirthErrorMessage,
    String? genderErrorMessage,
    FocusNode? firstNameFocusNode,
    FocusNode? mobileNumberFocusNode,
    FocusNode? writeCommentFocusNode,
    FocusNode? emailFocusNode,
    FocusNode? nationalityFocusNode,
    FocusNode? dateOfBirthFocusNode,
  }) {
    return ContactUsState(
      status: status ?? this.status,
      fullNameController: fullNameController,
      emailController: emailController,
      mobileNumberController: mobileNumberController,
      writeCommentContoller: writeCommentContoller,
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
      writeCommnetMessage: writeCommnetMessage ?? this.writeCommnetMessage,
      dateOfBirthErrorMessage:
      dateOfBirthErrorMessage ?? this.dateOfBirthErrorMessage,
      genderErrorMessage: genderErrorMessage ?? this.genderErrorMessage,
      fullNameFocusNode: firstNameFocusNode ?? fullNameFocusNode,
      mobileNumberFocusNode:
      mobileNumberFocusNode ?? this.mobileNumberFocusNode,
      writeCommentFocusNode:
      writeCommentFocusNode ?? this.writeCommentFocusNode,
      emailFocusNode: emailFocusNode ?? this.emailFocusNode,
      nationalityFocusNode: nationalityFocusNode ?? this.nationalityFocusNode,
      dateOfBirthFocusNode: dateOfBirthFocusNode ?? this.dateOfBirthFocusNode,
    );
  }

  /// Initializes a default instance of [ContactUsState].
  factory ContactUsState.init() {
    return ContactUsState(
      fullNameController: TextEditingController(),
      emailController: TextEditingController(text: "ghassan.ahmed@gmail.com"),
      mobileNumberController: TextEditingController(),
      writeCommentContoller: TextEditingController(),
      dateOfBirthController: TextEditingController(text: "18/03/1988"),
      status: BaseStateStatus.initial,
      editProfileModel: const EditProfileModel(),
      phoneCode: "",
      formKey: GlobalKey<FormState>(),
      fullNameFocusNode: FocusNode(),
      mobileNumberFocusNode: FocusNode(),
      writeCommentFocusNode: FocusNode(),
      emailFocusNode: FocusNode(),
      nationalityFocusNode: FocusNode(),
      dateOfBirthFocusNode: FocusNode(),
    );
  }
}
