import '../../../../utils/exports.dart';

/// A bottom sheet widget that displays order details including
/// date/time, transaction ID, and order number.
class OrderDetailsBottomSheet extends StatelessWidget {
  /// Creates an [OrderDetailsBottomSheet] instance.
  const OrderDetailsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartPageCubit, CartPageState>(
      builder: (BuildContext context, CartPageState state) {
        // Use dynamic data from API response, fallback to static data if empty
        final String dateTime = state.orderDateTime?.isNotEmpty ?? false
            ? state.orderDateTime! 
            : "";
        
        final String transactionId = state.transactionId?.isNotEmpty ?? false
            ? state.transactionId! 
            : "";

        final String orderId = state.orderId?.toString().isNotEmpty ?? false
            ? state.orderId.toString() 
            : "";


        return Center(
          child: Padding(
            padding: const EdgeInsets.only(
              left: Dimens.space16,
              right: Dimens.space16,
              top: Dimens.space23,
              bottom: Dimens.space8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildOrderDetailRow(
                  context,
                  label: context.appString.dateAndTimeKey,
                  value: dateTime,
                ),
                const SizedBox(height: Dimens.size2),
                _buildOrderDetailRow(
                  context,
                  label: context.appString.transactionIdKey,
                  value: transactionId,
                ),
                const SizedBox(height: Dimens.size2),
                _buildOrderDetailRow(
                  context,
                  label: context.appString.orderNoKey,
                  value: orderId,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Builds a row for displaying order detail information.
  Widget _buildOrderDetailRow(
    BuildContext context, {
    required String label,
    required String value,
    bool isPaidAmount = false,
  }) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: Dimens.size90,
          child: CustomTextLabelWidget(
            label: label,
            overflow: TextOverflow.clip,
            textAlign: TextAlign.start,
            style: context.textTheme.titleLarge?.copyWith(
              height: Dimens.lineHeight14.toLineHeight(Dimens.fontSize12),
              fontWeight: FontWeight.w500,
              fontSize: Dimens.fontSize12,
            ),
          ),
        ),
        const SizedBox(width: Dimens.size8),
        CustomTextLabelWidget(
          label: ':',
          overflow: TextOverflow.clip,
          style: context.textTheme.titleLarge?.copyWith(
            height: Dimens.lineHeight14.toLineHeight(Dimens.fontSize12),
            fontWeight: FontWeight.w500,
            fontSize: Dimens.fontSize12,
          ),
        ),
        const SizedBox(width: Dimens.size8),
        CustomTextLabelWidget(
          label: value,
          overflow: TextOverflow.clip,
          style: context.textTheme.titleLarge?.copyWith(
            height: Dimens.lineHeight14.toLineHeight(Dimens.fontSize12),
            fontWeight: FontWeight.w500,
            fontSize: Dimens.fontSize12,
            color: isPaidAmount ? MainConfig.appColors.greenColor : null,
          ),
        ),
      ],
    );
  }
}
