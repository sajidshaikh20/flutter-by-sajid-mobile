

import '../../../../../utils/exports.dart';

/// Shimmer loading widget for silver points display.
class SilverPointsShimmerWidget extends StatelessWidget {
  /// Creates a silver points shimmer widget.
  const SilverPointsShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {


    return ShimmerEffectWidget(

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Placeholder for the silver coin icon.
          Container(
            width: Dimens.size75,
            height: Dimens.size75,
            color: Colors.white,
          ),
          Dimens.size12.widthBox,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Placeholder for the "silver" title text.
                Container(
                  width: double.infinity,
                  height: Dimens.fontSize24,
                  color: Colors.white,
                ),
                const SizedBox(height: Dimens.size4),
                // Placeholder for the "8000 Pt = 80KD" text.
                Container(
                  width: Dimens.size150,
                  height: Dimens.fontSize18,
                  color: Colors.white,
                ),
                const SizedBox(height: Dimens.size4),
                // Placeholder for the progress bar.
                Container(
                  width: double.infinity,
                  height: Dimens.size10,
                  color: Colors.white,
                ),
                Dimens.size8.heightBox,
                // Placeholder for the spannable text.
                Container(
                  width: double.infinity,
                  height: Dimens.fontSize14,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
