import '../../../utils/exports.dart';

@RoutePage()
/// Page that displays the refer a friend functionality with sharing options.
class ReferAFriendPage extends BaseResponsiveView {
  /// Creates a refer a friend page.
  const ReferAFriendPage({super.key});

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

  /// Builds the refer a friend view with BlocProvider for the specified device type.
  Widget _buildView(BuildContext context, ScreenType device) {
    return BlocProvider<ReferEarnCubit>(
        create: (BuildContext context) => ReferEarnCubit(
            initialState: const ReferEarnState(status: BaseStateStatus.initial),
            referEarnRepositoryImpl: ReferEarnRepositoryImpl()),
        child:  ReferFriendView(device: device,));
  }

}
