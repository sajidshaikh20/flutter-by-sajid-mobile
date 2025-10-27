import '../../../../utils/exports.dart';

/// A widget for displaying an available store in a list with its details.
class SelectAvailableStoreWidget extends StatelessWidget {
  /// The name of the store.
  final String storeName;

  /// The address of the store.
  final String address;

  /// The distance to the store.
  final String distance;

  /// A message indicating if some items are not available at the store.
  final String itemsNotavailable;

  /// Indicates if the store is currently selected.
  final bool isSelected;

  /// Indicates if some items are not available at the store.
  final bool? isItemsNotAvailable;

  /// Callback function to execute when the store is tapped.
  final VoidCallback? onTap;

  /// Creates a [SelectAvailableStoreWidget].
  ///
  /// [storeName], [address], [itemsNotavailable], and [distance] are required.
  /// [isItemsNotAvailable] defaults to false.
  /// [isSelected] defaults to false.
  const SelectAvailableStoreWidget({
    super.key,
    required this.storeName,
    required this.address,
    required this.itemsNotavailable,
    required this.distance,
    this.isItemsNotAvailable = false,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: Dimens.size6),
        padding: const EdgeInsets.all(Dimens.size12),
        decoration: BoxDecoration(
          color: isSelected
              ? MainConfig.appColors.iceBlueColor
              : ((isItemsNotAvailable ?? false)
                  ? MainConfig.appColors.imageBgColor
                  : AppColors.whiteColor),
          borderRadius: BorderRadius.circular(Dimens.size8),
          border: Border.all(
            color: isSelected ? MainConfig.appColors.mainColor : MainConfig.appColors.lightGreyColor,
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
                            overflow: TextOverflow.ellipsis,
                            maxLines: Dimens.maxLines01,
                            style: context.textTheme.titleLarge?.copyWith(
                              height: Dimens.lineHeight16
                                  .toLineHeight(Dimens.fontSize14),
                              fontWeight: FontWeight.w700,
                              color: AppColors.blackColor,
                              fontSize: Dimens.fontSize14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Right section: Distance and Check Icon
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      // Distance and Check Icon Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          CustomTextLabelWidget(
                            textDirection: TextDirection.ltr,
                            textAlign: TextAlign.start,
                            label: distance, // Example: "4 km"
                            style: context.textTheme.titleLarge?.copyWith(
                              height: Dimens.lineHeight16
                                  .toLineHeight(Dimens.fontSize12),
                              fontWeight: FontWeight.w700,
                              color: MainConfig.appColors.mainColor,
                              fontSize: Dimens.fontSize12,
                            ),
                          ),
                          const SizedBox(width: Dimens.size12),
                          Assets.svgs.icCheckSelect.svg(
                            width: Dimens.size16,
                            height: Dimens.size16,
                            colorFilter: ColorFilter.mode(
                              isSelected
                                  ? MainConfig.appColors.mainColor
                                  : MainConfig.appColors.dividerGreyColor,
                              BlendMode.srcIn,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: Dimens.size12),
            CustomTextLabelWidget(
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.start,
              label: address,
              maxLines: Dimens.maxLines02,
              style: context.textTheme.titleLarge?.copyWith(
                  height: Dimens.lineHeight18.toLineHeight(Dimens.fontSize14),
                  fontWeight: FontWeight.w400,
                  fontSize: Dimens.fontSize14),
            ),
            if (isItemsNotAvailable ?? false)
              const SizedBox(height: Dimens.size10),
            if (isItemsNotAvailable ?? false)
              CustomTextLabelWidget(
                textDirection: TextDirection.ltr,
                label: itemsNotavailable,
                maxLines: Dimens.maxLines02,
                textAlign: getTextAlign(context),
                style: context.textTheme.titleLarge?.copyWith(
                  height: Dimens.lineHeight14.toLineHeight(Dimens.fontSize12),
                  fontWeight: FontWeight.w500,
                  color: MainConfig.appColors.redColor,
                  fontSize: Dimens.fontSize12,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
