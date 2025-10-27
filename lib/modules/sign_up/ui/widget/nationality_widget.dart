import '../../../../utils/exports.dart';

/// A widget for selecting nationality with a dropdown menu.
/// 
/// This widget provides a text field with a dropdown arrow that opens
/// a nationality selection menu when tapped.
class NationalityWidget extends StatelessWidget {
  /// The device type for responsive design.
  final ScreenType device;

  /// Creates a [NationalityWidget].
  const NationalityWidget({super.key, this.device = ScreenType.mobile});

  @override
  Widget build(BuildContext context) {
    final GlobalKey editTextKey = GlobalKey();

    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (SignupState previous, SignupState current) {
        // Only rebuild when nationality error message or menu open state changes
        return previous.nationalityErrorMessage != current.nationalityErrorMessage ||
               previous.isMenuOpen != current.isMenuOpen;
      },
      builder: (BuildContext context, SignupState state) {
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
            context
                .read<SignupCubit>()
                .handleValidationErrorMessageForNationality("");
          },
          onTap: () async {
            await clickofDropdown(context, editTextKey);
          },
          suffixOnClick: () async {
            await clickofDropdown(context, editTextKey);
          },
          focusNode: state.nationalityFocusNode,
          onTextSubmit: (_) {
            context
                .read<SignupCubit>()
                .moveToNextField(state.dateOfBirthFocusNode);
          },
        );
      },
    );
  }

  /// Handles the dropdown click event to show nationality selection menu.
  /// 
  /// Opens the nationality selection menu and updates the selected nationality
  /// in the signup cubit when a selection is made.
  Future<void> clickofDropdown(BuildContext context, GlobalKey<State<StatefulWidget>> editTextKey) async {
    context
        .read<SignupCubit>()
        .handleValidationErrorMessageForNationality("",isMenuOpen: true);
    String? selectedNat = await showNationalityMenu(context, editTextKey);
    if(context.mounted) {
      context.read<SignupCubit>().updateNationality(selectedNat ?? "",isMenuOpen: false);
    }
  }
}

/// Show a dropdown menu for selecting nationality.
