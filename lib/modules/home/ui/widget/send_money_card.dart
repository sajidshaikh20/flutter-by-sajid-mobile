


import '../../../../utils/exports.dart';

class SendMoneyCard extends StatelessWidget {
  const SendMoneyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimens.space9, vertical: Dimens.space7),
      decoration: BoxDecoration(
        color: AppColors.serviceGridGradientDark, // light green background
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: <Widget>[
          Assets.svgs.icSendMoney
              .svg(height: Dimens.space34, width: Dimens.space34),
          Dimens.space12.widthBox,
          // Text Section
            Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CustomTextLabelWidget(
                label: "Send Your Money",
                style: context.textTheme.labelSmall?.copyWith(
                  fontSize: Dimens.fontSize10,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blackColor,
                ),
              ),
              CustomTextLabelWidget(
                label:
                "Customer Can Transfer Amount Across India.",
                style: context.textTheme.labelSmall?.copyWith(
                  fontSize: Dimens.fontSize10,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blackColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
