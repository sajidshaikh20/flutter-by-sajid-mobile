import '../../../../../utils/exports.dart';

/// A widget that displays a shimmer effect in either a grid or list view
/// depending on the screen type and layout preference.
///
/// This class provides a loading placeholder in the form of a shimmer effect
/// while content is being fetched, allowing for a smooth user experience.
class ShimmerListView extends StatelessWidget {
  /// A widget that displays a shimmer effect in either a grid or list view
  /// depending on the screen type and layout preference.
  const ShimmerListView({
    super.key,
    this.device = ScreenType.mobile,
    this.isGridView = true,
  });

  /// The type of device (screen size) that the widget is being rendered on.
  /// It helps in managing different layouts based on device screen size.
  final ScreenType device;

  /// A flag to determine whether the layout should be displayed as a grid view.
  /// If null, a default layout (like a list view) will be used.
  final bool? isGridView;

  @override
  Widget build(BuildContext context) {
    int crossAxisCount =
        device == ScreenType.tablet ? Dimens.maxLines03 : Dimens.maxLines02;
    const double heightMobTab120_160 = Dimens.space100;
    const double heightMobTab15_20 = Dimens.space15;
    deviceDimens(crossAxisCount, heightMobTab120_160, heightMobTab15_20);

    Widget fixedCommonContainer() => CommonContainer(
          width: heightMobTab120_160,
          height: heightMobTab15_20,
          backgroundColor: Colors.grey[Dimens.colorBand400],
        );

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: Dimens.space8,
        vertical: Dimens.space8,
      ),
      child: (isGridView ?? false)
          ? CommonGridView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: Dimens.ratio07, // Adjust for card height
                crossAxisSpacing: Dimens.space8,
                mainAxisSpacing: Dimens.space8,
              ),
              itemBuilder: (BuildContext context, int index) => Container(
                padding: const EdgeInsets.all(Dimens.space8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Dimens.space8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Image Placeholder
                    CommonContainer(
                      width: double.infinity,
                      height: heightMobTab120_160,
                      backgroundColor: Colors
                          .grey[Dimens.colorBand400], // Placeholder for image
                    ),
                    Dimens.size8.heightBox,
                    // Placeholder for offer tag (40% off)
                    CommonContainer(
                      width: Dimens.space40,
                      height: heightMobTab15_20,
                      backgroundColor: Colors.grey[Dimens.colorBand400],
                    ),
                    Dimens.size8.heightBox,
                    // Placeholder for product title
                    CommonContainer(
                      width: double.infinity,
                      height: heightMobTab15_20,
                      backgroundColor: Colors.grey[Dimens.colorBand400],
                    ),
                    Dimens.size8.heightBox,
                    // Placeholder for product price
                    CommonContainer(
                      width: Dimens.space80,
                      height: heightMobTab15_20,
                      backgroundColor: Colors.grey[Dimens.colorBand400],
                    ),
                    Dimens.size8.heightBox,

                    // Placeholder for original price
                    CommonContainer(
                      width: Dimens.space50,
                      height: heightMobTab15_20,
                      backgroundColor: Colors.grey[Dimens.colorBand400],
                    ),
                  ],
                ),
              ),
              itemCount: Dimens.maxLines06, // Number of shimmer items
            )
          : ListView.builder(
              itemBuilder: (BuildContext context, int index) => Padding(
                padding: const EdgeInsets.only(bottom: Dimens.space10),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: Dimens.space8.borderRadius,
                    border: Border.all(
                      color: MainConfig.appColors.borderLightWhiteColor,
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      // Image Placeholder
                      Container(
                        width: heightMobTab120_160,
                        height: heightMobTab120_160,
                        color: Colors
                            .grey[Dimens.colorBand400], // Placeholder for image
                      ),
                      Dimens.size8.widthBox,

                      // Placeholder for product title
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                fixedCommonContainer(),
                                Dimens.size5.widthBox,
                                fixedCommonContainer(),
                              ],
                            ),
                            Dimens.size8.heightBox,
                            // Placeholder for product price
                            fixedCommonContainer(),
                            Dimens.size8.heightBox,
                            // Placeholder for original price
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: Dimens.space8),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: CommonContainer(
                                  width: Dimens.space50,
                                  height: heightMobTab15_20,
                                  backgroundColor:
                                      Colors.grey[Dimens.colorBand400],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              itemCount: Dimens.maxLines06,
            ),
    );
  }

  /// This method sets the dimensions based on the type of device
  /// (mobile, tablet, or desktop).
  /// It adjusts values like `crossAxisCount` (grid columns) and
  /// specific heights
  /// for mobile and tablet devices with different size ranges.
  void deviceDimens(
    int crossAxisCount,
    // The number of columns in the grid (based on device type).
    double heightMobTab120_160,
    // Height for mobile/tablet devices in the range of 120-160 units.
    double heightMobTab15_20,
    // Height for mobile/tablet devices in the range of 15-20 units.
  ) {
    switch (device) {
      case ScreenType.tablet:
        // Adjust values for tablet devices
        crossAxisCount =
            Dimens.maxLines03; // Set the number of grid columns for tablets
        heightMobTab120_160 =
            Dimens.space160; // Set height for tablet devices in 120-160 range
        heightMobTab15_20 =
            Dimens.space20; // Set height for tablet devices in 15-20 range
      case ScreenType.mobile:
      // Adjust values for mobile devices (no specific changes yet)
      // You can add any specific mobile handling logic here if needed.

      case ScreenType.desktop:
      // Adjust values for desktop devices (no specific changes yet)
      // Desktop dimensions might be added later if necessary.
    }
  }
}
