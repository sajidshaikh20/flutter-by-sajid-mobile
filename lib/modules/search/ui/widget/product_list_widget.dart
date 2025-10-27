import '../../../../utils/exports.dart';

/// A widget for displaying a list of products.
class ProductListWidget extends StatelessWidget {
  /// Creates a [ProductListWidget].
  ///
  /// The [device] parameter determines the screen type for which the widget is being built.
  const ProductListWidget({super.key,this.device=ScreenType.mobile,});

  /// The type of screen for which the widget is being built.
  final ScreenType device;
  @override
  Widget build(BuildContext context) {


    return BlocBuilder<SearchCubit, SearchState>(
      buildWhen: (SearchState previous, SearchState current) =>
          previous.productListingResponse != current.productListingResponse ||
          previous.status != current.status,
      builder: (BuildContext context, SearchState state) {
        // Show loading state
        if (state.status == BaseStateStatus.loading) {
          return const SizedBox(
            height: 500, // Give it some height to center properly
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // Show full-screen centered empty state when API succeeds with empty list
        final int productCount =
            state.productListingResponse?.data?.length ?? Dimens.digit0;
        if (state.status == BaseStateStatus.success && productCount == 0) {
          return SizedBox(
            height: 500,
            child: Center(
              child: CustomNoDataWidget(
                message: context.appString.noSearchResultFoundKey,
                showImage: false,
                showButton: false,
                backgroundColor: Colors.transparent,
              ),
            ),
          );
        }
        return ColoredBox(
          color: AppColors.whiteColor,
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification notification) {
              // Ensure keyboard hides when list area is scrolled
              FocusManager.instance.primaryFocus?.unfocus();
              return false;
            },
            child: ListView.builder(
            padding: EdgeInsets.zero,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            // Show all returned products (no arbitrary cap)
            itemCount:
                state.productListingResponse?.data?.length ?? Dimens.digit0,
            itemBuilder: (BuildContext context, int index) {
              final ProductListingResponse? product =
              state.productListingResponse?.data?[index];
              final double? price = product?.price?.toDouble();
              final double? finalPrice = product?.finalPrice?.toDouble();
              final String percentOff = (product?.percentOff ?? '').toString().trim();

              final bool hasDiscount = finalPrice != null &&
                  price != null &&
                  finalPrice > 0 &&
                  finalPrice != price;

              return Padding(
                padding: const EdgeInsets.only(left: Dimens.space16),
                child: Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () async {
                        // Hide keyboard when tapping on list items
                        FocusScope.of(context).unfocus();
                        await context.router.push(ProductDetailsRoute(
                            entityId: product?.entityId ?? Dimens.digit0,
                            index: index));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: Dimens.space12),
                        child: Row(
                          children: <Widget>[
                            CustomNetworkImageWidget(
                              imageUrl: product?.thumbNail ??
                                  product?.imageLarge ??
                                  "",
                              width: Dimens.size64,
                              height: Dimens.size64,
                              fit: BoxFit.contain,
                              placeHolderImage: CommonLottieAnimation(
                                  assetPath: Assets.json.waveAnim),
                              isShowPlaceHolder: true,
                            ),

                            const SizedBox(
                              width: Dimens.size12,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  TextWithMinLines(
                                    product?.name ?? '',
                                    minLines: 2,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: context.textTheme.bodyMedium?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.blackColor,
                                        fontSize: Dimens.fontSize14,
                                        height: Dimens.lineHeight18.toLineHeight(
                                            Dimens.fontSize14)),
                                  ),
                                  const SizedBox(
                                    height: Dimens.size10,
                                  ),
                                  Row(children: <Widget>[
                                    // Current price
                                    CustomTextLabelWidget(
                                      label:
                                      '${price?.toStringAsFixed(2) ?? '0'} ${getIt<LanguageService>().defaultCurrency}',
                                      style: context.textTheme.bodyMedium
                                          ?.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.blackColor,
                                        fontSize: Dimens.fontSize14,
                                        height: Dimens.lineHeight16
                                            .toLineHeight(Dimens.fontSize14),
                                      ),
                                    ),
                                    if (hasDiscount) ...<Widget>[
                                      const SizedBox(width: Dimens.size4),
                                      // Original Price
                                      CustomTextLabelWidget(
                                        label:
                                        '${finalPrice.toStringAsFixed(1)} ${getIt<LanguageService>().defaultCurrency}',
                                        style: context.textTheme.bodyMedium
                                            ?.copyWith(
                                          decoration:
                                          TextDecoration.lineThrough,
                                          fontWeight: FontWeight.w600,
                                          color:
                                          MainConfig.appColors.creyColor,
                                          fontSize: Dimens.fontSize14,
                                          height: Dimens.lineHeight18
                                              .toLineHeight(
                                              Dimens.fontSize14),
                                        ),
                                      ),
                                      const SizedBox(width: Dimens.size4),
                                      // Discount %
                                      if (percentOff.isNotEmpty &&
                                          percentOff != '0')
                                        CustomTextLabelWidget(
                                          textDirection: TextDirection.ltr,
                                          label: '$percentOff % ${context.appString.oFFKey} ',
                                          style: context.textTheme.bodyMedium
                                              ?.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: MainConfig
                                                .appColors.greenColor,
                                            fontSize: Dimens.fontSize12,
                                            height: Dimens.lineHeight14
                                                .toLineHeight(
                                                Dimens.fontSize12),
                                          ),
                                        ),
                                    ],
                                  ]
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: Dimens.space1,
                      color: MainConfig.appColors.backgroundGrey,
                    ),
                  ],
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
