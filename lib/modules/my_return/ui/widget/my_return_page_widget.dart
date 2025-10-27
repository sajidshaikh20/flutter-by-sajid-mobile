import '../../../../utils/exports.dart';
import 'my_return_order_details_widget_item.dart';

/// Widget to display the return orders page with appropriate
/// layout and actions.
class MyReturnPageWidget extends StatelessWidget {
  /// Constructor to initialize the widget with device type.
  const MyReturnPageWidget({super.key, this.device = ScreenType.mobile});

  /// Device type for responsive design.
  final ScreenType device;

  @override
  Widget build(BuildContext context) {
    /// Define default sizes for animation and text.
    double lottieAnimationSize = Dimens.size100;
    double noDataTextSize = Dimens.fontSize20;

    /// Handle responsive design based on device type.
    switch (device) {
      case ScreenType.tablet:
        lottieAnimationSize = Dimens.size130; // Larger size for tablet
        noDataTextSize = Dimens.fontSize24;   // Larger text size for tablet

      case ScreenType.mobile:
      case ScreenType.desktop:
    }

    return NoInternetWidget(
      device: device, // Pass device type for responsive layout
      onTryAgain: () async {
        await context.read<MyReturnCubit>().getMyReturnList(); // Retry loading return orders
      },
      childWidget: BlocBuilder<MyReturnCubit, MyReturnState>(
        buildWhen: (MyReturnState previous, MyReturnState current) =>
        previous.myReturnOrderList != current.myReturnOrderList, // Check for return order list changes
        builder: (BuildContext context, MyReturnState state) {
          // Check if the status is success
          if (state.status == BaseStateStatus.success) {
            MyReturnModel? returnOrderList = state.myReturnOrderList;

            // If there are return orders, show the list
            return (returnOrderList?.orderlisting?.isNotEmpty ?? false)
                ? Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: returnOrderList?.orderlisting?.length,
                    itemBuilder: (BuildContext context, int index) {
                      ReturnOrderItem? data =
                      returnOrderList?.orderlisting?[index];
                      return Padding(
                        padding: const EdgeInsets.only(
                          left: Dimens.space16,
                          top: Dimens.space14,
                          right: Dimens.space16,
                        ),
                        child: MyReturnOrderDetailsWidgetItem(
                          returnOrderItem: data,
                          // Display order item details
                          isPaymentSuccess: index == 0,
                          // Mark first item as payment success
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: Dimens.space10,
                    right: Dimens.space10,
                    bottom: Dimens.space10,
                  ),
                  child: CustomButtonWidget(
                    onTap: () {
                      context.read<MyReturnCubit>().changeVisibility();
                      // Toggle visibility action
                    },
                    title: AppConstant.changeVisibility, // Button title
                  ),
                ),
              ],
            )
                : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Animation and text displayed when there are no return orders
                  CommonLottieAnimation(
                    repeat: false,
                    height: lottieAnimationSize,
                    width: lottieAnimationSize,
                    assetPath: Assets.json.emptyOrderList,
                  ),
                  CustomTextLabelWidget(
                    label: MainConfig.dynamicString(
                      JsonServiceString.keyNoReturnOrders, // No return orders text
                    ),
                    style: context.textTheme.headlineMedium?.copyWith(
                      color: MainConfig.appColors.textDarkBlackColor,
                      fontWeight: FontWeight.w600,
                      fontSize: noDataTextSize,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox(); // Placeholder when status is not success
          }
        },
      ),
    );
  }
}
