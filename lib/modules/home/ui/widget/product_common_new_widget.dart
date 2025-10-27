
import '../../../../utils/exports.dart';
///ProductCommonNewWidget
class ProductCommonNewWidget extends StatelessWidget {

  ///label
  final String? label;

  /// constructor ProductCommonNewWidget
  const ProductCommonNewWidget({super.key, this.label});

  @override
  Widget build(BuildContext context) {

    return  Container(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.space3,vertical: Dimens.space5),
        decoration: BoxDecoration(
          color: MainConfig.appColors.redColor,
          borderRadius: BorderRadius.vertical(
            bottom: Dimens.radius8.circularRadius,

          ),
        ),
        margin:  EdgeInsets.only(left:context.isEnglishLanguage? Dimens.space7:Dimens.zero,right:context.isEnglishLanguage? Dimens.zero:Dimens.space7),
        child:  CustomTextLabelWidget(
          label: label ?? context.appString.newKey,
          style: context.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.whiteColor,
              fontSize: Dimens.fontSize12,
              height:
              Dimens.lineHeight14.toLineHeight(Dimens.fontSize12)),
        ));
  }
}
