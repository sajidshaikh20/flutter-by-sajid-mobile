import '../../../../../utils/exports.dart';

/// Shimmer loading widget for order list items.
class MyOrderItemShimmer extends StatelessWidget {
  /// Whether to hide the status section in the shimmer.
  final bool isHideStatus;

  /// Creates a shimmer loading widget for order items.
  const MyOrderItemShimmer({super.key,
  this.isHideStatus= true
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: Dimens.space16,
      ),
      child: Container(
        decoration: BoxDecorationExtension.customDecoration(
          color: MainConfig.appColors.textWhiteColor,
          borderRadius: Dimens.radius8.borderRadius,
          border: Border.all(
            color: MainConfig.appColors.lightGreyColor,
            width: Dimens.borderWidth05,
          ),
        ),
        padding: const EdgeInsets.only(
          left: Dimens.space8,
          right: Dimens.space8,
          top: Dimens.space8,
        ),
        child: ShimmerEffect(
          child: Column(
            children: <Widget>[
              // -- HEADER (MyOrderListHeaderView) Skeleton
              Row(
                children: <Widget>[
                  // Icon Placeholder
                  Container(
                    width: Dimens.size32,
                    height: Dimens.size32,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: Dimens.size8),
                  // Title & subtitle placeholders
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: Dimens.size10,
                          width: double.infinity,
                          color: Colors.white,
                        ),
                        const SizedBox(height: Dimens.size6),
                        Container(
                          height: Dimens.size10,
                          width: Dimens.size100,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: Dimens.size8),
                  // Status widget placeholder
                  if(isHideStatus)
                  Container(
                    width: Dimens.size60,
                    height: Dimens.size20,
                    color: Colors.white,
                  ),
                ],
              ),

              // -- DOTTED LINE (Instead, just a thin container)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: Dimens.space8),
                child: Container(
                  height: Dimens.sizePoint5,
                  color: Colors.white,
                ),
              ),
          
              // -- MIDDLE VIEW (MyOrderMiddleView) Skeleton
              Row(
                children: <Widget>[
                  // Product image placeholder
                  Container(
                    height: Dimens.size42,
                    width: Dimens.size42,
                    color: Colors.white,
                  ),
                  const SizedBox(width: Dimens.size12),
                  // Key-value placeholders
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(height: Dimens.size10, color: Colors.white),
                            ),
                            SizedBox(
                              width: Dimens.size70,
                              child: Container(height: Dimens.size10, color: Colors.white),
                            ),
                            Expanded(
                              child: Container(height: Dimens.size10, color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(height: Dimens.size8),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(height: Dimens.size10, color: Colors.white),
                            ),
                            SizedBox(
                              width: Dimens.size70,
                              child: Container(height: Dimens.size10, color: Colors.white),
                            ),
                            Expanded(
                              child: Container(height: Dimens.size10, color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
          
              // -- Second DOTTED LINE
              Padding(
                padding: const EdgeInsets.only(top: Dimens.space8),
                child: Container(
                  height: Dimens.sizePoint5,
                  color: Colors.white,
                ),
              ),
          
              // -- BOTTOM VIEW (MyOrderListBottomView) Skeleton
              Padding(
                padding: const EdgeInsets.symmetric(vertical: Dimens.space12),
                child: Container(
                  height: Dimens.size10,
                  width: double.infinity,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}