import '../../../../../utils/exports.dart';

///CartListBottomViewShimmer
class CartListBottomViewShimmer extends StatelessWidget {
  ///CartListBottomViewShimmer
  const CartListBottomViewShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimens.size88,
      padding: const EdgeInsets.symmetric(
        vertical: Dimens.space7,
        horizontal: Dimens.space16,
      ),
      decoration: BoxDecoration(
        color: MainConfig.appColors.backgroundWhite,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha:Dimens.opacity025),
            offset: const Offset(1, 0),
            blurRadius: Dimens.blurRadius4,
          ),
        ],
      ),
      child: ShimmerEffect(
        child: Row(
          children: <Widget>[
            // Left side placeholders (mimics Pay Using / total area)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // First line placeholder
                  Container(
                    width: Dimens.size100,
                    height: Dimens.size14,
                    color: Colors.white,
                  ),
                  const SizedBox(height: Dimens.size8),
                  // Second line placeholder
                  Container(
                    width: Dimens.size140,
                    height: Dimens.size14,
                    color: Colors.white,
                  ),
                ],
              ),
            ),

            // Right side button placeholder (checkout/gradient button)
            const SizedBox(width: Dimens.size16),
            Container(
              width: Dimens.size138,
              height: Dimens.size44,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
