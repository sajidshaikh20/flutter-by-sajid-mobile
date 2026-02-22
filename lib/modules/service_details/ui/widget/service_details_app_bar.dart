import '../../../../../utils/exports.dart';
import 'service_details_app_bar_back_button.dart';
import 'service_details_app_bar_right_icon_button.dart';

/// Custom app bar for service details screens.
///
/// Features:
/// - Back button in light green rounded square
/// - Dynamic label (e.g. AEPS, DMT)
/// - Optional right icon (add user) - show/hide via [showRightIcon]
class ServiceDetailsAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Creates a service details app bar.
  const ServiceDetailsAppBar({
    super.key,
    required this.label,
    this.onBackTap,
    this.onRightIconTap,
    this.showRightIcon = true,
  });

  /// Dynamic label/title (e.g. AEPS, DMT).
  final String label;

  /// Callback when back button is tapped.
  final VoidCallback? onBackTap;

  /// Callback when right icon is tapped.
  final VoidCallback? onRightIconTap;

  /// Whether to show the right-side icon. Defaults to true.
  final bool showRightIcon;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.whiteColor,
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.space16,
        vertical: Dimens.space12,
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: <Widget>[
            ServiceDetailsAppBarBackButton(
              onTap: (){
                unawaited(context.router.maybePop());
              },
            ),
            Dimens.space20.widthBox,
            CustomTextLabelWidget(
              label:
              label.toTitleCaseConvert,
              style: context.textTheme.titleMedium?.copyWith(
                fontSize: Dimens.fontSize18,
                fontWeight: FontWeight.w600,
                color: AppColors.blackColor,
              ),
            ),
            const Spacer(),
            if (showRightIcon)
              ServiceDetailsAppBarRightIconButton(onTap: onRightIconTap)
            else
              Dimens.size44.widthBox,
          ],
        ),
      ),
    );
  }
}
