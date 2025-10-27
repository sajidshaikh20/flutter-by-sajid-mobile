import '../../../utils/exports.dart';

/// Page that displays when there is no internet connectivity.
class NoInternetPage extends BaseResponsiveView {
  /// Creates a no internet page.
  const NoInternetPage({required this.onTryAgain, super.key});

  /// Callback function called when the user taps the try again button.
  final Function() onTryAgain;

  @override
  Widget buildDesktopWidget(BuildContext context) =>
      _buildView(context, ScreenType.desktop);

  @override
  Widget buildMobileWidget(BuildContext context) =>
      _buildView(context, ScreenType.mobile);

  @override
  Widget buildTabletWidget(BuildContext context) =>
      _buildView(context, ScreenType.tablet);

  Widget _buildView(BuildContext context, ScreenType device) =>
      NoInternetWidget(
        onTryAgain: onTryAgain,
        device: device,
        childWidget: const SizedBox(),
      );
}
