import '../../../../utils/exports.dart';

/// A widget that displays a single store location item with store details,
/// distance, and selection state.
class StoreLocationItem extends StatelessWidget {
  /// The name of the store location.
  final String storeName;

  /// The address of the store location.
  final String address;

  /// The distance from the user's current location to the store.
  final String distance;

  /// Text indicating items that are not available at this store.
  final String itemsNotavailable;

  /// Whether this store location is currently selected.
  final bool isSelected;

  /// Whether items are not available at this store location.
  final bool? isItemsNotAvailable;

  /// List of time slots available for pickup at this store.
  final List<dynamic>? timeSlot;

  /// Callback function when the store item is tapped.
  final VoidCallback? onTap;

  /// Callback function when the map button is tapped.
  final VoidCallback? onMapTap;

  /// Callback function when the call button is tapped.
  final VoidCallback? onCallTap;

  /// Creates a [StoreLocationItem] widget.
  ///
  /// [storeName] and [address] are required parameters.
  /// Other parameters are optional and have default values.
  const StoreLocationItem({
    super.key,
    required this.storeName,
    required this.address,
    required this.itemsNotavailable,
    required this.distance,
    this.isItemsNotAvailable = false,
    this.isSelected = false,
    this.timeSlot,
    this.onTap,
    this.onMapTap,
    this.onCallTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: Dimens.size6),
        padding: const EdgeInsets.all(Dimens.space12),
        decoration: BoxDecoration(
          color: MainConfig.appColors.backgroundWhite,
          borderRadius: BorderRadius.circular(Dimens.size8),
          border: Border.all(
            width: Dimens.borderWidth05,
            color: MainConfig.appColors.lightGreyColor,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // Left section: Store Name
                Expanded(
                  child: Row(
                    children: <Widget>[
                      // Store Name Section
                      Row(
                        children: <Widget>[
                          Assets.svgs.icStore
                              .svg(width: Dimens.size16, height: Dimens.size16),
                          const SizedBox(width: Dimens.size8),
                          CustomTextLabelWidget(
                            textAlign: TextAlign.start,
                            label: storeName,
                            style: context.textTheme.titleLarge?.copyWith(
                              height: Dimens.lineHeight16
                                  .toLineHeight(Dimens.fontSize14),
                              fontWeight: FontWeight.w700,
                              color: MainConfig.appColors.textBlackColor,
                              fontSize: Dimens.fontSize14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Dimens.size12.heightBox,
            CustomTextLabelWidget(
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.start,
              label: address,
              maxLines: Dimens.digit2,
              style: context.textTheme.titleLarge?.copyWith(
                  height: Dimens.lineHeight18.toLineHeight(Dimens.fontSize14),
                  fontWeight: FontWeight.w400,
                  fontSize: Dimens.fontSize14),
            ),
            Dimens.size13.heightBox,
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CustomTextLabelWidget(
                          label: context.appString.openingHoursKey,
                          style: context.textTheme.titleLarge?.copyWith(
                              height: Dimens.lineHeight18
                                  .toLineHeight(Dimens.fontSize10),
                              fontWeight: FontWeight.w400,
                              fontSize: Dimens.fontSize10),
                        ),
                        if (timeSlot != null && timeSlot!.isNotEmpty)
                        SizedBox(
                          width: Dimens.size130,
                          child: CustomTextLabelWidget(
                            textDirection: TextDirection.ltr,
                            textAlign: getTextAlign(context),
                            label: timeSlot?.first,
                            maxLines: Dimens.maxLength2,
                            style: context.textTheme.titleLarge?.copyWith(
                                height: Dimens.lineHeight18
                                    .toLineHeight(Dimens.fontSize14),
                                fontWeight: FontWeight.w600,
                                fontSize: Dimens.fontSize14),
                          ),
                        ),
                      ],
                    ),
                  const Spacer(),
                  // Buttons Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Map Button
                      CustomGradientButtonWidget(
                        title: context.appString.mapKey,
                        width: Dimens.size75,
                        height: Dimens.size28,
                        onTap: onMapTap ?? () {

                        },
                      ),
                      const SizedBox(width: Dimens.space16),
                      // Spacing between buttons
                      CustomGradientButtonWidget(
                        title: context.appString.callKey,
                        width: Dimens.size75,
                        height: Dimens.size28,
                        onTap: onCallTap ?? () {

                        },
                      ),
                      // Call Button
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
