import '../../../../utils/exports.dart';

/// A widget that displays the address details of an order.
///
/// This widget shows information from a [MyOrderDetailModel] and can
/// adjust its layout if it is the last item in a list.
class AddressViewDetails extends StatelessWidget {
  /// The order detail model containing the address and related information.
  final MyOrderDetailModel? myOrderDetailModel;

  /// Indicates whether this item is the last in a list.
  ///
  /// This can be used to adjust spacing or layout for the last item.
  final bool isLastItem;

  /// Creates an [AddressViewDetails] widget.
  ///
  /// [myOrderDetailModel] provides the data to display.
  /// [isLastItem] defaults to `false`.
  const AddressViewDetails({
    super.key,
    this.myOrderDetailModel,
    this.isLastItem = false,
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.space8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CustomTextLabelWidget(
            maxLines: Dimens.maxLines02,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
            label: myOrderDetailModel?.title ?? "",
            style: context.textTheme.headlineMedium?.copyWith(
              height: Dimens.lineHeight16.toLineHeight(Dimens.fontSize14),
              fontSize: Dimens.fontSize14,
              color: MainConfig.appColors.textBlackColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Dimens.size6.heightBox,
          CustomTextLabelWidget(
            textDirection: TextDirection.ltr,
            maxLines: Dimens.maxLines02,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
            label: myOrderDetailModel?.description ?? "",
            style: context.textTheme.headlineMedium?.copyWith(
              height: Dimens.lineHeight18.toLineHeight(Dimens.fontSize14),
              fontSize: Dimens.fontSize14,
              color: MainConfig.appColors.textBlackColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (!isLastItem) ...<Widget>[
            Dimens.size11.heightBox,
            CustomDivider(
              width: double.infinity,
              height: Dimens.size1,
              color: MainConfig.appColors.dividerColor,
            ),
          ],
        ],
      ),
    );
  }
}
