import '../../../../utils/exports.dart';

/// A widget for first name input in the signup form.
/// 
/// This widget provides a text field for entering the user's full name
/// with validation and character limits.
class FirstNameWidget extends StatelessWidget {
  /// The device type for responsive design.
  final ScreenType device;

  /// Creates a [FirstNameWidget].
  const FirstNameWidget({super.key, this.device = ScreenType.mobile});
  @override
  Widget build(BuildContext context) {
    final SignupCubit signupCubit = context.instance<SignupCubit>();

    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (SignupState previous, SignupState current) {
        // Only rebuild when full name error message changes
        return previous.fullNameErrorMessage != current.fullNameErrorMessage;
      },
      builder: (BuildContext context, SignupState state) {
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
              signupCubit.handleValidationErrorMessageForFullName('');
            }
          },
          inputFormatters: <TextInputFormatter>[
            LengthLimitingTextInputFormatter(Dimens.size200.toInt()),
          ],
          onTextSubmit: (_) {
            context
                .read<SignupCubit>()
                .moveToNextField(state.mobileNumberFocusNode);
          },
        );
      },

    );
  }
}
