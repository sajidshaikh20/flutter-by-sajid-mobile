import '../../../../utils/exports.dart';

/// AEPS form sheet header – title and Clear All action. UI only.
class AepsFormHeader extends StatelessWidget {
  const AepsFormHeader({
    super.key,
    required this.title,
    required this.onClearTap,
  });

  final String title;
  final VoidCallback onClearTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        CustomTextLabelWidget(
          label: title,
          style: context.textTheme.headlineSmall?.copyWith(
            fontSize: Dimens.fontSize18,
            fontWeight: FontWeight.w500,
            color: AppColors.blackColor,
          ),
        ),
        GestureDetector(
          onTap: onClearTap,
          child: CustomTextLabelWidget(
            label: 'Clear All',
            style: context.textTheme.titleSmall?.copyWith(
              fontSize: Dimens.fontSize14,
              color: AppColors.greenTextColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
