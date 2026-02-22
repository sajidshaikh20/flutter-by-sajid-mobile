import '../../../../utils/exports.dart';

/// Grid item widget for a single service in the All Services section.
class ServiceGridItemWidget extends StatelessWidget {
  /// Creates a service grid item widget.
  const ServiceGridItemWidget({
    super.key,
    required this.label,
    this.icon,
    this.onTap,
  });

  /// Display label for the service.
  final String label;

  /// Icon for the service (optional).
  final Widget? icon;

  /// Optional tap callback.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: Dimens.space10,
          horizontal: Dimens.space8,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimens.radius10),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              AppColors.serviceGridGradientLight,
              AppColors.serviceGridGradientDark,
            ],
          ),
        ),
        child: icon != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    height: Dimens.size44,
                    width: Dimens.size44,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(Dimens.radius10),
                    ),
                    child: Center(
                      child: SizedBox(
                        child: icon,
                      ),
                    ),
                  ),
                  Dimens.space8.heightBox,
                  Expanded(
                    child: CustomTextLabelWidget(
                      label: label,
                      maxLines: Dimens.maxLines02,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.labelSmall?.copyWith(
                        fontSize: Dimens.fontSize12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.blackColor,
                        height: Dimens.lineHeight14.toLineHeight(Dimens.fontSize12),
                      ),
                    ),
                  ),
                ],
              )
            : Center(
                child: CustomTextLabelWidget(
                  label: label,
                  maxLines: Dimens.maxLines03,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.labelSmall?.copyWith(
                    fontSize: Dimens.fontSize12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.blackColor,
                  ),
                ),
              ),
      ),
    );
  }
}
