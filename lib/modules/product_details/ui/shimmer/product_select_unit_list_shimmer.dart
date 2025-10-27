
import '../../../../utils/exports.dart';

/// Shimmer for the entire product select unit list.
class ProductSelectUnitListShimmer extends StatelessWidget {
  /// Creates a shimmer loading widget for the product select unit list.
  const ProductSelectUnitListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    // Base and highlight colors for the shimmer effect.


    return ShimmerEffectWidget(

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Mimic vertical spacing (Dimens.size12.heightBox)
          const SizedBox(height: Dimens.size12),
          
          // Shimmer placeholder for the "Select Unit" text label.
          Container(
            width: Dimens.size100, // Adjust width as needed to resemble your text.
            height: Dimens.size12,
            color: Colors.white,
          ),
          
          const SizedBox(height: Dimens.size8),
          
          // Horizontal list shimmer placeholder.
          SizedBox(
            height: Dimens.size54,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: AppConstant.dummyUnits.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(right: Dimens.size8),
                  child: Container(
                    padding: const EdgeInsets.all(Dimens.space8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white, // Shimmer overlay will animate over this.
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(Dimens.space4)),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Placeholder for the quantity label.
                        Container(
                          width: Dimens.size60, // Approximate width.
                          height: Dimens.size14, // Approximate height.
                          color: Colors.white,
                        ),
                        const SizedBox(height: Dimens.size4),
                        // Placeholder for the price label.
                        Container(
                          width: Dimens.size40, // Approximate width.
                          height: Dimens.size14,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


