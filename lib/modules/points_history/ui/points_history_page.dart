import '../../../utils/exports.dart';

/// A page that displays the history of loyalty points transactions.
///
/// This page provides a list of past transactions where points were earned, burned, or refunded.
/// It is typically used to show users the history of their points activities and their current balance.
///
/// The page is a [BaseResponsiveView] since it only displays information without requiring any state changes.
@RoutePage()
class PointsHistoryPage extends BaseResponsiveView {
  /// Creates an instance of [PointsHistoryPage].
  ///
  /// This constructor does not require any parameters, and it simply creates the page to display
  /// the points history for the user.
  const PointsHistoryPage({super.key});

  @override
  Widget buildDesktopWidget(BuildContext context) {
    return _buildView(context);
  }

  @override
  Widget buildMobileWidget(BuildContext context) {
    return _buildView(context);
  }

  @override
  Widget buildTabletWidget(BuildContext context) {
    return _buildView(context);
  }

  Widget _buildView(BuildContext context) {
    return BlocProvider<PointsHistoryCubit>(
      create: (BuildContext context) => PointsHistoryCubit(),
      child: Scaffold(
        backgroundColor: MainConfig.appColors.backgroundLightPinkColor,
        body: const PointsHistoryPageWidget(),
      ),
    );
  }
}
