import '../../../../utils/exports.dart';

/// Shell for the Home tab: only renders [AutoRouter] so nested routes
/// Pattern: Dashboard → HomeWithBottomPageRoute (this) → [HomeRoute, ServiceDetailsRoute].
@RoutePage(name: 'HomeWithBottomPageRoute')
class HomeWithBottomPage extends AutoRouter {
  const HomeWithBottomPage({super.key});
}
