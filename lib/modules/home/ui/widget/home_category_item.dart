
import '../../../../utils/exports.dart';

/// A widget that displays a single category item in the home screen categories list.
/// Shows category image, name, and handles tap interactions for navigation.
class HomeCategoryItem extends StatelessWidget {
  /// The category data model containing image, name, and other category information.
  final CategoryResponseModel categoryModel;

  /// Callback function triggered when the category item is tapped.
  final VoidCallback? onTap;

  /// Creates a [HomeCategoryItem] widget.
  ///
  /// [categoryModel] is required and contains the category data to display.
  /// [onTap] is optional and handles tap interactions.
  const HomeCategoryItem({super.key, required this.categoryModel, this.onTap});
  
  @override
  Widget build(BuildContext context) {
    double deviceWidth = context.width;
    final int totalHorizontalSpacing = 10 * (4 - 1); // Total spacing for 4 columns
    final double itemWidth = (deviceWidth.toInt() - totalHorizontalSpacing) / 4;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: SizedBox.expand(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: itemWidth,
              height: Dimens.size90,
              padding: const EdgeInsets.only(left:Dimens.space2,right: Dimens.space2,top:Dimens.space7,bottom: Dimens.space5),
                decoration: BoxDecoration(
                  color: MainConfig.appColors.backgroundGrayColor, // Background color
                  border: Border.all(
                    color:MainConfig.appColors.dukkanborderGreyLightColor, // Border color
                    width: Dimens.borderWidth05, // Border width
                  ),
                  borderRadius: Dimens.radius8.borderRadius , // Rounded corners
                ),
              child: _buildImage(),
            ),

            const SizedBox(height: Dimens.size3,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: CustomTextLabelWidget(
                maxLines: Dimens.maxLines02,
                overflow: TextOverflow.ellipsis,
                label: categoryModel.categoryName.toString(),
                style: context.textTheme.headlineMedium?.copyWith(
                    color: MainConfig.appColors.textBlackColor,
                    fontSize: Dimens.size10,
                    height: Dimens.lineHeight12.toLineHeight(Dimens.fontSize10),
                    fontWeight: FontWeight.w700),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Builds the appropriate image widget based on whether it's a network URL or local asset
  Widget _buildImage() {
    return CommonImageWidget(
      imagePath: categoryModel.categoryImage.toString(),
      fit: BoxFit.contain,
      placeHolderImage: Assets.svgs.icDukanSplashLogo.svg(),
    );
  }
}
