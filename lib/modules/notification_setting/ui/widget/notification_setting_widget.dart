import '../../../../utils/exports.dart';

/// Widget that displays notification settings with toggle switches.
class NotificationSettingWidget extends StatefulWidget {
  /// Creates a notification setting widget.
  const NotificationSettingWidget({super.key});

  @override
  State<NotificationSettingWidget> createState() => _NotificationSettingWidgetState();
}

class _NotificationSettingWidgetState extends State<NotificationSettingWidget> {
  @override
  Widget build(BuildContext context) {
    return _buildView(context, ScreenType.desktop);
  }

  Widget buildMobileWidget(BuildContext context) {
    return _buildView(context, ScreenType.mobile);
  }

  Widget buildTabletWidget(BuildContext context) {
    return _buildView(context, ScreenType.tablet);
  }

  Widget _buildView(BuildContext context, ScreenType device) {
    return Scaffold(
        backgroundColor: MainConfig.appColors.backgroundPinkColor,
        body: Column(
          children: <Widget>[
            ProductDetailsAppBar(
              titleText: context.appString.notificationsSettingsKey,
              isLastWidgetDisplay: false,
              prefixIcon: Assets.svgs.icBack
                  .svg(height: Dimens.size24, width: Dimens.size24),
            ),
             Padding(
                padding: const EdgeInsets.all(Dimens.size16),
                child: DecoratedBox(
                  decoration: BoxDecorationExtension.customDecoration(
                    color: MainConfig.appColors.backgroundWhite,
                    borderRadius: Dimens.radius8.borderRadius,
                    border: Border.all(
                      color: MainConfig.appColors.lightGreyColor,
                      width: Dimens.borderWidth05,
                    ),
                  ),
                  child: BlocBuilder<NotificationSettingCubit,
                      NotificationSettingState>(
                    buildWhen: (NotificationSettingState previous, NotificationSettingState current) {
                      // Only rebuild when notification setting values change
                      if (previous is NotificationSettingInitial && current is NotificationSettingInitial) {
                        return previous.orderStatuses != current.orderStatuses ||
                               previous.loyaltyPoints != current.loyaltyPoints ||
                               previous.promotionOffers != current.promotionOffers;
                      }
                      return true; // Rebuild if state type changes
                    },
                    builder:
                        (BuildContext context, NotificationSettingState state) {
                      return Column(
                        children: <Widget>[
                          // Notification Permission Status Section
                         // _buildNotificationPermissionSection(context),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Dimens.size8),
                            child: CustomDivider(
                              color: MainConfig.appColors.dividerColor,
                              height: 1,
                            ),
                          ),
                          buildNotificationSection(
                            title: context.appString.orderStatuesKey,
                            value: (state as NotificationSettingInitial).orderStatuses,
                            onChanged: (bool value) {
                              context
                                  .read<NotificationSettingCubit>()
                                  .toggleOrderStatuses(value: value);
                              // Trigger the event when the toggle is changed
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Dimens.size8),
                            child: CustomDivider(
                              color: MainConfig.appColors.dividerColor,
                              height: 1,
                            ),
                          ),

                          //#TODO as now this feature is not give to the cleint
                          /*buildNotificationSection(
                            title: context.appString.loyaltyPointsKey,
                            value: (state as NotificationSettingInitial).loyaltyPoints,
                            onChanged: (bool value) {
                              context
                                  .read<NotificationSettingCubit>()
                                  .toggleLoyaltyPoints(value: value);
                              // Trigger the event when the toggle is changed
                            },
                          ),*/
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Dimens.size8),
                            child: CustomDivider(
                              color: MainConfig.appColors.dividerColor,
                              height: 1,
                            ),
                          ),
                          buildNotificationSection(
                            title: context.appString.promotionsOffersKey,
                            value: state.promotionOffers,
                            onChanged: (bool value) {
                              context
                                  .read<NotificationSettingCubit>()
                                  .togglePromotionOffers(value: value);
                              // Trigger the event when the toggle is changed
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
          ],
        ));
  }
}
