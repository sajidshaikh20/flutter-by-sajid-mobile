import '../../../../../utils/exports.dart';

/// Full-width button: horizontal green gradient, "Add New Beneficiary Account"
/// text on the left, white rounded square with black plus icon on the right.
/// Uses app primary and primaryDark for gradient (horizontal, 90deg).
class AddNewBeneficiaryButton extends StatelessWidget {
  const AddNewBeneficiaryButton({
    super.key,
    this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final Color primary = MainConfig.appColors.primary;
    final Color primaryDark = MainConfig.appColors.primaryDark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Dimens.radius24),
        splashColor: AppColors.whiteColor.withValues(alpha: 0.2),
        highlightColor: AppColors.whiteColor.withValues(alpha: 0.1),
        child: Container(
          height: Dimens.size52,
          padding: const EdgeInsets.symmetric(
            horizontal: Dimens.space20,
            vertical: Dimens.space12,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimens.radius10),
            gradient: LinearGradient(
              end: Alignment.centerRight,
              colors: <Color>[primary, primaryDark],
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CustomTextLabelWidget(
                label: 'Add New Beneficiary Account',
                maxLines: Dimens.maxLines01,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.titleMedium?.copyWith(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.w500,
                  fontSize: Dimens.fontSize14,
                ),
              ),
              Container(
                width: Dimens.size28,
                height: Dimens.size28,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(Dimens.radius6),
                ),
                child: const Icon(
                  Icons.add,
                  size: Dimens.size16,
                  color: AppColors.blackColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
