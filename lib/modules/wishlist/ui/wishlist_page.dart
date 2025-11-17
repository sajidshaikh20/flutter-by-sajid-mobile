import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/exports.dart';

@RoutePage()
/// Page that displays the user's wishlist.
class WishListPage extends ConsumerWidget {
  /// Creates a wishlist page.
  const WishListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        ScreenType device = ScreenType.mobile;
        if (constraints.maxWidth >= AppConstant.webPixelWidth) {
          device = ScreenType.desktop;
        } else if (constraints.maxWidth >= AppConstant.mobilePixelWidth) {
          device = ScreenType.tablet;
        }
        return WishlistPageWidget(device: device);
      },
    );
  }
}
