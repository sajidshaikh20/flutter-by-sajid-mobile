import '../../../../utils/exports.dart';

/// View button subwidget with light green border and text.
class ViewButtonWidget extends StatelessWidget {
  /// Creates a view button widget.
  const ViewButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        Dimens.space5
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: MainConfig.appColors.primary,
          width: Dimens.borderWidth05,
        ),
        borderRadius: Dimens.radius6.borderRadius,
      ),
      child: CustomTextLabelWidget(
        label: 'View',
        style: context.textTheme.labelMedium?.copyWith(
          color: MainConfig.appColors.primary,
          fontSize: Dimens.fontSize11,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
