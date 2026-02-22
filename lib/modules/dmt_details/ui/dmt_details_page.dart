import '../../../../utils/exports.dart';
import 'widget/beneficiary_tab_content.dart';

/// Domestic Money Transfer details screen.
///
/// App bar: back + title "Domestic Money Transfer".
/// Tab bar: Beneficiary | Customer Info.
/// Base layout only; tab content is placeholder.
@RoutePage()
class DmtDetailsPage extends StatelessWidget {
  const DmtDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Color greyText = MainConfig.appColors.greyTextColor;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: MainConfig.appColors.backgroundWhiteColor,
        appBar: ServiceDetailsAppBar(
          label: 'Domestic Money Transfer',
          showRightIcon: false,
          onBackTap: () => context.router.maybePop(),
        ),
        body: Column(
          children: <Widget>[
            ColoredBox(
              color: AppColors.whiteColor,
              child: TabBar(
                labelColor: AppColors.blackColor,
                unselectedLabelColor: greyText,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: MainConfig.appColors.primary,
                padding: const EdgeInsets.symmetric(horizontal: Dimens.space20),
                labelStyle: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: Dimens.fontSize16,
                    color: AppColors.blackColor),
                unselectedLabelStyle: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: Dimens.fontSize16,
                  color:
                      AppColors.blackColor.withValues(alpha: Dimens.opacity05),
                ),
                tabs: const <Tab>[
                  Tab(text: 'Beneficiary'),
                  Tab(text: 'Customer Info'),
                ],
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: <Widget>[
                  BeneficiaryTabContent(),
                  _PlaceholderTabContent(label: 'Customer Info'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlaceholderTabContent extends StatelessWidget {
  const _PlaceholderTabContent({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomTextLabelWidget(
        label: '$label content',
        style: context.textTheme.bodyLarge?.copyWith(
          color: MainConfig.appColors.greyTextColor,
        ),
      ),
    );
  }
}
