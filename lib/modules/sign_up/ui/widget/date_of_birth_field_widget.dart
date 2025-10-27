import '../../../../utils/exports.dart';

/// A widget for selecting date of birth in the signup form.
/// 
/// This widget provides a text field that opens a date picker when tapped,
/// allowing users to select their date of birth.
class DateOfBirthFieldWidget extends StatelessWidget {
  /// Creates a [DateOfBirthFieldWidget].
  const DateOfBirthFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (SignupState previous, SignupState current) {
        // Only rebuild when date of birth error message changes
        return previous.dateOfBirthErrorMessage != current.dateOfBirthErrorMessage;
      },
      builder: (BuildContext context, SignupState state) {
        return CommonTextFormFieldWidget(
          controller: state.dateOfBirthController,
          label: context.appString.dateOfBirthKey,
          readOnly: true,
          input: TextInputAction.next,
          errorMsg: state.dateOfBirthErrorMessage,
          suffixIcon: Assets.svgs.icDCalender.svg(),
          suffixOnClick: () => _handleDatePicker(context),
          isEditable: true,
          onTap: () => _handleDatePicker(context),
          focusNode: state.dateOfBirthFocusNode,
          onTextSubmit: (_) {
            context
                .read<SignupCubit>()
                .moveToNextField(state.referralCodeFocusNode);
          },
        );
      },
    );
  }
  /// Handles the date picker interaction.
  /// 
  /// Clears any existing error messages and opens the date picker.
  /// Updates the signup cubit with the selected date when a date is chosen.
  Future<void> _handleDatePicker(BuildContext context) async {
    context
        .read<SignupCubit>()
        .handleValidationErrorMessageForDateOfBirth("");
    final String? formattedDate = await pickDate(context);
    if (formattedDate != null) {
      if(context.mounted) {
        context.read<SignupCubit>().updateDateOfBirth(formattedDate);
      }
    }
  }
}
