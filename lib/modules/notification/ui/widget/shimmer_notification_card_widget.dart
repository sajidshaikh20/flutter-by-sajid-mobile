import '../../../../utils/exports.dart';

/// A shimmer effect widget for loading state of notifications.
class ShimmerNotificationCardWidget extends StatelessWidget {
  /// Creates a `ShimmerNotificationCardWidget`.
  const ShimmerNotificationCardWidget({super.key});

  @override
  Widget build(BuildContext context) =>
      ShimmerEffect(

        child: Column(
          children: <Widget>[
            // The main content
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimens.size16,
                vertical: Dimens.size12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Circle Icon Placeholder
                      Container(
                        width: Dimens.size40,
                        height: Dimens.size40,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: Dimens.size16),
                      // Expanded column for text placeholders
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // Title & Time Row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                // Notification Title placeholder
                                Container(
                                  width: Dimens.size120,
                                  height: Dimens.size14,
                                  color: Colors.white,
                                ),
                                // Notification Time placeholder
                                Container(
                                  width: Dimens.size60,
                                  height: Dimens.size14,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                            const SizedBox(height: Dimens.size4),
                            // Notification Type Row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                // Notification Type placeholder
                                Container(
                                  width: Dimens.size80,
                                  height: Dimens.size14,
                                  color: Colors.white,
                                ),
                                // Pink dot placeholder
                                Container(
                                  width: Dimens.size8,
                                  height: Dimens.size8,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: Dimens.size4),
                            // Notification Details placeholder
                            Container(
                              width: double.infinity,
                              height: Dimens.size14,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Divider line placeholder
            Container(
              height: Dimens.size1,
              color: Colors.white,
            ),
          ],
        ),
      );

}
