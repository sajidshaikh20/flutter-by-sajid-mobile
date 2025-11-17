import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../utils/exports.dart';
import '../../../../app/providers/providers.dart';
import 'signup_state_helper.dart';

/// A widget for email input in the signup form.
/// 
/// This widget provides a text field for entering email addresses
/// with validation and proper keyboard type.
class EmailWidget extends ConsumerWidget {
  /// The device type for responsive design.
  final ScreenType device;

  /// Creates an [EmailWidget].
  const EmailWidget({super.key, this.device = ScreenType.mobile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SignupState initialState = SignupStateHelper.createInitialState();
    final SignupState state = ref.watch(signupNotifierProvider(initialState));
    final SignupNotifier signUpNotifier = ref.read(signupNotifierProvider(initialState).notifier);
    
    return CommonTextFormFieldWidget(
      device: device,
      textInputType: TextInputType.emailAddress,
      controller: state.emailController,
      label: context.appString.emailIdKey,
      maxLength: Dimens.maxLength50,
      onChange: (String value) {
        if (value.validateEmailBool() ?? false) {
          signUpNotifier.handleValidationErrorMessageForEmail('');
        }
      },
      errorMsg: state.emailErrorMessage,
      input: TextInputAction.next,
      focusNode: state.emailFocusNode,
      onTextSubmit: (_) {
        signUpNotifier.moveToNextField(state.referralCodeFocusNode);
      },
      textCapitalization: TextCapitalization.none,
    );
  }
}
