import '../../../utils/exports.dart';

/// Shows a modal bottom sheet with drag handle and custom [child] content.
/// Reusable across the app – pass your UI as [child].
Future<T?> showCommonBottomSheet<T>({
  required BuildContext context,
  required Widget child,
  bool isScrollControlled = true,
}) async {
  return showModalBottomSheet<T>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: isScrollControlled,
    builder: (BuildContext context) => CommonBottomSheetContent(child: child),
  );
}

/// Bottom sheet content: drag handle + [child]. Use via [showCommonBottomSheet].
class CommonBottomSheetContent extends StatelessWidget {
  const CommonBottomSheetContent({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(Dimens.radius16),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const _DragHandle(),
            child,
          ],
        ),
      ),
    );
  }
}

/// Sub-widget: draggable handle bar at the top of the bottom sheet.
class _DragHandle extends StatelessWidget {
  const _DragHandle();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Dimens.space10),
      child: Container(
        width: Dimens.size30,
        height: Dimens.size2,
        decoration: BoxDecoration(
          color: AppColors.greyBorderColor,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}
