import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../utils/exports.dart';
import '../../../../app/providers/providers.dart';
import 'signup_state_helper.dart';

/// A widget for first name input in the signup form.
/// 
/// This widget provides a text field for entering the user's full name
/// with validation and character limits.
class FirstNameWidget extends ConsumerWidget {
  /// The device type for responsive design.
  final ScreenType device;

  /// Creates a [FirstNameWidget].
  const FirstNameWidget({super.key, this.device = ScreenType.mobile});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SignupState initialState = SignupStateHelper.createInitialState();
    final SignupState state = ref.watch(signupNotifierProvider(initialState));
    final SignupNotifier signupNotifier = ref.read(signupNotifierProvider(initialState).notifier);
    
    return CommonTextFormFieldWidget(
      device: device,
      controller: state.fullNameController,
      input: TextInputAction.next,
      maxLength: Dimens.maxLength50,
      errorMsg: state.fullNameErrorMessage,
      focusNode: state.firstNameFocusNode,
      label: context.appString.fullNameKey,
      onChange: (String value) {
        if (value.validateFirstLastNameField() == true) {
          signupNotifier.handleValidationErrorMessageForFullName('');
        }
      },
      inputFormatters: <TextInputFormatter>[
        LengthLimitingTextInputFormatter(Dimens.size200.toInt()),
      ],
      onTextSubmit: (_) {
        signupNotifier.moveToNextField(state.mobileNumberFocusNode);
      },
    );
  }
}
