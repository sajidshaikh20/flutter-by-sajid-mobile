import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../utils/exports.dart';
import '../../../../app/providers/providers.dart';
import 'signup_state_helper.dart';

/// A widget for selecting date of birth in the signup form.
/// 
/// This widget provides a text field that opens a date picker when tapped,
/// allowing users to select their date of birth.
class DateOfBirthFieldWidget extends ConsumerWidget {
  /// Creates a [DateOfBirthFieldWidget].
  const DateOfBirthFieldWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SignupState initialState = SignupStateHelper.createInitialState();
    final SignupState state = ref.watch(signupNotifierProvider(initialState));
    final SignupNotifier notifier = ref.read(signupNotifierProvider(initialState).notifier);
    return CommonTextFormFieldWidget(
      controller: state.dateOfBirthController,
      label: context.appString.dateOfBirthKey,
      readOnly: true,
      input: TextInputAction.next,
      errorMsg: state.dateOfBirthErrorMessage,
      suffixIcon: Assets.svgs.icDCalender.svg(),
      suffixOnClick: () => _handleDatePicker(context, ref),
      isEditable: true,
      onTap: () => _handleDatePicker(context, ref),
      focusNode: state.dateOfBirthFocusNode,
      onTextSubmit: (_) {
        notifier.moveToNextField(state.referralCodeFocusNode);
      },
    );
  }
  
  /// Handles the date picker interaction.
  /// 
  /// Clears any existing error messages and opens the date picker.
  /// Updates the signup notifier with the selected date when a date is chosen.
  Future<void> _handleDatePicker(BuildContext context, WidgetRef ref) async {
    final SignupState initialState = SignupStateHelper.createInitialState();
    final SignupNotifier notifier = ref.read(signupNotifierProvider(initialState).notifier);
    
    notifier.handleValidationErrorMessageForDateOfBirth("");
    final String? formattedDate = await pickDate(context);
    if (formattedDate != null) {
      if(context.mounted) {
        notifier.updateDateOfBirth(formattedDate);
      }
    }
  }
}
