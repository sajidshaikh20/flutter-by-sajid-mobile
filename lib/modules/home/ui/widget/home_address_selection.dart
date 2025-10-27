import '../../../../utils/exports.dart';

/// A widget to display the home address selection on the home screen.
///
/// This widget shows a user's current home address and provides an indicator
/// to select or change it.
class HomeAddressSelection extends StatelessWidget {
  ///HomeAddressSelection constructor
  const HomeAddressSelection({super.key});

  /// Builds the UI for the home address selection widget.
  /// It consists of a background, an icon, text labels and a down arrow.
  @override
  Widget build(BuildContext context) {
    unawaited(context.read<HomeCubit>().loadSavedAddress());
    return BlocListener<HomeCubit, HomeState>(
        listener: (BuildContext context, HomeState state) {
      // Reload saved address when address list is updated (e.g., during refresh)
      if (state.apiCallForAddress == BaseStateStatus.success &&
          state.addressList.isNotEmpty) {
        unawaited(context.read<HomeCubit>().loadSavedAddress());
      }
    }, child: BlocBuilder<HomeCubit, HomeState>(
      builder: (BuildContext context, HomeState productHomeState) {
        bool isPickup = productHomeState.deliveryType == 'pickup';
        return GestureDetector(
            onTap: () async {
              final Object? result = await context.router.push(SelectAddressRoute());
              if (result is bool && result == true) {
                if (context.mounted) {
                  // Reload saved address after address selection
                  await context.read<HomeCubit>().loadSavedAddress();
                  if (context.mounted) {
                    context.read<HomeCubit>().initializeSegmentIndex();
                    context.read<HomeCubit>().refreshHomeData();
                    DebugLog.instance.e("Update store ${getIt<CountryService>().store}");
                  }
                }
              }
            },
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                    child: FlippableSvgBackground(
                  assetPath: Assets.svgs.bgGradientHomeDelivery.path,
                )),
                Container(
                  height: Dimens.size40,
                  padding: const EdgeInsets.only(
                      left: Dimens.size16, right: Dimens.size17),
                  child: Row(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        width: Dimens.size28,
                        // Set the width of the circle
                        height: Dimens.size28,
                        // Set the height of the circle
                        decoration: const BoxDecoration(
                          color: AppColors.whiteColor,
                          // Background color of the circle
                          shape:
                              BoxShape.circle, // Makes the container circular
                        ),

                        child: Assets.svgs.icHomeFastDelivery
                            .svg(height: Dimens.size18, width: Dimens.size18),
                      ),
                      const SizedBox(
                        width: Dimens.size8,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            createSpannableText(
                                boldTextStyle:
                                    context.textTheme.headlineMedium?.copyWith(
                                  color: MainConfig.appColors.textWhiteColor,
                                  fontSize: Dimens.size14,
                                  fontWeight: FontWeight.bold,
                                ),
                                defaultTextStyle:
                                    context.textTheme.headlineMedium?.copyWith(
                                  color: MainConfig.appColors.textWhiteColor,
                                  fontSize: Dimens.fontSize12,
                                  fontWeight: FontWeight.w600,
                                ),
                                content: isPickup
                                    ? "${context.appString.pickupFromStoreKey} "
                                        "${productHomeState.selectedAddress?.title}"
                                    : "${context.appString.deliveryToHomeKey} ${getLocalizedAddressType(context, productHomeState.selectedAddress?.addressType)}",
                                boldPhrases: <String>[
                                  isPickup
                                      ? context.appString.pickupKey
                                      : context.appString.deliveryKey
                                ],
                                context: context),
                            CustomTextLabelWidget(
                              overflow: TextOverflow.ellipsis,
                              maxLines: Dimens.maxLines01,
                              label: productHomeState
                                      .selectedAddress?.details ??
                                  (isPickup
                                      ? context.appString.selectPickupStoreKey
                                      : context
                                          .appString.selectDeliveryAddressKey),
                              style: context.textTheme.headlineMedium?.copyWith(
                                  color: MainConfig.appColors.textWhiteColor,
                                  fontSize: Dimens.size10,
                                  fontWeight: FontWeight.normal),
                            )
                          ],
                        ),
                      ),
                      Dimens.size8.widthBox,
                      Assets.svgs.icDownArrowWhite
                          .svg(height: Dimens.size16, width: Dimens.size15)
                    ],
                  ),
                ),
              ],
            ));
      },
    ));
  }
}
