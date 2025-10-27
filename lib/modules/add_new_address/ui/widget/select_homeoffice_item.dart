import '../../../../utils/exports.dart';

/// A widget representing a selectable store item (e.g., home or office location).
///
/// Displays:
/// - An icon/image for the store.
/// - Store name and address.
/// - Optional "Edit" and "Delete" actions if [showEditDelete] is true.
/// - An optional "items not available" message.
///
/// The item can be visually highlighted when [isSelected] is true, and its
/// background changes if [isItemsNotAvailable] is true.
///
/// Example usage:
/// ```dart
/// SelectHomeofficeItem(
///   storeName: "My Home",
///   address: "123 Street, City",
///   image: Assets.icons.homeIcon,
///   isSelected: true,
///   onTap: () => print("Tapped"),
///   onTapEdit: () => print("Edit tapped"),
///   onTapDelete: () => print("Delete tapped"),
/// )
/// ```
class SelectHomeofficeItem extends StatelessWidget {
  /// The name of the store or saved location.
  final String storeName;

  /// The address of the store or location.
  final String address;

  /// The text label for the edit action (defaults to localized "Edit").
  final String? edit;

  /// The text label for the delete action (defaults to localized "Delete").
  final String? delete;

  /// The store icon or image.
  final SvgGenImage image;

  /// Message displayed when certain items are not available in this store.
  final String? itemsNotavailable;

  /// Whether the item is currently selected.
  final bool isSelected;

  /// Whether some items are unavailable in this store.
  final bool? isItemsNotAvailable;

  /// Whether to display the "Edit" and "Delete" actions.
  ///
  /// Defaults to `true`.
  final bool showEditDelete;

  /// Callback when the item itself is tapped.
  final VoidCallback? onTap;

  /// Callback when the edit action is tapped.
  final VoidCallback? onTapEdit;

  /// Callback when the delete action is tapped.
  final VoidCallback? onTapDelete;

  /// Creates a [SelectHomeofficeItem].
  const SelectHomeofficeItem({
    super.key,
    required this.image,
    required this.storeName,
    required this.address,
    this.itemsNotavailable,
    this.edit,
    this.delete,
    this.isItemsNotAvailable = false,
    this.isSelected = false,
    this.onTap,
    this.onTapEdit,
    this.onTapDelete,
    this.showEditDelete = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: Dimens.size6),
        padding: const EdgeInsets.all(Dimens.space12),
        decoration: BoxDecoration(
          color: isSelected
              ? MainConfig.appColors.iceBlueColor
              : ((isItemsNotAvailable ?? false)
              ? MainConfig.appColors.imageBgColor
              : AppColors.whiteColor),
          borderRadius: BorderRadius.circular(Dimens.size8),
          border: Border.all(
            color: isSelected
                ? MainConfig.appColors.mainColor
                : MainConfig.appColors.lightGreyColor,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // Left section: Store name and icon
                Expanded(
                  child: Row(
                    children: <Widget>[
                      image.svg(
                        colorFilter: ColorFilter.mode(
                          MainConfig.appColors.mainColor,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: Dimens.size8),
                      CustomTextLabelWidget(
                        textAlign: TextAlign.start,
                        label: storeName,
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
                ),

                // Right section: Edit/Delete buttons (conditionally shown)
                if (showEditDelete)
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        GestureDetector(
                          onTap: onTapEdit,
                          child: CustomTextLabelWidget(
                            textAlign: TextAlign.start,
                            label: edit ?? context.appString.editKey,
                            style: context.textTheme.titleLarge?.copyWith(
                              height: Dimens.lineHeight18
                                  .toLineHeight(Dimens.fontSize14),
                              fontWeight: FontWeight.w600,
                              color: MainConfig.appColors.mainColor,
                              fontSize: Dimens.fontSize14,
                            ),
                          ),
                        ),
                        const SizedBox(width: Dimens.size22),
                        GestureDetector(
                          onTap: onTapDelete,
                          child: CustomTextLabelWidget(
                            textAlign: TextAlign.start,
                            label: delete ?? context.appString.deleteKey,
                            style: context.textTheme.titleLarge?.copyWith(
                              height: Dimens.lineHeight18
                                  .toLineHeight(Dimens.fontSize14),
                              fontWeight: FontWeight.w600,
                              color: MainConfig.appColors.mainColor,
                              fontSize: Dimens.fontSize14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            const SizedBox(height: Dimens.size12),

            // Address
            CustomTextLabelWidget(
              textDirection: TextDirection.ltr,
              textAlign: getTextAlign(context),
              label: address,
              maxLines: Dimens.maxLines02,
              style: context.textTheme.titleLarge?.copyWith(
                height: Dimens.lineHeight18.toLineHeight(Dimens.fontSize14),
                fontWeight: FontWeight.w400,
                fontSize: Dimens.fontSize14,
              ),
            ),

            // Items not available message
            if (isItemsNotAvailable ?? false) ...<Widget>[
              const SizedBox(height: Dimens.size10),
              CustomTextLabelWidget(
                label: itemsNotavailable ?? "",
                maxLines: Dimens.maxLines02,
                textAlign: TextAlign.start,
                style: context.textTheme.titleLarge?.copyWith(
                  height: Dimens.lineHeight14.toLineHeight(Dimens.fontSize12),
                  fontWeight: FontWeight.w500,
                  color: MainConfig.appColors.redColor,
                  fontSize: Dimens.fontSize12,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
