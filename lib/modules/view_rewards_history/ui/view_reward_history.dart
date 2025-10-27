import '../../../utils/exports.dart';

@RoutePage()
/// Page that displays the reward history for the user.
class ViewRewardHistoryPage extends BaseResponsiveView {
  /// Creates a reward history page.
  const ViewRewardHistoryPage({super.key});

  @override
  Widget buildDesktopWidget(BuildContext context) {
    return _buildView(context,ScreenType.desktop);
  }

  @override
  Widget buildMobileWidget(BuildContext context) {
    return _buildView(context,ScreenType.mobile);
  }

  @override
  Widget buildTabletWidget(BuildContext context) {
    return _buildView(context,ScreenType.tablet);
  }

  /// Builds the reward history view with BlocProvider for the specified device type.
  Widget _buildView(BuildContext context, ScreenType device) {
    return BlocProvider<ViewRewardHistoryCubit>(
        create: (BuildContext context) => ViewRewardHistoryCubit(
            initialState: const ViewRewardHistoryState(
              status: BaseStateStatus.initial,
              count: 0,
            ),
            referEarnRepositoryImpl: ViewRewardHistoryRepositoryImpl())..init(),
        child:  ViewRewardHistoryView(device: device,));
  }
}
