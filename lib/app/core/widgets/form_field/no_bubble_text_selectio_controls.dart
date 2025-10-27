import '../../../../utils/exports.dart';


///NoBubbleTextSelectionControls
class NoBubbleTextSelectionControls extends TextSelectionControls {
  @override
  Offset getHandleAnchor(TextSelectionHandleType type,
      double textLineHeight,) {
    return Offset.zero;
  }

  @override
  bool canSelectAll(TextSelectionDelegate delegate) {
    return true;
  }

  @override
  Size getHandleSize(double textLineHeight) {
    return Size.zero;
  }

  @override
  Widget buildHandle(BuildContext context,
      TextSelectionHandleType type,
      double textLineHeight, [
        VoidCallback? onTap,
      ]) {
    return Container();
  }

  @override
  Widget buildToolbar(BuildContext context,
      Rect globalEditableRegion,
      double textLineHeight,
      Offset selectionMidpoint,
      List<TextSelectionPoint> endpoints,
      TextSelectionDelegate delegate,
      ValueListenable<ClipboardStatus>? clipboardStatus,
      Offset? lastSecondaryTapDownPosition,) {
    return const SizedBox.shrink();
  }
}
