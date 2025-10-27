import '../../../../utils/exports.dart';

/// Widget that displays selectable gift card amount options in a horizontal row.
class AmountSelectGiftCard extends StatelessWidget {
  /// Creates an amount select gift card widget.
  const AmountSelectGiftCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GiftCardCubit, GiftCardState>(
      builder: (BuildContext context, GiftCardState state) {
        return  SizedBox(
          height: Dimens.size58,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List<Widget>.generate(
              AmountModel.dummyAmounts.length,
                  (int index) {
                final AmountModel amount = AmountModel.dummyAmounts[index];
                bool isSelected = state.selectedAmountIndex == index;
                return Flexible(
                  // Keep Expanded directly under Row
                  fit: FlexFit.tight,
                  child: Padding( // Padding inside Expanded
                    padding: EdgeInsets.only(
                      left: index == 0 ? 0 : Dimens.space8,
                      right: index == AmountModel.dummyAmounts.length - 1 ? 0 : Dimens.space8,
                    ),
                    child: SelectAmountCard(
                      onTap: () {
                        context.read<GiftCardCubit>().selectAmount(index);
                      },
                      isSelect: isSelected,
                      amountLabel: amount.price,
                    ),
                  ),
                );
              },
            ),
          ),
        );

      },
    );
  }
}
