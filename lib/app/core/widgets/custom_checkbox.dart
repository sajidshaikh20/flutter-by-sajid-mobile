import '../../../utils/exports.dart';

/// A custom checkbox widget that uses SVG icons for checked and unchecked states.
class CustomCheckbox extends StatelessWidget {
  /// Indicates whether the checkbox is currently checked or not.
  final bool isChecked;

  /// A callback function that is called when the checkbox's state changes.
  ///
  /// The callback receives a boolean value representing the new checked state.
  final ValueChanged<bool> onChanged;

  /// Creates a [CustomCheckbox].
  ///
  /// The [isChecked] and [onChanged] parameters must not be null.
  const CustomCheckbox({
    super.key,
    /// whether this checkbox is checked.
    ///
    /// Defaults to false.
    ///
    /// Must not be null.
    required this.isChecked,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!isChecked); // Toggle the checkbox state
      },
      child: isChecked
          ? Assets.svgs.icCheckedCheckbox.svg()  // Render checked SVG icon
          : Assets.svgs.icUnchekedCheckbox.svg(),  // Render unchecked SVG icon
    );
  }
}
