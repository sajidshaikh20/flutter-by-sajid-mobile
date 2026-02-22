import '../../../../utils/exports.dart';

class TransferItem extends StatelessWidget {
  const TransferItem({super.key,
    required this.icon,
    required this.label,
  });

  final Widget icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: Dimens.size56,
          height: Dimens.size56,
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: Dimens.radius6.borderRadius,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: AppColors.blackColor
                    .withValues(alpha: Dimens.opacity01),
                blurRadius: Dimens.blurRadius8,
                offset: const Offset(Dimens.offset0, Dimens.offset3),
              ),
            ],
          ),
          child: Center(
            child: Center(
              child: SizedBox(
                width: Dimens.size30,
                height: Dimens.size30,
                child: icon,
              ),
            ),
          ),
        ),
        Dimens.space8.heightBox,
        CustomTextLabelWidget(
          label: label,
          style: context.textTheme.labelMedium?.copyWith(
            color: MainConfig.appColors.textWhiteColor,
            fontSize: Dimens.fontSize14,
            fontWeight: FontWeight.w500,
            letterSpacing: 0,
            height: 1.2
          ),
        ),
      ],
    );
  }
}
