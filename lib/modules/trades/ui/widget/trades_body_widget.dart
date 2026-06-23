import '../../../../utils/exports.dart';

/// Root body for Trading Signals — checks subscription then shows content or lock screen.
class TradesBodyWidget extends StatelessWidget {
  const TradesBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: UserProfileService.instance(),
      builder: (BuildContext context, Widget? child) {
        final bool isSubscribed = UserProfileService.instance().isSubscriptionActive;
        if (!isSubscribed) {
          return const TradesLockedWidget();
        }
        return const TradesContentWidget();
      },
    );
  }
}
