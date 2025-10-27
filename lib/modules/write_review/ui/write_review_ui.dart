import '../../../utils/exports.dart';
///WriteReviewUi
class WriteReviewUi extends StatelessWidget {
  ///WriteReviewUi constructor
  const WriteReviewUi({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<WriteReviewCubit, WriteReviewState>(
      listener: (BuildContext context, WriteReviewState state) {
        // Handle success case for both rateProducts and rateOrder
        if (state.status == BaseStateStatus.success && (state.msg?.isNotEmpty ?? false)) {
          final String successMessage = state.isFromRateOrder 
              ? (state.msg ?? context.appString.productRatedSuccessfullyKey) // You might want to add a specific order success message
              : (state.msg ?? context.appString.productRatedSuccessfullyKey);
          displaySnackBar(successMessage, context);
          // Navigate back after successful rating
          if (context.mounted) {
            context.router.back();
          }
        }
        
        // Handle failure case for both rateProducts and rateOrder
        if (state.status == BaseStateStatus.failure && (state.msg?.isNotEmpty ?? false)) {
          final String failureMessage = state.isFromRateOrder 
              ? (state.msg ?? context.appString.failedToRateProductKey) // You might want to add a specific order failure message
              : (state.msg ?? context.appString.failedToRateProductKey);
          displaySnackBar(failureMessage, context);
        }
      },
      child: Scaffold(
        body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BlocBuilder<WriteReviewCubit, WriteReviewState>(
            buildWhen: (WriteReviewState previous, WriteReviewState current) =>
                current.isFromRateOrder != previous.isFromRateOrder,
            builder: (BuildContext context, WriteReviewState state) {
              return ProductDetailsAppBar(
                titleText: state.isFromRateOrder ? context.appString.rateOrderKey :context.appString.writeAReviewKey,
                isLastWidgetDisplay: false,
                titleColors: MainConfig.appColors.textBlackColor,
                prefixIcon: Assets.svgs.icBack.svg(),
              );
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  BlocBuilder<WriteReviewCubit, WriteReviewState>(
                    buildWhen: (WriteReviewState previous, WriteReviewState current) =>
                        current.saveReviewResponse != previous.saveReviewResponse ||
                        current.isFromRateOrder != previous.isFromRateOrder ||
                        current.orderId != previous.orderId ||
                        current.product != previous.product ,
                    builder: (BuildContext context, WriteReviewState state) {
                      return WriteReviewPageWidget(
                        isFromRateOrder: state.isFromRateOrder,
                        orderId: state.orderId,
                        product: state.product,
                      );
                    },
                  )
                ],
              ),
            ),
          ),
          BlocBuilder<WriteReviewCubit, WriteReviewState>(
            buildWhen: (WriteReviewState previous, WriteReviewState current) =>
                current.rating != previous.rating ||
                current.writeReviewTextController.text != previous.writeReviewTextController.text ||
                current.status != previous.status,
            builder: (BuildContext context, WriteReviewState state) {
              return StickBottomButtonView(
                isOnlyOneButtonShow: true,
                singleTitle: context.appString.submitButtonKey,
                isOnlyOneButtonEnabled: state.rating > 0,
                singleButtonClick: () async {
                  // Validate input
                  if (state.rating == 0) {
                    displaySnackBar(context.appString.pleaseSelectRatingKey, context);
                    return;
                  }
                  
                  if (state.writeReviewTextController.text.isEmpty ||
                      state.writeReviewTextController.text.length < AppConstant.commentLength) {
                    displaySnackBar(context.appString.pleaseEnterReviewDetailsKey, context);
                    return;
                  }

                  if (state.isFromRateOrder) {
                    // Validate orderId for rate order flow
                    if (state.orderId == null) {
                      displaySnackBar(context.appString.productNotFoundKey, context);
                      return;
                    }

                    // Call rateOrder with proper parameters
                    await context.read<WriteReviewCubit>().rateOrder(
                      orderId: state.orderId!,
                      overview: state.writeReviewTextController.text.trim(),
                      rating: state.rating,
                    );
                  } else {
                    // Check if we have productId (productSKU) for product rating flow
                    if (state.product == null) {
                      displaySnackBar(context.appString.productNotFoundKey, context);
                      return;
                    }

                    // Call rateProducts with proper parameters
                    await context.read<WriteReviewCubit>().rateProducts(
                      productSKU: state.product?.sku ?? '',
                      overview: state.writeReviewTextController.text.trim(),
                      rating: state.rating,
                    );
                  }
                },
              );
            },
          )
        ],
      ),
      ),
    );
  }
}
