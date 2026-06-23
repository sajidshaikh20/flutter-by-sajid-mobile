import '../../../../utils/exports.dart';

/// Fires [onLoadMore] when the user scrolls near the bottom of the list.
class TradesPaginationScrollWidget extends StatelessWidget {
  const TradesPaginationScrollWidget({
    super.key,
    required this.onLoadMore,
    required this.child,
  });

  final VoidCallback onLoadMore;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScroll,
      child: child,
    );
  }

  bool _handleScroll(ScrollNotification notification) {
    if (notification is! ScrollEndNotification && notification is! ScrollUpdateNotification) {
      return false;
    }

    final ScrollMetrics metrics = notification.metrics;
    if (metrics.pixels >= metrics.maxScrollExtent * 0.9) {
      onLoadMore();
    }
    return false;
  }
}
