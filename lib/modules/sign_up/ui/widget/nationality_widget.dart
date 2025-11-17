import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../utils/exports.dart';
import '../../../../app/providers/providers.dart';
import 'signup_state_helper.dart';

/// A widget for selecting nationality with a dropdown menu.
/// 
/// This widget provides a text field with a dropdown arrow that opens
/// a nationality selection menu when tapped.
class NationalityWidget extends ConsumerWidget {
  /// The device type for responsive design.
  final ScreenType device;

  /// Creates a [NationalityWidget].
  const NationalityWidget({super.key, this.device = ScreenType.mobile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey editTextKey = GlobalKey();
    final SignupState initialState = SignupStateHelper.createInitialState();
    final SignupState state = ref.watch(signupNotifierProvider(initialState));
    final SignupNotifier notifier = ref.read(signupNotifierProvider(initialState).notifier);
    return CommonTextFormFieldWidget(
      device: device,
      key: editTextKey,
      controller: state.nationalityController,
      label: context.appString.nationalityOnlyKey,
      errorMsg: state.nationalityErrorMessage,
      input: TextInputAction.next,
      isEditable: true,
      readOnly: true,
      suffixIcon: AnimatedRotation(
        turns: state.isMenuOpen ? 0.5 : 0, // 0.5 turns = 180 degrees
        duration: const Duration(milliseconds: 300), // Adjust duration for smoothness
        child: Assets.svgs.icDown.svg(),
      ),
      onChange: (String value) {
        notifier.handleValidationErrorMessageForNationality("");
      },
      onTap: () async {
        await clickofDropdown(context, ref, editTextKey);
      },
      suffixOnClick: () async {
        await clickofDropdown(context, ref, editTextKey);
      },
      focusNode: state.nationalityFocusNode,
      onTextSubmit: (_) {
        notifier.moveToNextField(state.dateOfBirthFocusNode);
      },
    );
  }

  /// Handles the dropdown click event to show nationality selection menu.
  /// 
  /// Opens the nationality selection menu and updates the selected nationality
  /// in the signup notifier when a selection is made.
  Future<void> clickofDropdown(BuildContext context, WidgetRef ref, GlobalKey<State<StatefulWidget>> editTextKey) async {
    final SignupState initialState = SignupStateHelper.createInitialState();
    final SignupNotifier notifier = ref.read(signupNotifierProvider(initialState).notifier);
    notifier.handleValidationErrorMessageForNationality("", isMenuOpen: true);
  }
}

/// Show a dropdown menu for selecting nationality.
