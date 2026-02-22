import '../../../../utils/exports.dart';

/// Shell for the Home tab: only renders [AutoRouter] so nested routes
/// (e.g. [ServiceDetailsRoute]) show inside the tab and the bottom nav stays visible.
/// Pattern: Dashboard → HomeWithBottomPageRoute (this) → [HomeRoute, ServiceDetailsRoute].
@RoutePage(name: 'HomeWithBottomPageRoute')
class HomeWithBottomPage extends AutoRouter {
  const HomeWithBottomPage({super.key});
}
