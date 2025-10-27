import '../../../../utils/exports.dart';
import 'shimmer/wallet_transaction_list_shimmer.dart';

/// Widget that displays the main points history page with header and transaction list.
class PointsHistoryPageWidget extends StatelessWidget {
  /// Creates a points history page widget.
  const PointsHistoryPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Sticky Header
        const PointHistoryTopViewWidget(),

        // Scrollable content
        BlocBuilder<PointsHistoryCubit, PointsHistoryState>(
  builder: (BuildContext context, PointsHistoryState state) {
    return

      Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Dimens.space11.heightBox,
               state.status==BaseStateStatus.success ?

               CustomListView(
                    isPadding: true,
                    scrollPhysics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext p0, int index) {
                      final WalletTransaction model =
                      AppConstant.walletTransactions[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimens.space16,
                            vertical: Dimens.space4),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: MainConfig.appColors.lightGreyColor,
                              width: Dimens.borderWidth05,
                            ),
                            borderRadius: const BorderRadius.all(
                                Radius.circular(Dimens.space8)),
                            color: MainConfig.appColors.backgroundWhite,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: Dimens.size8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      width: Dimens.size2,
                                      height: Dimens.space20,
                                      decoration: BoxDecoration(
                                        color: model.transactionType ==
                                                TransactionType.gained
                                            ? MainConfig.appColors.greenColor
                                            : MainConfig.appColors.redColor,
                                        borderRadius: BorderRadius.only(
                                          topRight: context.isEnglishLanguage? Dimens.radius8.circularRadius:Radius.zero,
                                          // Top-right corner radius
                                          bottomRight: context.isEnglishLanguage? Dimens.radius8.circularRadius:Radius.zero,

                                          bottomLeft: context.isEnglishLanguage?Radius.zero: Dimens.radius8.circularRadius,
                                          topLeft: context.isEnglishLanguage?Radius.zero: Dimens.radius8.circularRadius



                                        ),
                                      ),
                                    ),
                                    Dimens.size6.widthBox,
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          createSpannableText(
                                              content: model.description,
                                              context: context,
                                              defaultTextStyle: context
                                                  .textTheme.headlineMedium
                                                  ?.copyWith(
                                                fontWeight: FontWeight.w600,
                                                fontSize: Dimens.fontSize14,
                                                color: MainConfig
                                                    .appColors.textBlackColor,
                                                height: Dimens.lineHeight18
                                                    .toLineHeight(
                                                        Dimens.fontSize14),
                                              ),
                                              boldTextStyle: context
                                                  .textTheme.headlineMedium
                                                  ?.copyWith(
                                                fontWeight: FontWeight.w600,
                                                fontSize: Dimens.fontSize14,
                                                color: model.transactionType ==
                                                        TransactionType.gained
                                                    ? MainConfig
                                                        .appColors.greenColor
                                                    : MainConfig
                                                        .appColors.redColor,
                                                height: Dimens.lineHeight18
                                                    .toLineHeight(
                                                        Dimens.fontSize14),
                                              ),
                                              boldPhrases: <String>[
                                                model.points,
                                                model.pointsTitle
                                              ]),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              CustomTextLabelWidget(
                                                textAlign: TextAlign.start,
                                                label: model.transactionId,
                                                style: context
                                                    .textTheme.headlineMedium
                                                    ?.copyWith(
                                                  fontWeight: FontWeight.w400,
                                                  color: MainConfig
                                                      .appColors.creyColor,
                                                  fontSize: Dimens.fontSize12,
                                                  height: Dimens.lineHeight14
                                                      .toLineHeight(
                                                          Dimens.fontSize12),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal:
                                                            Dimens.space8),
                                                child: CustomTextLabelWidget(
                                                  textDirection: TextDirection.ltr,
                                                  textAlign: TextAlign.start,
                                                  label: model.dateTime,
                                                  style: context
                                                      .textTheme.headlineMedium
                                                      ?.copyWith(
                                                    fontWeight: FontWeight.w400,
                                                    color: MainConfig
                                                        .appColors.creyColor,
                                                    fontSize: Dimens.fontSize12,
                                                    height: Dimens.lineHeight14
                                                        .toLineHeight(
                                                            Dimens.fontSize12),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: Dimens.space8,
                                      right: Dimens.space8,
                                      left: Dimens.space8),
                                  child: CustomTextLabelWidget(
                                    textAlign: TextAlign.start,
                                    label: model.location,
                                    style: context.textTheme.headlineMedium
                                        ?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: Dimens.fontSize12,
                                      color: MainConfig.appColors.creyColor,
                                      height: Dimens.lineHeight14
                                          .toLineHeight(Dimens.fontSize12),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: AppConstant.walletTransactions.length) :const WalletTransactionListShimmer()
              ],
            ),
          ),
        );
  },
),
      ],
    );
  }
}
