import '../../../../utils/exports.dart';

/// [MyOrderBottomButtonView] shows context-aware actions for an order
/// based on its current status. It is intended for use on the order
/// detail screen where [myOrderDetailResponseModel] is available.
class MyOrderBottomButtonView extends StatelessWidget {

  /// The detailed response data for the order, typically containing items, pricing, and address info.
  final MyOrderDetailResponseModel? myOrderDetailResponseModel;

  /// The current status of the order (e.g., "Pending", "Delivered", "Cancelled").
  final String? orderStatus;

  /// Callback triggered when the user taps the "Reorder" button.
  final VoidCallback? onReorder;

  ///MyOrderBottomButtonView
  const MyOrderBottomButtonView({
    super.key,
    this.myOrderDetailResponseModel,
    this.orderStatus,
    this.onReorder,
  });

  @override
  Widget build(BuildContext context) {
    EdgeInsets commonContainerPadding = const EdgeInsets.symmetric(
      vertical: Dimens.space6,
      horizontal: Dimens.space16,
    );

    final List<Widget> buttons = _buildButtons(context);

    return Stack(
      children: <Widget>[
        Container(
          height: Dimens.size88,
          padding: commonContainerPadding,
          color: AppColors.whiteColor,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: buttons,
          ),
        ),

        // 🔹 Subtle top-only shadow (same as Figma spec)
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 2, // smaller height = lighter blur
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Color.fromRGBO(0, 0, 0, 0.1), // 10% opacity black
                  Color.fromRGBO(0, 0, 0, 0.0),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildButtons(BuildContext context) {
    final List<Widget> buttons = <Widget>[];

    // Helper to build a primary action button
    Widget buildBtn(String title, VoidCallback onTap, {bool enabled = true}) {
      return Expanded(
        child: CustomGradientButtonWidget(
          isButtonEnabled: enabled,
          titleTextStyle: context.textTheme.headlineMedium?.copyWith(
            color: AppColors.whiteColor,
            fontWeight: FontWeight.w700,
            height: Dimens.lineHeight24.toLineHeight(Dimens.fontSize16),
            fontSize: Dimens.fontSize16,
          ),
          title: title,
          onTap: onTap,
        ),
      );
    }

    void addGap() {
      if (buttons.isNotEmpty) {
        buttons.add(Dimens.space7.widthBox);
      }
    }

    if (orderStatus == null || orderStatus!.isEmpty) {
      buttons.add(buildBtn(
        context.appString.reOrderKey,
        onReorder ?? () {},
      ));
      return buttons;
    }

    final String lowerStatus = orderStatus!.toLowerCase().trim();

    OrderStatusNew? normalizedStatus;
    try {
      normalizedStatus = OrderStatusNew.values.firstWhere(
            (OrderStatusNew e) => e.name.toLowerCase() == lowerStatus,
      );
    } on StateError {
      if (lowerStatus == 'cancelled') {
        normalizedStatus = OrderStatusNew.canceled;
      } else if (lowerStatus == AppConstant.pickupStarted.toLowerCase()) {
        normalizedStatus = OrderStatusNew.collected;
      }
    }

    if (normalizedStatus == OrderStatusNew.delivered) {
      buttons.add(buildBtn(
        context.appString.trackOrderKey,
            () async {
          await context.router.push(
            TrackOrderRoute(orderDetailsResponse: myOrderDetailResponseModel),
          );
        },
      ));
      addGap();
      buttons.add(buildBtn(
        context.appString.reOrderKey,
        onReorder ?? () {},
      ));
      return buttons;
    }

    if (normalizedStatus == OrderStatusNew.canceled ||
        normalizedStatus == OrderStatusNew.collected) {
      buttons.add(buildBtn(
        context.appString.reOrderKey,
        onReorder ?? () {},
      ));
      return buttons;
    }

    buttons.add(buildBtn(
      context.appString.trackOrderKey,
          () async {
        await context.router.push(
          TrackOrderRoute(orderDetailsResponse: myOrderDetailResponseModel),
        );
      },
    ));
    addGap();
    buttons.add(buildBtn(
      context.appString.cancelOrderkey,
          () async {
        if (myOrderDetailResponseModel?.orderId != null) {
          showCustomDialog(
            context.appString.cancelOrderConformationKey,
            title: context.appString.cancelOrderKey,
            okBtnTitle: context.appString.yesKey,
            onOkClicked: () async {
              if (myOrderDetailResponseModel?.orderId != null) {
                await context.read<MyOrderDetailCubit>().callCancelOrderApi();
              }
            },
            cancelBtnTitle: context.appString.cancelKey,
            onCancelClicked: () => goBack(context),
          );
        }
      },
    ));

    return buttons;
  }
}
