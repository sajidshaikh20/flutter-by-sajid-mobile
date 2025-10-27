import '../../../../utils/exports.dart';

/// Widget that displays cart total and payment method selection.
class CartTotalpayUsingWidget extends StatelessWidget {
  /// Callback function called when payment method selection is pressed.
  final VoidCallback? paymentSelectionPressed;

  /// Creates a cart total and payment widget.
  const CartTotalpayUsingWidget({super.key,
    this.paymentSelectionPressed,
  });

  @override
  Widget build(BuildContext context) {
    double totalIncFontSize = Dimens.fontSize12;

    return BlocBuilder<CartPageCubit, CartPageState>(
      builder: (BuildContext context, CartPageState state) {
        return GestureDetector(
          onTap: paymentSelectionPressed,
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Dimens.size8.heightBox,
              CustomTextLabelWithIcon(
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                maxLines: Dimens.maxLines01,
                label: context.appString.payUsingKey,
                image: Assets.svgs.icDDownArrow,
                isSuffix: true,
                style: context.textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: totalIncFontSize,
                  height: Dimens.lineHeight16.toLineHeight(totalIncFontSize),
                  color: AppColors.blackColor,
                ),
              ),

              (state.selectedPaymentMethod?.name?.isEmpty ?? true)?   CustomTextLabelWidget(
                textDirection: TextDirection.ltr,
                label: context.appString.selectPay,
                style: context.textTheme.headlineMedium
                    ?.copyWith(
                    decoration:
                    TextDecoration.underline,
                    fontWeight: FontWeight.w700,
                    color: MainConfig
                        .appColors.mainColor,
                    fontSize: Dimens.fontSize12,
                    height: Dimens.lineHeight14
                        .toLineHeight(
                        Dimens.fontSize12)),
              )
             : CustomTextLabelWidget(
                maxLines: Dimens.maxLines01,
                overflow: TextOverflow.ellipsis,
                label: state.selectedPaymentMethod?.name ?? '',
                style: context.textTheme.headlineMedium?.copyWith(
                  fontSize: totalIncFontSize,
                  fontWeight: FontWeight.w700,
                  height: Dimens.lineHeight16.toLineHeight(totalIncFontSize),
                  color: AppColors.blackColor,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

