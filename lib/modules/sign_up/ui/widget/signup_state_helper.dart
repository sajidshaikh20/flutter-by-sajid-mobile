import '../../../../utils/exports.dart';
import '../../state/signup_state.dart';

/// Helper class to create consistent initial signup state across widgets
class SignupStateHelper {
  /// Creates a standard initial signup state
  static SignupState createInitialState() {
    return SignupState(
      status: BaseStateStatus.initial,
      firstNameFocusNode: FocusNode(),
      nationalityFocusNode: FocusNode(),
      mobileNumberFocusNode: FocusNode(),
      emailFocusNode: FocusNode(),
      passwordFocusNode: FocusNode(),
      referralCodeFocusNode: FocusNode(),
      dateOfBirthFocusNode: FocusNode(),
      fullNameController: TextEditingController(),
      nationalityController: TextEditingController(),
      mobileController: TextEditingController(),
      passwordController: TextEditingController(),
      referralCodeController: TextEditingController(),
      dateOfBirthController: TextEditingController(),
      emailController: TextEditingController(),
      formKey: GlobalKey<FormState>(),
      cmsResponseModel: CmsResponseModel(),
    );
  }
}


