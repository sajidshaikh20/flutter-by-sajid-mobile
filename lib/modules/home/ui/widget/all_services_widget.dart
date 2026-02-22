import '../../../../utils/exports.dart';

/// All Services section with category tabs and service grid.
class AllServicesWidget extends StatelessWidget {
  /// Creates an all services widget.
  const AllServicesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CustomTextLabelWidget(
          label: 'All Services',
          textAlign: TextAlign.start,
          style: context.textTheme.headlineSmall?.copyWith(
            color: MainConfig.appColors.textBlackColor,
            fontSize: Dimens.fontSize16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Dimens.space14.heightBox,
        SizedBox(
          height: Dimens.size36,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: ServiceCategoryTab.tabs.length,
            itemBuilder: (BuildContext context, int index) {
              final ServiceCategoryTab tab = ServiceCategoryTab.tabs[index];
              final bool isSelected = tab == ServiceCategoryTab.bankingServices;
              return Container(
                margin: const EdgeInsets.only(right: Dimens.space10),
                padding: const EdgeInsets.all(
                  Dimens.space10,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? MainConfig.appColors.textBlackColor
                      : AppColors.whiteColor,
                  borderRadius: Dimens.radius6.borderRadius,
                  border: isSelected
                      ? null
                      : Border.all(
                          color: MainConfig.appColors.textBlackColor
                              .withValues(alpha: Dimens.opacity05),
                        ),
                ),
                child: Center(
                  child: CustomTextLabelWidget(
                    label: tab.label,
                    style: context.textTheme.labelMedium?.copyWith(
                      fontSize: Dimens.fontSize12,
                      fontWeight: FontWeight.w500,
                      height: Dimens.size1,
                      color: isSelected
                          ? AppColors.whiteColor
                          : MainConfig.appColors.textBlackColor
                              .withValues(alpha: Dimens.opacity05),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Dimens.space16.heightBox,
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: Dimens.crossAxisCount3,
          ),
          itemCount: ServiceItemModel.bankingServices.length,
          itemBuilder: (BuildContext context, int index) {
            final ServiceItemModel item =
                ServiceItemModel.bankingServices[index];
            return ServiceGridItemWidget(
              label: item.label,
              icon: item.icon,
            );
          },
        ),
      ],
    );
  }
}
