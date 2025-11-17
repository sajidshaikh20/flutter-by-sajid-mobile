import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/exports.dart';
import '../../../app/providers/providers.dart';

@RoutePage()
/// Page that displays the home categories section with responsive design.
class HomeCategoryPage extends ConsumerWidget {
  /// Creates a home category page.
  const HomeCategoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen to state changes
    ref.listen<HomeCategoryState>(
      homeCategoryNotifierProvider,
      (HomeCategoryState? previous, HomeCategoryState next) {
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
        return HomeCategoryWidget(device: device);
      },
    );
  }
}
