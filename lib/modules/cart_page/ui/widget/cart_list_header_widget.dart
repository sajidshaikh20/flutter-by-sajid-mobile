import '../../../../utils/exports.dart';

///CartListHeaderWidget
class CartListHeaderWidget extends StatelessWidget {

  ///CartListHeaderWidget
  const CartListHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartPageCubit, CartPageState>(
      builder: (BuildContext context, CartPageState state) {
        return Container(
          color: MainConfig.appColors.iceBlueColor,
          width: double.infinity,
          padding: const EdgeInsets.only(
              right: Dimens.space16,
              left: Dimens.space16,
              top: Dimens.space1,
              bottom: Dimens.space10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // required when we add api
              //
              BlocBuilder<HomeCubit, HomeState>(
                builder: (BuildContext context, HomeState homeState) {
                  final bool isPickup = homeState.deliveryType == 'pickup';
                  return CustomRichTextLabel(
                    primaryLabel: isPickup
                        ? context.appString.pickupKey
                        : context.appString.deliveryToHomeKey,
                    primaryStyle: context.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: MainConfig.appColors.mainColor,
                      fontSize: Dimens.fontSize16,
                      height:
                          Dimens.lineHeight24.toLineHeight(Dimens.fontSize16),
                    ),
                    secondaryStyle: context.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: MainConfig.appColors.backgroundBlackColor,
                      fontSize: Dimens.fontSize16,
                      height: Dimens.lineHeight24.toLineHeight(Dimens.fontSize16),
                    ),
                    secondaryLabel: getLocalizedAddressType(
                        context, homeState.selectedAddress?.addressType),
                  );
                },
              ),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (BuildContext context, HomeState homeState) {
                  return CustomTextLabelWidget(
                    textDirection: TextDirection.ltr,
                    overflow: TextOverflow.ellipsis,
                    maxLines: Dimens.maxLines01,
                    label: homeState.selectedAddress?.details ?? "",
                    style: context.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: MainConfig.appColors.textBlackColor,
                        fontSize: Dimens.fontSize14,
                        height: Dimens.lineHeight18
                            .toLineHeight(Dimens.fontSize14)),
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  BlocBuilder<HomeCubit, HomeState>(
                    builder: (BuildContext context, HomeState homeState) {
                      return CustomRichTextLabel(
                          primaryLabel: context.appString.fromKey,
                          secondaryLabel:
                              " ${(homeState.selectedAddress?.title?.isNotEmpty ?? false)
                                  ? homeState.selectedAddress!.title
                                  : getIt<AddressService>().addressTitle}",
                              // " ${homeState.selectedAddress?.title}",
                          secondaryStyle: context.textTheme.headlineMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: Dimens.fontSize12,
                                  height: Dimens.lineHeight16
                                      .toLineHeight(Dimens.fontSize12)),
                          primaryStyle: context.textTheme.headlineMedium
                              ?.copyWith(
                                  color: MainConfig.appColors.mainColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: Dimens.fontSize12,
                                  height: Dimens.lineHeight16
                                      .toLineHeight(Dimens.fontSize12)));
                    },
                  ),
                  GestureDetector(
                    onTap: () async {
                      final Object? result = await context.router.push(SelectAddressRoute());
                      if (result is bool && result == true) {
                        if (context.mounted) {
                          await context.read<HomeCubit>().loadSavedAddress();
                          if (context.mounted) {
                            context.read<HomeCubit>().initializeSegmentIndex();
                          }
                        }
                      }
                    },
                    child: CustomTextLabelWidget(
                    label: context.appString.changeKey,
                    style: context.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: MainConfig.appColors.mainColor,
                        decoration: TextDecoration.underline,
                        fontSize: Dimens.fontSize12,
                        height: Dimens.lineHeight16
                            .toLineHeight(Dimens.fontSize12)),
                  ),),
                ],
              ),
              Dimens.size7.heightBox,
              BlocBuilder<HomeCubit, HomeState>(
                builder: (BuildContext context, HomeState homeState) {
                  final bool isPickup = homeState.deliveryType == 'pickup';
                  if (!isPickup) {
                    return const SizedBox.shrink();
                  }
                  return GestureDetector(
                    onTap: () async {
                      await showCustomBottomSheetView(
                          context: context,
                          child: BlocProvider<CartPageCubit>.value(
                            value: context.read<CartPageCubit>(),
                            child: const SelectPickupTime(),
                          ),
                          title: context.appString.selectPickupTimeKey,
                          isCloseIconVisible: true,
                          titleStyle: context.textTheme.displayMedium?.copyWith(
                            color: MainConfig.appColors.textBlackColor,
                            fontSize: Dimens.fontSize18,
                            fontWeight: FontWeight.w700,
                            height: Dimens.lineHeight22
                                .toLineHeight(Dimens.fontSize18),
                          ));
                    },
                    child: Row(
                      children: <Widget>[
                        Assets.svgs.icTimeFast.svg(),
                        Dimens.size9.widthBox,
                        CustomTextLabelWidget(
                          textDirection: TextDirection.ltr,
                          label: state.selectedTimeSlot != null &&
                                  state.availableTimeSlots != null &&
                                  state.selectedTimeSlot! <
                                      state.availableTimeSlots!.length
                              ? (state
                                      .availableTimeSlots![
                                          state.selectedTimeSlot!]
                                      .time ??
                                  '')
                              : context.appString.selectPickupTimeKey,
                          style: context.textTheme.headlineMedium?.copyWith(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w700,
                              color: MainConfig.appColors.mainColor,
                              fontSize: Dimens.fontSize12,
                              height: Dimens.lineHeight14
                                  .toLineHeight(Dimens.fontSize12)),
                        ),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        );
      },
    );
  }
}
