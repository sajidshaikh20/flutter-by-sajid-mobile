import '../../../../utils/exports.dart';

/// Root body for My Trades — checks subscription then shows content or lock screen.
class MyTradesBodyWidget extends StatelessWidget {
  const MyTradesBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: UserProfileService.instance(),
      builder: (BuildContext context, Widget? child) {
        final String role = UserProfileService.instance().roleName.toUpperCase();
        final bool isSubscribed = UserProfileService.instance().isSubscriptionActive;
        if (!isSubscribed && role != 'TRADER' && role != 'MENTOR' && role != 'ADMIN') {
          return const MyTradesLockedWidget();
        }
        return const MyTradesContentWidget();
      },
    );
  }
}

