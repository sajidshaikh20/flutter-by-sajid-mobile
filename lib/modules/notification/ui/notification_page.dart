import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/exports.dart';
import '../../../app/providers/providers.dart';

@RoutePage()
/// Page that displays the list of notifications with read/unread status.
class NotificationPage extends ConsumerWidget {
  /// Creates a notification page.
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen to state changes
    ref.listen<NotificationState>(
      notificationNotifierProvider,
      (NotificationState? previous, NotificationState next) {
        if (next.msg.isNotNullOrEmpty) {
          displaySnackBar(next.msg.toString(), context);
        }
      },
    );

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        ScreenType device = ScreenType.mobile;
        if (constraints.maxWidth >= AppConstant.webPixelWidth) {
          device = ScreenType.desktop;
        } else if (constraints.maxWidth >= AppConstant.mobilePixelWidth) {
          device = ScreenType.tablet;
        }
        return NotificationPageWidget(device: device);
      },
    );
  }
}
