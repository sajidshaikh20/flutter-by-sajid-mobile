import '../../../../utils/exports.dart';

/// Shown when the user has no active subscription on My Trades.
class MyTradesLockedWidget extends StatelessWidget {
  const MyTradesLockedWidget({super.key});

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
              title: 'My Trades',
              subtitle: 'Track and manage your active and past trades',
            ),
            Expanded(
              child: SubscriptionLockWidget(
                title: 'Unlock My Trades',
                subtitle: 'Subscribe to view and track your customized trade history.',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
