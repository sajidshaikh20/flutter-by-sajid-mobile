import '../../../../utils/exports.dart';

/// One row for the Select Bank list: fingerprint icon, [name], enabled/disabled arrow.
/// Used inside [showSelectBankBottomSheet].
class SelectBankListItem extends StatelessWidget {
  const SelectBankListItem({
    super.key,
    required this.name,
    required this.enabled,
  });

  final String name;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return _SelectBankListItemContent(name: name, enabled: enabled);
  }
}

/// Private sub-widget: single bank row UI.
class _SelectBankListItemContent extends StatelessWidget {
  const _SelectBankListItemContent({
    required this.name,
    required this.enabled,
  });

  final String name;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: enabled
            ? () {
                Navigator.of(context).pop();
                displaySnackBar('$name selected', context);
              }
            : () {
                displaySnackBar('$name is not available', context);
              },
        borderRadius: BorderRadius.circular(Dimens.radius12),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: Dimens.space4),
                decoration: BoxDecoration(
                  color: AppColors.whiteShadeOfSmoke,
                  borderRadius: BorderRadius.circular(Dimens.radius50),
                  border: Border.all(color: AppColors.greyBorderColor),
                ),
                child: Row(
                  children: <Widget>[
                    Dimens.space16.widthBox,
                    _FingerprintIcon(),
                    Dimens.space16.widthBox,
                    CustomTextLabelWidget(
                      label: name,
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Dimens.space9.widthBox,
            _ArrowIcon(enabled: enabled),
          ],
        ),
      ),
    );
  }
}

class _FingerprintIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Assets.svgs.icFingerPrint.svg(
        width: Dimens.size30,
        height: Dimens.size30,
      ),
    );
  }
}

class _ArrowIcon extends StatelessWidget {
  const _ArrowIcon({required this.enabled});

  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return enabled
        ? Assets.svgs.icEnabledBank.svg(
            width: Dimens.size32,
            height: Dimens.size32,
          )
        : Assets.svgs.icDesabledBank.svg(
            width: Dimens.size32,
            height: Dimens.size32,
          );
  }
}
