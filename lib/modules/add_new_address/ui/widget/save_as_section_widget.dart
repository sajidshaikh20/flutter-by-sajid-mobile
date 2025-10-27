import '../../../../utils/exports.dart';

/// A widget that displays a **"Save As"** section.
///
/// This section contains:
/// - A title label ("Save As") styled according to the app's theme.
/// - A [SelectLocationWidget] for choosing a location.
///
/// Typically used in forms or dialogs where the user needs to
/// specify where to save a file or data.
class SaveAsSectionWidget extends StatelessWidget {
  /// Creates a [SaveAsSectionWidget].
  const SaveAsSectionWidget({
    super.key,
    this.isEdit = false,
    this.addressType,
  });

  /// Whether this widget is in edit mode
  final bool isEdit;

  /// The address type to pre-select when in edit mode
  final String? addressType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Dimens.size24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          /// Title label for the section.
          CustomTextLabelWidget(
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.blackColor,
              fontSize: Dimens.fontSize14,
            ),
            textAlign: TextAlign.start,
            label: context.appString.saveAsKey,
          ),

          /// Location selection dropdown/input widget.
          Padding(
            padding: const EdgeInsets.only(top: Dimens.size12, bottom: Dimens.size16),
            child: SelectLocationWidget(
              isEdit: isEdit,
              addressType: addressType,
            ),
          ),
        ],
      ),
    );
  }
}
