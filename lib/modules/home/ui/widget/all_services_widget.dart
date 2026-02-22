import '../../../../utils/exports.dart';

/// All Services section with category tabs and service grid.
class AllServicesWidget extends StatelessWidget {
  /// Creates an all services widget.
  const AllServicesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (HomeState previous, HomeState current) =>
          previous.selectedServiceTab != current.selectedServiceTab,
      builder: (BuildContext context, HomeState state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimens.space20,
              ),
              child: CustomTextLabelWidget(
                label: 'All Services',
                textAlign: TextAlign.start,
                style: context.textTheme.headlineSmall?.copyWith(
                  color: MainConfig.appColors.textBlackColor,
                  fontSize: Dimens.fontSize16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Dimens.space14.heightBox,
            SizedBox(
              height: Dimens.size36,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: ServiceCategoryTab.tabs.length,
                itemBuilder: (BuildContext context, int index) {
                  final ServiceCategoryTab tab =
                      ServiceCategoryTab.tabs[index];
                  final bool isSelected =
                      tab == state.selectedServiceTab;
                  return GestureDetector(
                    onTap: () => context
                        .read<HomeCubit>()
                        .selectServiceTab(tab),
                    child: Container(
                      margin:  EdgeInsets.only(
                          left: index ==0 ? Dimens.space20:0,
                          right: Dimens.space10),
                      padding: const EdgeInsets.all(
                        Dimens.space10,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? MainConfig.appColors.textBlackColor
                            : AppColors.whiteColor,
                        borderRadius:
                            Dimens.radius6.borderRadius,
                        border: isSelected
                            ? null
                            : Border.all(
                                color: MainConfig
                                    .appColors.textBlackColor
                                    .withValues(
                                        alpha: Dimens.opacity05),
                              ),
                      ),
                      child: Center(
                        child: CustomTextLabelWidget(
                          label: tab.label,
                          style: context
                              .textTheme.labelMedium
                              ?.copyWith(
                                fontSize: Dimens.fontSize12,
                                fontWeight: FontWeight.w500,
                                height: Dimens.size1,
                                color: isSelected
                                    ? AppColors.whiteColor
                                    : MainConfig.appColors
                                        .textBlackColor
                                        .withValues(
                                            alpha:
                                                Dimens.opacity05),
                              ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Dimens.space16.heightBox,
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimens.space20,
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: Dimens.milliseconds300),
                switchInCurve: Curves.easeOut,
                switchOutCurve: Curves.easeOut,
                child: AllServicesContentWidget(
                  key: ValueKey<ServiceCategoryTab>(
                      state.selectedServiceTab),
                  selectedTab: state.selectedServiceTab,
                ),
              ),
            ),
            Dimens.space20.heightBox,
            SizedBox(
              height: Dimens.space47,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      margin:  EdgeInsets.only(
                      left: index ==0 ? Dimens.space20:0,
                  right: Dimens.space10),
                    child: const SendMoneyCard(),
                  );
                },
              ),
            ),
            Dimens.space20.heightBox,
          ],
        );
      },
    );
  }
}
