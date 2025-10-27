import '../../../../utils/exports.dart';

/// Widget that displays address selection options (current location or add new address).
class AddressOptionView extends StatelessWidget {
  /// Creates an address option view widget.
  const AddressOptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.size16),
          child: GestureDetector(
            onTap: () async {
              // Navigate to add address page with current location flag
              await context.router.push(AddNewAddressRoute(isForCurrentLocation: true));
            },
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(Dimens.size8),
                  child: Assets.svgs.icLocationArrow.svg(
                    height: Dimens.size16,
                    width: Dimens.size16,
                  ),
                ),
                Expanded(
                  child: CustomTextLabelWidget(
                    maxLines: Dimens.maxLines01,
                    textAlign: TextAlign.start,
                    style: context.textTheme.titleLarge?.copyWith(
                      height: Dimens.lineHeight16.toLineHeight(Dimens.fontSize14),
                      fontWeight: FontWeight.w700,
                      color: MainConfig.appColors.mainColor,
                      fontSize: Dimens.fontSize14,
                    ),
                    label: context.appString.userMyCurrentLocationKey,
                  ),
                ),
              ],
            ),
          ),
        ),
         Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.size16),
          child: Divider(color: MainConfig.appColors.lightGreyColor),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.size16),
          child: GestureDetector(
            onTap: () async {
              await context.router.push(AddNewAddressRoute());
              // await context.router.pushNamed(AppPaths.addAddressPage);
            },
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(Dimens.size8),
                  child: Assets.svgs.icPlus.svg(
                    height: Dimens.size16,
                    width: Dimens.size16,
                  ),
                ),
                Expanded(
                  child: CustomTextLabelWidget(
                    textAlign: TextAlign.start,
                    maxLines: Dimens.maxLines01,
                    style: context.textTheme.titleLarge?.copyWith(
                      height: Dimens.lineHeight16.toLineHeight(Dimens.fontSize14),
                      fontWeight: FontWeight.w700,
                      color: MainConfig.appColors.mainColor,
                      fontSize: Dimens.fontSize14,
                    ),
                    label: context.appString.addNewAddressKey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
