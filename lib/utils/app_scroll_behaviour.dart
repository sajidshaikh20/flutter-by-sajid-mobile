import 'app_scroll_behaviour.dart';
export 'exports.dart';
/// Custom scroll behavior that allows dragging with touch, mouse, and trackpad.
class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => <PointerDeviceKind>{
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.trackpad,
  };
}
