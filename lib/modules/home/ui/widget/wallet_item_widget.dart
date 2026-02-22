import '../../../../utils/exports.dart';

class WalletItemWidget extends StatelessWidget {
  final String title;
  final bool showViewButton;
  final bool isVisible;
  final VoidCallback? onToggle;

  const WalletItemWidget({
    super.key,
    required this.title,
    required this.showViewButton,
    this.isVisible = true,
    this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Dimens.space14,
        horizontal: Dimens.space12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CustomTextLabelWidget(
            label: title,
            textAlign: TextAlign.start,
            maxLines: Dimens.maxLines01,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.labelSmall?.copyWith(
              fontSize: Dimens.fontSize10,
              fontWeight: FontWeight.w400,
              color: MainConfig.appColors.textBlackColor,
            ),
          ),
          Dimens.space4.heightBox,
          Row(
            children: <Widget>[
              Flexible(
                child: CustomTextLabelWidget(
                  label: isVisible ? '₹1234' : '₹****',
                  textAlign: TextAlign.start,
                  maxLines: Dimens.maxLines01,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.headlineSmall?.copyWith(
                    fontSize: Dimens.fontSize14,
                    fontWeight: FontWeight.w600,
                    color: MainConfig.appColors.textBlackColor,
                  ),
                ),
              ),
              Dimens.space4.widthBox,
              if (showViewButton)
                const ViewButtonWidget()
              else if (onToggle != null)
                GestureDetector(
                  onTap: onToggle,
                  child: !isVisible ?Assets.svgs.icVisibilityPrimary.svg() :  Icon(
                     Icons.visibility_off,
                    color: MainConfig.appColors.greyTextColor,
                    size: Dimens.size18,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
