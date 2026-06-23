import '../../../../utils/exports.dart';

/// Shown when the user has no active subscription on the Trades tab.
class TradesLockedWidget extends StatelessWidget {
  const TradesLockedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Color pageBg =
        context.isDark ? AppColors.backgroundDark : AppColors.backgroundLight;

    return Scaffold(
      backgroundColor: pageBg,
      body: const SafeArea(
        child: Column(
          children: <Widget>[
            HomeHeaderAppBar(
              showProfileImage: false,
              showNotification: false,
              title: 'Trading Signals',
              subtitle: 'Explore high-quality trades from professional traders',
            ),
            Expanded(
              child: SubscriptionLockWidget(
                title: 'Unlock Trading Signals',
                subtitle: 'Subscribe to view high-probability signals from professional traders.',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
