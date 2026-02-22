import '../../../../utils/exports.dart';

/// All Services section with category tabs and service grid.
class AllServicesWidget extends StatelessWidget {
  /// Creates an all services widget.
  const AllServicesWidget({super.key});

  static const List<String> _tabs = <String>[
    'Banking Services',
    'Recharge And Bill Pay',
    'Tour & Travel',
  ];

  static const List<_ServiceItem> _services = <_ServiceItem>[
    _ServiceItem(label: 'AEPS Aadhaar Pay', icon: Icons.fingerprint),
    _ServiceItem(label: 'MATM', icon: Icons.atm),
    _ServiceItem(label: 'DMT', icon: Icons.swap_horiz),
    _ServiceItem(label: 'Credit Card', icon: Icons.credit_card),
    _ServiceItem(label: 'Account Open', icon: Icons.person_outline),
    _ServiceItem(label: 'Loan', icon: Icons.account_balance_wallet),
  ];

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
            fontWeight: FontWeight.w700,
          ),
        ),
        Dimens.space14.heightBox,
        SizedBox(
          height: Dimens.size40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _tabs.length,
            itemBuilder: (BuildContext context, int index) {
              final bool isSelected = index == 0;
              return Container(
                margin: const EdgeInsets.only(right: Dimens.space10),
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimens.space16,
                  vertical: Dimens.space8,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? MainConfig.appColors.textBlackColor
                      : AppColors.whiteColor,
                  borderRadius: Dimens.radius8.borderRadius,
                  border: isSelected
                      ? null
                      : Border.all(
                          color: MainConfig.appColors.borderLightGreyColor,
                        ),
                ),
                child: Center(
                  child: CustomTextLabelWidget(
                    label: _tabs[index],
                    style: context.textTheme.labelMedium?.copyWith(
                      fontSize: Dimens.fontSize12,
                      fontWeight: FontWeight.w500,
                      color: isSelected
                          ? AppColors.whiteColor
                          : MainConfig.appColors.textBlackColor,
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
            crossAxisCount: 3,
            mainAxisSpacing: Dimens.space16,
            crossAxisSpacing: Dimens.space16,
            childAspectRatio: Dimens.ratio068,
          ),
          itemCount: _services.length,
          itemBuilder: (BuildContext context, int index) {
            final _ServiceItem item = _services[index];
            return _ServiceGridItem(
              label: item.label,
              icon: item.icon,
            );
          },
        ),
      ],
    );
  }
}

class _ServiceItem {
  const _ServiceItem({required this.label, required this.icon});

  final String label;
  final IconData icon;
}

class _ServiceGridItem extends StatelessWidget {
  const _ServiceGridItem({
    required this.label,
    required this.icon,
  });

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: Dimens.size60,
          height: Dimens.size60,
          decoration: BoxDecoration(
            color: MainConfig.appColors.mainColor
                .withValues(alpha: Dimens.ratio015),
            borderRadius: Dimens.radius12.borderRadius,
          ),
          child: Icon(
            icon,
            color: MainConfig.appColors.mainColor,
            size: Dimens.size28,
          ),
        ),
        Dimens.space8.heightBox,
        CustomTextLabelWidget(
          label: label,
          maxLines: 2,
          style: context.textTheme.labelSmall?.copyWith(
            fontSize: Dimens.fontSize11,
            fontWeight: FontWeight.w500,
            color: MainConfig.appColors.textBlackColor,
          ),
        ),
      ],
    );
  }
}
