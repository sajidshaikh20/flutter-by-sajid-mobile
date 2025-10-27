import '../../../../utils/exports.dart';

/// A widget that displays loyalty points information on the home screen.
/// 
/// This widget shows the user's current loyalty points and total amount,
/// with a shimmer loading state while data is being fetched.
class HomeLoyaltyPointsWidget extends StatelessWidget {
  /// Creates a [HomeLoyaltyPointsWidget].
  const HomeLoyaltyPointsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (HomeState previous, HomeState current) {
        // Only rebuild when loyalty points API status or data changes
        return previous.apiCallForLoyaltyPoints != current.apiCallForLoyaltyPoints ||
               previous.loyaltyPointsModel != current.loyaltyPointsModel;
      },
      builder: (BuildContext context, HomeState state) {
        if (state.apiCallForLoyaltyPoints == BaseStateStatus.loading) {
          return const HomeLoyaltyPointsShimmer();
        }

        return InkWell(
          splashFactory: NoSplash.splashFactory,
          splashColor: MainConfig.appColors.transparent,
          highlightColor: MainConfig.appColors.transparent,
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          onTap: () async {
            await context.pushRoute(const LoyaltyPointsRoute());
          },
          child: ClipRRect(
            borderRadius: Dimens.radius8.borderRadius,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: FlippableSvgBackground(
                      assetPath: Assets.svgs.bgGradientLoyaltyPoints.path),
                ),
                Container(
                  padding: const EdgeInsets.only(
                      left: Dimens.space10,
                      right: Dimens.space10,
                      top: Dimens.space7,
                      bottom: Dimens.space8),
                  decoration: BoxDecorationExtension.customDecoration(
                    borderRadius: Dimens.radius8.borderRadius,
                  ),
                  child: Row(
                    children: <Widget>[
                      Assets.svgs.icHomeLoyalty
                          .svg(height: Dimens.size35, width: Dimens.size35),
                      const SizedBox(
                        width: Dimens.size8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CustomTextLabelWidget(
                            label: context.appString.loyaltyPointsKey,
                            style: context.textTheme.headlineMedium?.copyWith(
                                color: MainConfig.appColors.textWhiteColor,
                                fontSize: Dimens.size14,
                                height: Dimens.lineHeight16
                                    .toLineHeight(Dimens.fontSize14),
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: Dimens.size4,
                          ),
                        _buildLoyaltyPointsDisplay(context, state),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Builds the loyalty points display with data from API
  Widget _buildLoyaltyPointsDisplay(BuildContext context, HomeState state) {
    if (state.apiCallForLoyaltyPoints == BaseStateStatus.success && 
        (state.loyaltyPointsModel?.data?.isNotEmpty ?? false)) {
      final LoyaltyPointsResponseModel loyaltyData = state.loyaltyPointsModel!.data!.first;
      final String pointsText = '${loyaltyData.totalLoyaltyPoints} Points';
      final String amountText = '${loyaltyData.totalUserAmountForPoint?.toStringAsFixed(2)} ${getIt<LanguageService>().defaultCurrency}';
      final String displayText = '$pointsText = $amountText';
      
      return CustomTextLabelWidget(
        textDirection: TextDirection.ltr,
        label: displayText,
        style: context.textTheme.headlineMedium?.copyWith(
          color: MainConfig.appColors.textWhiteColor,
          fontSize: Dimens.size14,
          height: Dimens.lineHeight18.toLineHeight(Dimens.fontSize14),
          fontWeight: FontWeight.w600,
        ),
      );
    } else {
      // Fallback to default value
      return CustomTextLabelWidget(
        textDirection: TextDirection.ltr,
        style: context.textTheme.headlineMedium?.copyWith(
          color: MainConfig.appColors.textWhiteColor,
          fontSize: Dimens.size14,
          height: Dimens.lineHeight18.toLineHeight(Dimens.fontSize14),
          fontWeight: FontWeight.w600,
        ),
      );
    }
  }
}
