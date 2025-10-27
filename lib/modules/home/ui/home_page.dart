import '../../../../utils/exports.dart';

@RoutePage()
/// Page that displays the main home screen of the application.
class HomePage extends StatelessWidget {
  /// Creates a home page.
  ///
  /// [isFromNotification] Whether the page was opened from a notification.
  const HomePage({super.key, this.isFromNotification = false});

  /// Whether the page was opened from a notification.
  final bool? isFromNotification;

  @override
  Widget build(BuildContext context) {
    return const HomePageWidget();
  }
}
