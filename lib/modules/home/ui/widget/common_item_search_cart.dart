import 'package:badges/badges.dart' as badges;

import '../../../../utils/exports.dart';

/// Common Item Search and Cart widget used in Home screen.
/// Displays search and cart icons with cart count badge in the app bar.
class CommonItemSearchCart extends StatelessWidget {
  /// Creates a [CommonItemSearchCart] widget.
  const CommonItemSearchCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        InkWell(
          splashFactory: NoSplash.splashFactory,
          splashColor: MainConfig.appColors.transparent,
          highlightColor: MainConfig.appColors.transparent,
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          onTap: () async {
            await context.router.push(
              const SearchRoute(),
            );
          },
          child: SizedBox(
            width: Dimens.size30,
            height: Dimens.size30,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: Dimens.space3),
              child: Assets.svgs.icHomeSearch
                  .svg(height: Dimens.size24, width: Dimens.size24),
            ),
          ),
        ),
        const SizedBox(
          width: Dimens.size12,
        ),
        InkWell(
          splashFactory: NoSplash.splashFactory,
          splashColor: MainConfig.appColors.transparent,
          highlightColor: MainConfig.appColors.transparent,
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          onTap: () async {
            await context.router.push(const CartListRoute());
          },
          child: SizedBox(
            height: Dimens.size30,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: Dimens.space3),
              margin: EdgeInsets.only(
                  right: isLanguageAlignmentLTR ? Dimens.space16 : 0,
                  left: isLanguageAlignmentLTR ? 8 : Dimens.space16),
              height: Dimens.size24,
              width: Dimens.size24,
              child: BlocBuilder<CartCountCubit, int>(
                builder: (BuildContext context, int cartCount) {
                  return badges.Badge(
                    showBadge: cartCount > 0,
                    badgeAnimation:
                        const badges.BadgeAnimation.size(toAnimate: false),
                    badgeStyle: badges.BadgeStyle(
                      padding: Dimens.space2.padding,
                      badgeColor: MainConfig.appColors.redColor,
                      elevation: 0,
                    ),
                    position: badges.BadgePosition.topEnd(
                        top: -Dimens.space9, end: -Dimens.space8),
                    badgeContent: SizedBox(
                      child: Padding(
                        padding: Dimens.space2.padding,
                        child: CustomTextLabelWidget(
                          onTap: () async {
                            await context.router.push(const CartListRoute());
                          },
                          label: cartCount.toString(),
                          style: context.textTheme.headlineMedium?.copyWith(
                              fontSize: Dimens.fontSize12,
                              height: Dimens.lineHeight14
                                  .toLineHeight(Dimens.fontSize12),
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                    child: Assets.svgs.icHomeCart
                        .svg(height: Dimens.size24, width: Dimens.size24),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
