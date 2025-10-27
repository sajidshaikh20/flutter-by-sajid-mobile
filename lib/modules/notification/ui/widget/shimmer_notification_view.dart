import '../../../../utils/exports.dart';

/// A shimmer effect view displaying a list of notification cards in loading state.
class ShimmerNotificationView extends StatelessWidget {
  /// Creates a `ShimmerNotificationView`.
  const ShimmerNotificationView({super.key});

  @override
  Widget build(BuildContext context) => ShimmerEffect(
    child: ListView.builder(
      shrinkWrap: true,
      padding:  EdgeInsets.zero,
      itemCount: Dimens.itemCount10,
      itemBuilder: (BuildContext context, int index) => const ShimmerNotificationCardWidget(),
    ),
  );
}
