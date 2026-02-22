import '../../../../utils/exports.dart';

/// Grid item widget for a single service in the All Services section.
class ServiceGridItemWidget extends StatelessWidget {
  /// Creates a service grid item widget.
  const ServiceGridItemWidget({
    super.key,
    required this.label,
    required this.icon,
  });

  /// Display label for the service.
  final String label;

  /// Icon for the service.
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: Dimens.size60,
          height: Dimens.size60,
          decoration: BoxDecoration(
            color: MainConfig.appColors.mainColor
                .withValues(alpha: Dimens.ratio015),
            borderRadius: Dimens.radius12.borderRadius,
          ),
          child: Icon(
            icon,
            color: MainConfig.appColors.mainColor,
            size: Dimens.size28,
          ),
        ),
        Dimens.space8.heightBox,
        CustomTextLabelWidget(
          label: label,
          maxLines: 2,
          style: context.textTheme.labelSmall?.copyWith(
            fontSize: Dimens.fontSize11,
            fontWeight: FontWeight.w500,
            color: MainConfig.appColors.textBlackColor,
          ),
        ),
      ],
    );
  }
}
