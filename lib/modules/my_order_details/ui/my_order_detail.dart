import '../../../utils/exports.dart';
/// Widget that displays detailed information about an order.
class MyOrderDetail extends StatelessWidget {
  /// Creates a my order detail widget.
  const MyOrderDetail({super.key, this.device = ScreenType.mobile});

  /// The screen type for responsive design.
  final ScreenType device;

  @override
  Widget build(BuildContext context) {
    switch (device) {
      case ScreenType.tablet:
        break;
      default:
        break;
    }
    return
      BlocListener<MyOrderDetailCubit, MyOrderDetailState>(
        listener: (BuildContext context, MyOrderDetailState myOrderDetailState) {
          // Handle success message
          // if (myOrderDetailState.successMsg.isNotEmpty) {
          //   displaySnackBar(myOrderDetailState.successMsg, context);
          // }
          
          // Handle error message
          if (myOrderDetailState.msg?.isNotEmpty ?? false) {
            displaySnackBar(myOrderDetailState.msg!, context);
          }
          
          // Handle navigation
          if (myOrderDetailState.redirectRoute != null) {
            if (myOrderDetailState.redirectRoute is CartListRoute) {
              // For reorder, navigate to cart
              unawaited(context.router.push(myOrderDetailState.redirectRoute!));
            } else {
              // For other routes like cancel order, replace all
              unawaited(context.router.replaceAll(<PageRouteInfo>[myOrderDetailState.redirectRoute!]));
            }
          }
        },
        child:
        BlocBuilder<MyOrderDetailCubit, MyOrderDetailState>(
            buildWhen: (MyOrderDetailState previous, MyOrderDetailState current) {
              // Only rebuild when form data, validation errors, or UI state changes
              return previous.status != current.status ||
                  previous.successMsg != current.successMsg ||
                  previous.redirectRoute != current.redirectRoute ||
                  previous.msg != current.msg;
            },
            builder: (BuildContext context, MyOrderDetailState state) {
             final MyOrderDetailResponseModel? orderDetail = state.response;
             final List<MyOrderDetailResponseModel>? orderDetailsList = state.orderDetailsList;
             final List<MyOrderDetailModel> details = buildOrderDetails(context, orderDetail);

              return
                Scaffold(
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ProductDetailsAppBar(
                        titleText: orderDetail?.orderId.toString() ?? '',
                        isLastWidgetDisplay: false,
                        titleColors: MainConfig.appColors.textBlackColor,
                        prefixIcon: Assets.svgs.icBack.svg(),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(
                                  Dimens.space16,
                                ),
                                child: Container(
                                  decoration: BoxDecorationExtension
                                      .customDecoration(
                                    color: MainConfig.appColors.backgroundWhite,
                                    borderRadius: Dimens.radius8.borderRadius,
                                    border: Border.all(color: MainConfig.appColors.lightGreyColor, width: Dimens.borderWidth05),
                                  ),
                                  padding: const EdgeInsets.all(Dimens.space8),
                                  child: Column(
                                    children: <Widget>[
                                      MyOrderListHeaderView(
                                        svgPath: (orderDetail?.orderType
                                                        ?.toLowerCase()
                                                        .trim() ==
                                                    AppConstant.pickup1)
                                            ? Assets.svgs.icPickupOrder.path
                                            : Assets.svgs.icOrderDelivery.path,
                                        deliveryLabel: context.appString.deliveryKey,
                                        orderDate: orderDetail?.orderDate ?? '',
                                        position: 0,
                                        isPastOrder: true,
                                        orderStatus: orderDetail?.mashkorStatus?.toLowerCase() ?? '',
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: Dimens.space8),
                                        child: DottedLine(
                                          height: Dimens.sizePoint5,
                                          color: MainConfig.appColors
                                              .lightGreyColor,
                                        ),
                                      ),
                                      MyOrderMiddleView(
                                        orderId: orderDetail?.orderId.toString() ?? '',
                                        thumbUrl: (orderDetail?.products?.isNotEmpty ?? false)
                                            ? orderDetail!.products!.first.thumbNail
                                            : null,
                                        orderFinalAmount: orderDetail?.orderFinalAmount.toString(),
                                        noOfItems: orderDetail?.noOfItems.toString(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: Dimens.space16,
                                    right: Dimens.space16,
                                    bottom: Dimens.space16),
                                child: CustomTextLabelWidget(
                                  maxLines: Dimens.maxLines01,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                  label: context.appString.listOfItemsKey,
                                  style: context.textTheme.headlineMedium
                                      ?.copyWith(
                                    height: Dimens.lineHeight12
                                        .toLineHeight(Dimens.fontSize18),
                                    fontSize: Dimens.fontSize18,
                                    color: MainConfig.appColors.textBlackColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              OrderDetailsCartList(
                                orderId: orderDetail?.orderId,
                                products: (orderDetailsList?.isNotEmpty ?? false) 
                                    ? orderDetailsList?.first.products 
                                    : null,
                                isLoading: state.status == BaseStateStatus.loading,
                              ),
                              if (orderDetailsList?.first.rewardProducts?.isNotEmpty ?? false)
                                Padding(
                                padding: Dimens.space16.padding,
                                child: CustomRichTextLabel(
                                  maxLines: Dimens.maxLines01,
                                  primaryLabel: context.appString.freeKey.toUpperCase(),
                                  // secondaryLabel: context.appString.freeKey
                                  //     .toUpperCase(),
                                  primaryStyle: context.textTheme.headlineMedium
                                      ?.copyWith(
                                    height: Dimens.lineHeight22
                                        .toLineHeight(Dimens.fontSize18),
                                    fontSize: Dimens.fontSize18,
                                    color: MainConfig.appColors.redColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  secondaryStyle: context.textTheme
                                      .headlineMedium?.copyWith(
                                    height: Dimens.lineHeight12
                                        .toLineHeight(Dimens.fontSize18),
                                    fontSize: Dimens.fontSize18,
                                    color: MainConfig.appColors.redColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              OrderDetailsCartList(
                                orderId: orderDetail?.orderId,
                                isReward : true,
                                products: (orderDetailsList?.isNotEmpty ?? false) 
                                    ? orderDetailsList?.first.rewardProducts
                                    : null,
                                isLoading: state.status == BaseStateStatus.loading,
                              ),
                              Dimens.space16.heightBox,
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: Dimens.space16),
                                child: CustomButtonWidget(
                                  isPrimaryButton: false,
                                  height: Dimens.size44,
                                  borderWidth: Dimens.borderWidth05,
                                  borderColor: MainConfig.appColors.mainColor,
                                  title: context.appString.rateOrderKey,
                                  hasBorder: true,
                                  backgroundColor: AppColors.whiteBlueColor,
                                  titleTextStyle: context
                                      .textTheme.headlineMedium
                                      ?.copyWith(
                                    fontSize: Dimens.fontSize16,
                                    fontWeight: FontWeight.w700,
                                    height: Dimens.lineHeight24
                                        .toLineHeight(Dimens.fontSize16),
                                    color: MainConfig.appColors.mainColor,
                                  ),
                                  onTap: () async {
                                    await context.router.push(WriteReviewRoute(
                                        isFromRateOrder: true,
                                        orderId: orderDetail?.orderId,
                                    ));
                                  },
                                ),
                              ),
                              Dimens.space16.heightBox,
                              if (orderDetailsList != null && 
                                  orderDetailsList.isNotEmpty &&
                                  orderDetailsList.first.orderRatings != null &&
                                  (orderDetailsList.first.orderRatings?.stars != null || 
                                   (orderDetailsList.first.orderRatings?.ratingDetail != null && 
                                    (orderDetailsList.first.orderRatings?.ratingDetail?.isNotEmpty ?? false))))
                                Padding(
                                  padding: Dimens.space16.padding,
                                  child: OrderRatingWidget(
                                    orderRating: orderDetailsList.first.orderRatings?.stars,
                                    orderReview: orderDetailsList.first.orderRatings?.ratingDetail,
                                  ),
                                ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: Dimens.space16),
                                child: OrderDetailSummaryView(
                                  isFromCartScreen: false,
                                  onItemTap: () {},
                                  totalDiscountString: AppConstant
                                      .totalDiscountString,
                                  orderSummary: (orderDetailsList?.isNotEmpty ?? false)
                                      ? orderDetailsList?.first.orderSummary
                                      : null,
                                  device: device,
                                ),
                              ),
                              Dimens.size16.heightBox,
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: Dimens.space16),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: MainConfig.appColors
                                          .lightGreyColor,
                                      width: Dimens.borderWidth05,
                                    ),
                                    borderRadius: Dimens.space8.borderRadius,
                                    color: MainConfig.appColors.backgroundWhite,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: Dimens.space8,
                                            right: Dimens.space8,
                                            top: Dimens.space8),
                                        child: CustomTextLabelWidget(
                                          label: orderDetail?.storeObject?.storeName ?? '',
                                          style: context.textTheme
                                              .headlineMedium
                                              ?.copyWith(
                                            fontWeight: FontWeight.w700,
                                            color: MainConfig.appColors
                                                .textBlackColor,
                                            height: Dimens.lineHeight24
                                                .toLineHeight(Dimens.size16),
                                            fontSize: Dimens.fontSize16,
                                          ),
                                        ),
                                      ),
                                      Dimens.space11.heightBox,
                                      CustomListView(
                                          scrollPhysics:
                                          const NeverScrollableScrollPhysics(),
                                          isPadding: true,
                                          itemBuilder: (BuildContext p0,
                                              int index) {
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                  top: index == 0
                                                      ? Dimens.space0
                                                      : Dimens.space12),
                                              child:
                                              AddressViewDetails(
                                                isLastItem: index == details.length - 1,
                                                myOrderDetailModel: details[index],
                                              ),
                                            );
                                          },
                                          itemCount: details.length),
                                      Dimens.size8.heightBox,
                                    ],
                                  ),
                                ),
                              ),
                              Dimens.size30.heightBox,
                            ],
                          ),
                        ),
                      ),
                      // Only show buttons when data is successfully loaded
                      if (state.status == BaseStateStatus.success && orderDetail != null)
                        MyOrderBottomButtonView(
                          myOrderDetailResponseModel: orderDetail,
                          orderStatus: orderDetail.mashkorStatus?.toLowerCase(),
                          onReorder: () async {
                            await context.read<MyOrderDetailCubit>().callReOrderApi(orderDetail.orderId.toString());
                          },
                        )
                    ],
                  ),
                );
            },
        )

    );
  }
  /// Builds a list of order detail models for display.
  List<MyOrderDetailModel> buildOrderDetails(BuildContext context, MyOrderDetailResponseModel? orderDetail) {
    return <MyOrderDetailModel>[
      MyOrderDetailModel(
        title: context.appString.deliveryAddressTitleKey,
        description: orderDetail?.userAddress?.isNotEmpty ?? false
            ? "${orderDetail!.userAddress!.first.area}, ${orderDetail.userAddress!.first.blockNo}, ${orderDetail.userAddress!.first.street}, ${orderDetail.userAddress!.first.buildingVilla}"
            : context.appString.noAddressAvailableKey,
      ),
      MyOrderDetailModel(
        title: context.appString.paymentMethodTitleKey,
        description: (orderDetail?.paymentMethod?.isNotEmpty ?? false)
            ? orderDetail!.paymentMethod!
            : context.appString.notAvailableKey,
      ),
      MyOrderDetailModel(
        title: context.appString.pointsEarnedKey,
        description: (orderDetail?.pointEarned?.isNotEmpty ?? false)
            ? orderDetail!.pointEarned!
            : context.appString.zeroPointsKey,
      ),
    ];
  }

}
