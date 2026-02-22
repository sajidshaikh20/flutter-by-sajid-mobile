import '../../../../utils/exports.dart';

/// Small edit/balance icon for the home app bar.
class HomeAppBarBalanceIcon extends StatelessWidget {
  const HomeAppBarBalanceIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const _BalanceEditIcon();
  }
}

/// Sub-widget: edit icon with bottom margin.
class _BalanceEditIcon extends StatelessWidget {
  const _BalanceEditIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: Dimens.space8),
      child: Icon(
        Icons.edit_outlined,
        size: Dimens.size14,
        color: MainConfig.appColors.textWhiteColor
            .withValues(alpha: Dimens.opacity06),
      ),
    );
  }
}
